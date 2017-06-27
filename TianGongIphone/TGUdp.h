//
//  TGUdp.h
//  TianGong
//
//  Created by xbwu on 15/10/7.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "GCDAsyncUdpSocket.h"

#define TGDevideSyncNotification @"TGDevideSyncNotification"

typedef void(^TGUdpSendResult)(BOOL successed);

@interface TGUdp : NSObject

@property (nonatomic, strong) NSString *host;
@property (nonatomic, assign) NSUInteger port;

@property (nonatomic, copy) TGUdpSendResult result;

+ (TGUdp *)defaultUdp;
- (void)restart;
- (void)startFind;

- (void)sendControlWithEquip:(TGEquip *)equip action:(NSString *)action value:(float)value;

- (void)sendSceneWithEquip:(TGEquip *)equip action:(NSString *)action value:(float)value;

- (void)loginWithName:(NSString *)name password:(NSString *)password;

- (NSMutableDictionary *)statusForRoomID:(NSInteger)roomid
																	nodeId:(NSInteger)nodeid
																	 style:(NSInteger)style;

- (void)printfStatus;

@end
