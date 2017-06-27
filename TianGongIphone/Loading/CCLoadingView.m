//
//  CCLoadingView.m
//  CYChinese
//
//  Created by xbwu on 14-4-23.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import "CCLoadingView.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_FRAME CGRectMake(0, 0, 100, 100)

static CCLoadingView *loadingV = nil;

@interface CCLoadingView() {
    UIActivityIndicatorView *indicator;
}
@end

@implementation CCLoadingView

+ (CCLoadingView *)sharedLoading {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadingV = [[CCLoadingView alloc] initWithFrame:DEFAULT_FRAME];
    });
    return loadingV;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        indicator = [[UIActivityIndicatorView alloc]
						   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:indicator];
        indicator.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [indicator startAnimating];
        self.layer.cornerRadius = 10;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0,
                            0,
                            MAX(indicator.frame.size.width, titleLabel.frame.size.width) + 50,
                            titleLabel.frame.size.height + 50 + indicator.frame.size.height);
    self.center = [self ccCenter];
    indicator.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    if (titleLabel) {
        indicator.center = CGPointMake(self.frame.size.width/2,
                                       (self.frame.size.height  - 10 - titleLabel.frame.size.height)/2);
        titleLabel.center = CGPointMake(self.frame.size.width/2,
                                        indicator.frame.size.height + indicator.frame.origin.y + 10 + titleLabel.frame.size.height/2);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
