//
//  UIView+MGAdditions.m
//  Manga
//
//  Created by xbwu on 15/9/14.
//  Copyright (c) 2015年 唐艺源. All rights reserved.
//

#import "UIView+TGAdditions.h"

@implementation UIView (TGAdditions)

- (CGFloat)height {
	return self.frame.size.height;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (CGFloat)x {
	return self.frame.origin.x;
}

- (void)removeAllSubViews {
	for (UIView *view in self.subviews) {
		[view removeFromSuperview];
	}
}

@end
