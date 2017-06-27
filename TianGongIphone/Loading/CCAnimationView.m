//
//  CCAnimationView.m
//  CYChinese
//
//  Created by xbwu on 14-5-27.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#import "CCAnimationView.h"

#define DEFAULT_FRAME CGRectMake(0, 0, 150, 150)

@interface CCAnimationView()  {
    UIImageView *imageView;
}

@end

@implementation CCAnimationView

static CCAnimationView *animationView = nil;

+ (CCAnimationView *)sharedAnimation {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		animationView = [[CCAnimationView alloc] initWithFrame:DEFAULT_FRAME];
	});
	return animationView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        imageView.backgroundColor = [UIColor clearColor];
        imageView.animationDuration = 1;
        imageView.animationRepeatCount = 0;
        [self addSubview:imageView];
			
				NSMutableArray *array = [[NSMutableArray alloc] init];
				for (int i = 0; i < 30; i++) {
					NSString *imageName = [NSString stringWithFormat:@"Untitled-%d",10001 + i];
					[array addObject:[UIImage imageNamed:imageName]];
				}
				imageView.animationImages = array;
    }
    return self;
}

//- (void)showMaskWithView:(UIView *)view {
//    [self creatMaskWithView:view];
//    self.maskView.backgroundColor = [UIColor clearColor];
//}

- (void)setAnimationImages:(NSArray *)array {
    imageView.animationImages = array;
}

- (void)show:(BOOL)animated {
    [super show:animated];
    [imageView startAnimating];
}

- (void)hide:(BOOL)animated {
	[super hide:animated];
	[imageView stopAnimating];
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
