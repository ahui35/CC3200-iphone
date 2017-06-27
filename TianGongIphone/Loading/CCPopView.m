//
//  CCPopView.m
//  CYChinese
//
//  Created by xbwu on 14-5-8.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import "CCPopView.h"

@interface CCPopView()  {
    CGAffineTransform originTransform;
}

@end

@implementation CCPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        originTransform = self.transform;
        self.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin
                                 | UIViewAutoresizingFlexibleBottomMargin
                                 | UIViewAutoresizingFlexibleLeftMargin
                                 | UIViewAutoresizingFlexibleRightMargin;
    }
    return self;
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
    if (self.superview) {
        if (self.superview == view) {
						_countRetain++;
            return;
        }
        else {
            [self removeFromSuperview];
        }
    }
		_countRetain = 0;
		_countRetain++;
    self.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2 - 100);
    [view addSubview:self];
    [self showMaskWithView:view];
    [self show:animated];
}

- (CGPoint)ccCenter {
    if (self.superview) {
        return CGPointMake(self.superview.bounds.size.width/2, self.superview.bounds.size.height/2);

    }
    return CGPointZero;
}
/**
 *  默认创建的遮罩
 *
 *  @param view 父view
 */
- (void)creatMaskWithView:(UIView *)view {
    UIView *maskView = [[UIView alloc] initWithFrame:view.bounds];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.maskView = maskView;
    [view addSubview:maskView];
    [view bringSubviewToFront:self];
}

/**
 *  子类重载这个方法去实现遮罩
 */
- (void)showMaskWithView:(UIView *)view {
    
}

- (void)show:(BOOL)animated {
    self.alpha = 0.0f;
    if (animated) {
        self.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(0.3, 0.3));
				[UIView animateWithDuration:0.2
												 animations:^{
													 self.alpha = 0.5;
													 [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1)];
												 }
												 completion:^(BOOL finished) {
													 [UIView animateWithDuration:0.13
																						animations:^{
																							self.alpha = 0.8;
																							[self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)];
																						}
																						completion:^(BOOL finished) {
																							self.alpha = 1.0;
																							[UIView animateWithDuration:0.13 animations:^{
																								[self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)];
																							}];
																						}];
													}];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.30];
        self.alpha = 1.0f;
        self.transform = originTransform;
        [UIView commitAnimations];
    }
    else {
        self.alpha = 1.0f;
    }
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    
    [self performSelector:@selector(hideDelayed:)
               withObject:[NSNumber numberWithBool:animated]
               afterDelay:delay];
}

- (void)hideDelayed:(NSNumber *)animated {
	[self hide:[animated boolValue]];
}

- (void)hide:(BOOL)animated {
	if (animated) {
		[UIView animateWithDuration:0.3
										 animations:^{
											 self.transform = CGAffineTransformConcat(originTransform, CGAffineTransformMakeScale(0.5f, 0.5f));
											 self.alpha = 0.02f;
										 }
										 completion:^(BOOL finished) {
											 _countRetain--;
											[self hide];
										 }];
	}
	else {
		_countRetain--;
		[self hide];
	}
}

- (void)hide {
		if (_countRetain > 0) {
			return;
		}
    self.alpha = 0.0f;
    self.transform = originTransform;
    [self.maskView removeFromSuperview];
    [self removeFromSuperview];
}

@end
