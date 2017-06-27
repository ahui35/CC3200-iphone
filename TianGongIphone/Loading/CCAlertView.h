//
//  CCProgressView.h
//  CYChinese
//
//  Created by xbwu on 14-4-14.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPopView.h"

@interface CCAlertView : CCPopView {
    UILabel *titleLabel;
}

- (void)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated;
+ (CCAlertView *)sharedAlert;

@end
