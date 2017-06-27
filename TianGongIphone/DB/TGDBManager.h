//
//  TGDBManager.h
//  TianGong
//
//  Created by xbwu on 15/10/5.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DBRefreshNotification @"DBRefreshNotification"

#import "TGRoom.h"
#import "TGFloor.h"
#import "TGEquip.h"
#import "TGScene.h"

@interface TGDBManager : NSObject

+ (NSString *)dbPath;
+ (NSArray *)allFloors;
+ (NSArray *)roomsForFloor:(NSInteger)floorid;
+ (NSArray *)equipsForRoom:(NSInteger)roomid;
+ (NSArray *)scenesForRoom:(NSInteger)roomId;

@end
