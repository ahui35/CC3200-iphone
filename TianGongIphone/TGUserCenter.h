//
//  TGUserCenter.h
//  TianGong
//
//  Created by xbwu on 15/10/13.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TGLoginSuccessNotification @"TGLoginSuccessNotification"
#define DemoUserName @"damon"
#define DemoPassword @"123456"

@interface TGUserCenter : NSObject

+ (TGUserCenter*)defaultCenter;

@property (nonatomic, assign) BOOL isLogined;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *ip1; //外网ip
@property (nonatomic, strong) NSString *ddns;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *port; //端口号

@end
