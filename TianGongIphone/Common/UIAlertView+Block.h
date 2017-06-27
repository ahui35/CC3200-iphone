//
//  UIAlertView+Block.h
//  TCZ
//
//  Created by xbwu on 14-7-20.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block;

@end
