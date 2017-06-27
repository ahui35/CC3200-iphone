//
//  TGDBManager.m
//  TianGong
//
//  Created by xbwu on 15/10/5.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "TGDBManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "TGUserCenter.h"

@implementation TGDBManager

+ (NSString *)dbPath {
	static NSString *path = nil;
	if (path == nil) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docDir = [paths objectAtIndex:0];
		path = [docDir stringByAppendingPathComponent:@"tgzn.db"];
		NSLog(@"%@", path);
    #ifdef DEBUG
      path = [[NSBundle mainBundle] pathForResource:@"tgzn" ofType:@"db"];
    #endif
    if ([[TGUserCenter defaultCenter].userName isEqualToString:DemoUserName]
        && [[TGUserCenter defaultCenter].password isEqualToString:DemoPassword]) {
      path = [[NSBundle mainBundle] pathForResource:@"tgzn" ofType:@"db"];
    }
  }
	return path;
}

+ (FMDatabaseQueue *)databaseQueue {
	static FMDatabaseQueue *queue = nil;
	if (!queue){
		queue = [FMDatabaseQueue databaseQueueWithPath:[self dbPath]];
	}
	return queue;
}

+ (NSArray *)allFloors {
	NSMutableArray *floors = [[NSMutableArray alloc] init];
	FMDatabaseQueue *queue = [self databaseQueue];
	[queue inDatabase:^(FMDatabase *db) {
		
		NSString *sql = @"SELECT * FROM floors";
		FMResultSet *s = [db executeQueryWithFormat:sql];
		while ([s next]) {
			TGFloor *floor = [[TGFloor alloc] init];
			floor.floorId = [s intForColumn:@"myfloorid"];
			floor.floorName = [s stringForColumn:@"floorname"];
			[floors addObject:floor];
		}
		[s close];
		
	}];
	return floors;
}

+ (NSArray *)roomsForFloor:(NSInteger)floorid {
	NSMutableArray *rooms = [[NSMutableArray alloc] init];
	FMDatabaseQueue *queue = [self databaseQueue];
	[queue inDatabase:^(FMDatabase *db) {
		
		NSString *sql = @"SELECT * FROM rooms where floorid=%d";
		FMResultSet *s = [db executeQueryWithFormat:sql, floorid];
		while ([s next]) {
			TGRoom *room = [[TGRoom alloc] init];
			room.floorId = [s intForColumn:@"floorid"];
			room.roomId = [s intForColumn:@"myroomid"];
			room.roomName = [s stringForColumn:@"roomname"];
      room.style = [s intForColumn:@"style"];
			[rooms addObject:room];
		}
		[s close];
		
	}];
	return rooms;
}


/*
 1	开关灯类
 2	调光灯类
 3	窗帘类
 4	播放器类
 5	功放类
 6	投影仪
 7	空调类
 8	背景音乐类
 9	地暖类
	摄像头单独一张表
*/
+ (NSArray *)equipsForRoom:(NSInteger)roomid {
	NSArray *icons = [NSArray arrayWithObjects:@"menu-0",
																						 @"menu-1",
																						 @"menu-6",
																						 @"menu-7",
																						 @"menu-8",
																						 @"menu-2",
																						 @"menu-4",
																						 @"menu-3", nil];
	NSMutableArray *equips = [[NSMutableArray alloc] init];
	FMDatabaseQueue *queue = [self databaseQueue];
	for (int i = 2; i < 10; i++) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
		[dict setObject:[icons objectAtIndex:i - 2] forKey:@"iconName"];
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[dict setObject:array forKey:@"equips"];
		[equips addObject:dict];
		[queue inDatabase:^(FMDatabase *db) {
			FMResultSet *s = nil;
			if (i == 2) {
				NSString *sql = @"SELECT * FROM equips where roomid=%d and (equipstyle=%d or equipstyle=%d)";
				s = [db executeQueryWithFormat:sql, roomid, 1, 2];
			}
			else {
				NSString *sql = @"SELECT * FROM equips where roomid=%d and equipstyle=%d";
				s = [db executeQueryWithFormat:sql, roomid, i];
			}
			
			while ([s next]) {
				TGEquip *equip = [[TGEquip alloc] init];
				equip.roomid = [s intForColumn:@"roomid"];
				equip.equipaddr = [s intForColumn:@"equipaddr"];
				equip.equipstyle = [s intForColumn:@"equipstyle"];
				equip.substyle = [s intForColumn:@"substyle"];
				equip.equipName = [s stringForColumn:@"equipname"];
				[array addObject:equip];
			}
			[s close];
			
		}];
	}
  
  //摄像头
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  [dict setObject:@"menu-5" forKey:@"iconName"];
  NSMutableArray *array = [[NSMutableArray alloc] init];
  [dict setObject:array forKey:@"equips"];
  [equips addObject:dict];
  [queue inDatabase:^(FMDatabase *db) {
    FMResultSet *s = nil;
    NSString *sql = @"SELECT * FROM videos where roomid=%d";
    s = [db executeQueryWithFormat:sql, roomid];
    while ([s next]) {
      TGEquip *equip = [[TGEquip alloc] init];
      equip.roomid = [s intForColumn:@"roomid"];
      equip.equipaddr = [s intForColumn:@"myvideoid"];
      equip.equipstyle = 10;
      equip.substyle = 0;
      equip.equipName = [s stringForColumn:@"videoname"];
      equip.ddns = [s stringForColumn:@"ddns"];
      equip.port = [s intForColumn:@"port"];
      equip.password = [s stringForColumn:@"password"];
      equip.account = [s stringForColumn:@"account"];
      [array addObject:equip];
    }
    [s close];
    
		}];
  
	NSMutableArray *arrayToDelete = [[NSMutableArray alloc] init];
	for (int i = 0; i < equips.count; i++) {
		NSDictionary *dict = [equips objectAtIndex:i];
		if ([[dict objectForKey:@"equips"] count] == 0) {
			[arrayToDelete addObject:dict];
		}
	}
	[equips removeObjectsInArray:arrayToDelete];
	return equips;
}

+ (NSArray *)scenesForRoom:(NSInteger)roomId {
	NSMutableArray *scenes = [[NSMutableArray alloc] init];
	FMDatabaseQueue *queue = [self databaseQueue];
	[queue inDatabase:^(FMDatabase *db) {
		
		NSString *sql = @"SELECT * FROM scenes where roomid=%d";
		FMResultSet *s = [db executeQueryWithFormat:sql, roomId];
		while ([s next]) {
			TGScene *scene = [[TGScene alloc] init];
			scene.roomid = [s intForColumn:@"roomid"];
			scene.mysceneid = [s intForColumn:@"mysceneid"];
			scene.scenename = [s stringForColumn:@"scenename"];
			scene.sceneaddr = [s intForColumn:@"sceneaddr"];
			[scenes addObject:scene];
		}
		[s close];
		
	}];
	return scenes;
}

@end
