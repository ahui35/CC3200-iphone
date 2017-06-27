//
//  UIAlertView+Block.m
//  TCZ
//
//  Created by xbwu on 14-7-20.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

static char key;

@implementation UIAlertView (Block)

- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block
{
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    CompleteBlock block = objc_getAssociatedObject(self, &key);
    if (block) {
        block(buttonIndex);
    }
}

@end
