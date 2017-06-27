//
//  TGUdp.m
//  TianGong
//
//  Created by xbwu on 15/10/7.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "TGUdp.h"
#import "CCAlertView.h"
#import "TGUserCenter.h"

#define TimeOutSecond 3

#define MAXCountForFind 5

@interface TGUdp () {
	GCDAsyncUdpSocket *udpSocket;
	BOOL sending;
	NSTimer *timer;
	NSTimer *finderTimer;
	NSDictionary *sendingDict;
	
	NSMutableDictionary *syncInfo;
	NSInteger countForFind;
}

@end

@implementation TGUdp

static TGUdp *udp = nil;

+ (TGUdp *)defaultUdp {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		udp = [[TGUdp alloc] init];
	});
	return udp;
}

- (void)printfStatus {
	NSLog(@"%@", syncInfo);
}

- (id)init {
	self = [super init];
	if (self) {
    syncInfo = [[NSMutableDictionary alloc] init];
    
    _port = 20000;
    udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if (![udpSocket bindToPort:10000 error:&error])
    {
      NSLog(@"Error binding: %@", error);
    }
    [udpSocket enableBroadcast:YES error:&error];
    if (![udpSocket beginReceiving:&error])
    {
      NSLog(@"Error receiving: %@", error);
    }
    [udpSocket joinMulticastGroup:@"224.0.0.2" error:&error];
  }
	return self;
}

