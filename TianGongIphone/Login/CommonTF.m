//
//  CommonTF.m
//  TianGongIphone
//
//  Created by sgao on 16/1/11.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "CommonTF.h"

@implementation CommonTF

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 30, bounds.origin.y, bounds.size.width - 30, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 30, bounds.origin.y, bounds.size.width - 30, bounds.size.height);
    return inset;
}

@end
