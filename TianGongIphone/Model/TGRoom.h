//
//  TGRoom.h
//  TianGong
//
//  Created by xbwu on 15/10/6.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGRoom : NSObject

@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger floorId;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, assign) NSInteger style;

@end