- (void)restart {
	NSError *error = nil;
	if (![udpSocket bindToPort:10000 error:&error])
	{
		NSLog(@"Error binding: %@", error);
	}
	if (![udpSocket beginReceiving:&error])
	{
		NSLog(@"Error receiving: %@", error);
	}
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address {
	
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error {
	
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
	
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
	
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock
	 didReceiveData:(NSData *)data
			fromAddress:(NSData *)address
withFilterContext:(id)filterContext {
	if (data.length == 0) {
		return;
	}
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
																											 options:NSJSONReadingMutableContainers
																												 error:NULL];
	if ([[dict objectForKey:@"opt"] isEqualToString:@"find"]) {
		[TGUserCenter defaultCenter].ip = [dict objectForKey:@"ip"];
		[TGUserCenter defaultCenter].ddns = [dict objectForKey:@"ddns"];
		
		[finderTimer invalidate];
		finderTimer = nil;
	}
	if ([[dict objectForKey:@"opt"] isEqualToString:@"sync"]) { //同步
		NSArray *array = [dict objectForKey:@"equips"];
		for (NSDictionary *dict in array) {
			NSInteger roomid = [[dict objectForKey:@"roomid"] integerValue];
      NSInteger style = [[dict objectForKey:@"style"] integerValue];
      NSInteger nodeid = [[dict objectForKey:@"nodeid"] integerValue];
			NSMutableDictionary *info = [syncInfo objectForKey:@(roomid)];
			if (info == nil) {
				info = [[NSMutableDictionary alloc] init];
				[syncInfo setObject:info forKey:@(roomid)];
			}
      NSMutableDictionary *subInfo = [info objectForKey:@(style)];
      if (subInfo == nil) {
        subInfo = [[NSMutableDictionary alloc] init];
        [info setObject:subInfo forKey:@(style)];
      }
			[subInfo removeObjectForKey:@(nodeid)];
			NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:[dict objectForKey:@"status"]];
			[subInfo setObject:temp forKey:[dict objectForKey:@"nodeid"]];
		}
		if (array.count > 0) {
			[[NSNotificationCenter defaultCenter] postNotificationName:TGDevideSyncNotification object:nil];
		}
	}
	else  {
		if (CommandMatch(dict, sendingDict)) {
			sending = NO;
			[timer invalidate];
			timer = nil;
			
			if ([[dict objectForKey:@"opt"] isEqualToString:@"login"]) {  //登陆
				if ([[dict objectForKey:@"status"] isEqualToString:@"sussess"]) {  //成功
					[TGUserCenter defaultCenter].isLogined = YES;
					[TGUserCenter defaultCenter].userName = [dict objectForKey:@"user"];
					[TGUserCenter defaultCenter].password = [dict objectForKey:@"password"];
					[[NSNotificationCenter defaultCenter] postNotificationName:TGLoginSuccessNotification
																															object:nil];
					[self syncAllRooms];
					
					if (self.result) {
						self.result(YES);
					}
				}
				else {
					
					if (self.result) {
						self.result(NO);
					}
					
					[[CCAlertView sharedAlert] showInView:[[[UIApplication sharedApplication] delegate] window]
																					title:@"登陆失败"
																			 animated:YES];
					[[CCAlertView sharedAlert] hide:YES afterDelay:1];
				}
			}
			else { //control 或者sence
				if ([[dict objectForKey:@"value"] isEqualToString:@"ok"]) {
					if (self.result) {
						self.result(YES);
					}
				}
				else {
					if (self.result) {
						self.result(NO);
					}
				
					[[CCAlertView sharedAlert] showInView:[[[UIApplication sharedApplication] delegate] window]
																					title:@"操作失败"
																			 animated:YES];
					[[CCAlertView sharedAlert] hide:YES afterDelay:1];
				}
			}
		}
		else {
			//丢弃处理
		}
	}
}

- (NSMutableDictionary *)statusForRoomID:(NSInteger)roomid
																	nodeId:(NSInteger)nodeid
																	 style:(NSInteger)style {
	
	NSMutableDictionary *info = [syncInfo objectForKey:@(roomid)];
	if (info == nil) {
		info = [[NSMutableDictionary alloc] init];
		[syncInfo setObject:info forKey:@(roomid)];
	}
	NSMutableDictionary *subInfo = [info objectForKey:@(style)];
	if (subInfo == nil) {
		subInfo = [[NSMutableDictionary alloc] init];
		[info setObject:subInfo forKey:@(style)];
	}
	NSMutableDictionary *status = [subInfo objectForKey:@(nodeid)];
	if (status == nil) {
		status = [[NSMutableDictionary alloc] init];
		[subInfo setObject:status forKey:@(nodeid)];
	}
	return status;
}

- (void)syncAllRooms {
	[syncInfo removeAllObjects];
	
	NSArray *floors = [TGDBManager allFloors];
	for (TGFloor *floor in floors) {
		NSArray *rooms = [TGDBManager roomsForFloor:floor.floorId];
		for (TGRoom *room in rooms) {
			NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
			[dict setObject:@"tgzn" forKey:@"ffid"];
			[dict setObject:@"sync" forKey:@"opt"];
			[dict setObject:@(room.roomId) forKey:@"roomid"];
			NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
			[self sendData:data toHost:_host port:_port];
		}
	}
}

bool CommandMatch(NSDictionary *dict1, NSDictionary *dict2) {
	if ([[dict1 objectForKey:@"opt"] isEqualToString:@"login"]
			&& [[dict1 objectForKey:@"opt"] isEqualToString:[dict2 objectForKey:@"opt"]]) {
		return true;
	}
	if ([[dict1 objectForKey:@"opt"] isEqualToString:@"control"]
			&& [[dict1 objectForKey:@"opt"] isEqualToString:[dict2 objectForKey:@"opt"]]) {
		if ([[dict1 objectForKey:@"roomid"] intValue] == [[dict2 objectForKey:@"roomid"] intValue]
				&& [[dict1 objectForKey:@"style"] intValue] == [[dict2 objectForKey:@"style"] intValue]
				&& [[dict1 objectForKey:@"nodeid"] intValue] == [[dict2 objectForKey:@"nodeid"] intValue]
				&& [[dict1 objectForKey:@"roomid"] intValue] == [[dict2 objectForKey:@"roomid"] intValue]) {
			return true;
		}
	}
	if ([[dict1 objectForKey:@"opt"] isEqualToString:@"scene"]
			&& [[dict1 objectForKey:@"opt"] isEqualToString:[dict2 objectForKey:@"opt"]]) {
		if ([[dict1 objectForKey:@"roomid"] intValue] == [[dict2 objectForKey:@"roomid"] intValue]
				&& [[dict1 objectForKey:@"nodeid"] intValue] == [[dict2 objectForKey:@"nodeid"] intValue]) {
			return true;
		}
	}
	return false;
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error {
	
}

- (void)sendData:(NSData *)data toHost:(NSString *)host port:(uint16_t)port {
	if (_host == nil || _host.length == 0) {
		return;
	}
	[udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:0];
}

- (void)sendControlWithEquip:(TGEquip *)equip action:(NSString *)action value:(float)value {
	if (sending) { //当前仅有1个请求
		return;
	}
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	[dict setObject:@"tgzn" forKey:@"ffid"];
	[dict setObject:@"control" forKey:@"opt"];
	[dict setObject:@(equip.roomid) forKey:@"roomid"];
	[dict setObject:@(equip.equipstyle) forKey:@"style"];
	[dict setObject:@(equip.equipaddr) forKey:@"nodeid"];
	if (action) {
		[dict setObject:action forKey:@"action"];
	}
	if (value >= 0) {
		[dict setObject:@(value) forKey:@"value"];
	}
	NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
	
	[self sendData:data toHost:_host port:_port];
	
	//音量不判断超时
	if ([action isEqualToString:@"vol+"] || [action isEqualToString:@"vol-"]) {
		sending = NO;
		sendingDict = nil;
    NSLog(@"音量发送");
		return;
	}
	
	sending = YES;
	sendingDict = dict;
	
	timer = [NSTimer scheduledTimerWithTimeInterval:TimeOutSecond
																					 target:self
																				 selector:@selector(timeout:)
																				 userInfo:dict
																					repeats:NO];
}

- (void)loginWithName:(NSString *)name password:(NSString *)password {
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	[dict setObject:@"tgzn" forKey:@"ffid"];
	[dict setObject:@"login" forKey:@"opt"];
	[dict setObject:name forKey:@"user"];
	[dict setObject:password forKey:@"password"];
	
	NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
	[self sendData:data toHost:_host port:_port];
	
	sending = YES;
	sendingDict = dict;
	
	timer = [NSTimer scheduledTimerWithTimeInterval:TimeOutSecond
																					 target:self
																				 selector:@selector(timeout:)
																				 userInfo:dict
																					repeats:NO];
}

- (void)sendSceneWithEquip:(TGEquip *)equip action:(NSString *)action value:(float)value {
	if (sending) { //当前仅有1个请求
		return;
	}
	self.result = nil;
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	[dict setObject:@"tgzn" forKey:@"ffid"];
	[dict setObject:@"scene" forKey:@"opt"];
	[dict setObject:@(equip.roomid) forKey:@"roomid"];
	[dict setObject:@(equip.equipaddr) forKey:@"nodeid"];
	NSData *data = [NSJSONSerialization dataWithJSONObject:dict
																								 options:NSJSONWritingPrettyPrinted error:NULL];
	[self sendData:data toHost:_host port:_port];
	
	sending = YES;
	sendingDict = dict;

	timer = [NSTimer scheduledTimerWithTimeInterval:TimeOutSecond
																					 target:self
																				 selector:@selector(timeout:)
																				 userInfo:dict
																					repeats:NO];
}

- (void)timeout:(NSTimer *)t {
	sending = NO;
  NSString *string = @"操作超时";
#ifdef DEBUG
  string = [NSString stringWithFormat:@"操作超时-%@", [sendingDict objectForKey:@"action"]];
#endif
	[[CCAlertView sharedAlert] showInView:[[[UIApplication sharedApplication] delegate] window]
                                  title:string
															 animated:YES];
	[[CCAlertView sharedAlert] hide:YES afterDelay:1];
}

- (void)startFind {
	countForFind = 0;
	if ([TGUserCenter defaultCenter].ip.length != 0 || [TGUserCenter defaultCenter].ddns.length != 0) {
		return;
	}
	finderTimer = [NSTimer scheduledTimerWithTimeInterval:2.5
																								 target:self
																							 selector:@selector(find)
																							 userInfo:nil
																								repeats:YES];
	[self find];
}

- (void)find {
	if (countForFind == MAXCountForFind) {
		[finderTimer invalidate];
		finderTimer = nil;
		return;
	}
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	[dict setObject:@"tgzn" forKey:@"ffid"];
	[dict setObject:@"find" forKey:@"opt"];
	NSData *data = [NSJSONSerialization dataWithJSONObject:dict
																								 options:NSJSONWritingPrettyPrinted error:NULL];
	[udpSocket sendData:data toHost:@"255.255.255.255" port:20000 withTimeout:-1 tag:0];
	countForFind++;
}

@end
