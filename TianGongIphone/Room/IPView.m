//
//  IPView.m
//  TianGong
//
//  Created by xbwu on 15/10/29.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "IPView.h"
#import "TGUserCenter.h"

@implementation IPView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
																																				0,
																																				self.frame.size.width,
																																				self.frame.size.height)];
		bgView.image = [UIImage imageNamed:@"update_bg"];
		[self addSubview:bgView];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 50, 180, 25)];
		[self addSubview:label];
		label.textAlignment = 1;
		label.textColor = [UIColor darkGrayColor];
		label.font = [UIFont boldSystemFontOfSize:18];
		label.text = @"配置IP地址";
		
		textField = [[UITextField alloc] initWithFrame:CGRectMake(55, 103, 180, 25)];
		textField.backgroundColor = [UIColor whiteColor];
		textField.font = [UIFont systemFontOfSize:15];
		[self addSubview:textField];
		textField.text = [TGUserCenter defaultCenter].ip;

		UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		cancelBtn.backgroundColor = [UIColor clearColor];
		cancelBtn.frame = CGRectMake((290 - 15 - 190)/2, 160, 95, 35);
		[cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
		[self addSubview:cancelBtn];
		[cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		okBtn.backgroundColor = [UIColor clearColor];
		okBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame) + 15, 160, 95, 35);
		[okBtn setBackgroundImage:[UIImage imageNamed:@"confirm_button"] forState:UIControlStateNormal];
		[self addSubview:okBtn];
		[okBtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (void)clickCancelBtn
{
	[self hide:YES afterDelay:0.1];
}

- (void)ok {
	[TGUserCenter defaultCenter].ip = textField.text;
	[self hide:YES afterDelay:0.1];
	
	[TGUdp defaultUdp].host = [TGUserCenter defaultCenter].ip;
}

- (void)showMaskWithView:(UIView *)view {
	[self creatMaskWithView:view];
}

@end
