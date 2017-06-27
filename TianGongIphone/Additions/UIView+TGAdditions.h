//
//  UIView+MGAdditions.h
//  Manga
//
//  Created by xbwu on 15/9/14.
//  Copyright (c) 2015年 唐艺源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TGAdditions)

@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign,	readonly) CGFloat x;
@property (nonatomic, assign, readonly) CGFloat y;

- (void)removeAllSubViews;

@end
