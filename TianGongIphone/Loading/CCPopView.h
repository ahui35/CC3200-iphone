//
//  CCPopView.h
//  CYChinese
//
//  Created by xbwu on 14-5-8.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPopView : UIView

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) int countRetain;

- (void)showInView:(UIView *)view animated:(BOOL)animated;

- (void)hide:(BOOL)animated;

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (void)show:(BOOL)animated;

- (void)showMaskWithView:(UIView *)view;

- (void)creatMaskWithView:(UIView *)view;

- (CGPoint)ccCenter;

@end
