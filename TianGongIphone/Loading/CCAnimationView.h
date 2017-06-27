//
//  CCAnimationView.h
//  CYChinese
//
//  Created by xbwu on 14-5-27.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCAnimationView : CCPopView

@property (nonatomic, strong) NSArray *animationImages;

+ (CCAnimationView *)sharedAnimation;

@end
