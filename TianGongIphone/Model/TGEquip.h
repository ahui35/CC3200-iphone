//
//  TGEquip.h
//  TianGong
//
//  Created by xbwu on 15/10/6.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGEquip : NSObject

@property (nonatomic, assign) NSInteger equipstyle;
@property (nonatomic, assign) NSInteger substyle;
@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger equipaddr;
@property (nonatomic, strong) NSString *equipName;

//摄像头用
@property (nonatomic, strong) NSString *ddns;
@property (nonatomic, assign) NSInteger port;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;

@end
