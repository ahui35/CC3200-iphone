//
//  CCProgressView.m
//  CYChinese
//
//  Created by xbwu on 14-4-14.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import "CCAlertView.h"
#define TEXT_FONT [UIFont boldSystemFontOfSize:16]
#define DEFAULT_FRAME CGRectMake(0, 0, 100, 100)

static CCAlertView *alertV = nil;

@interface CCAlertView()  {
    
}

@property (nonatomic, strong) NSString *title;

@end

@implementation CCAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (CCAlertView *)sharedAlert {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertV = [[CCAlertView alloc] initWithFrame:DEFAULT_FRAME];
    });
    return alertV;
}

- (void)showInView:(UIView *)view title:(NSString *)string animated:(BOOL)animated {
    [super showInView:view animated:animated];
    self.title = string;
}

- (void)showMaskWithView:(UIView *)view {
//    [self creatMaskWithView:view];
}

- (void)setTitle:(NSString *)title {
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    UIFont *font = TEXT_FONT;
    CGSize size = [title sizeWithFont:font constrainedToSize:CGSizeMake(300, 10000)];
    titleLabel.frame = CGRectMake(0, 0, size.width, size.height);
    titleLabel.font = font;
    titleLabel.text = title;
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    self.frame = CGRectMake(0, 0, titleLabel.frame.size.width + 30, titleLabel.frame.size.height + 30);
    self.center = [self ccCenter];
    titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

@end
