//
//  UIButton+Action.m
//  TianGong
//
//  Created by xbwu on 15/10/7.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import <objc/runtime.h>
static const char ACTION;
static const char EQUIP;

#import "UIButton+Action.h"

@implementation UIButton (Action)

- (void)setAction:(NSString *)action {
	objc_setAssociatedObject(self, &ACTION, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)action {
	return objc_getAssociatedObject(self, &ACTION);
}

- (void)setEquip:(TGEquip *)equip {
	objc_setAssociatedObject(self, &EQUIP, equip, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TGEquip *)equip {
	return objc_getAssociatedObject(self, &EQUIP);
}

@end
