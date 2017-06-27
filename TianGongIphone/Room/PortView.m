//
//  PortView.m
//  TianGongIphone
//
//  Created by xbwu on 2017/6/27.
//  Copyright © 2017年 com.int-hub.demo. All rights reserved.
//

#import "PortView.h"

@implementation PortView

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
    label.text = @"配置端口号";
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(55, 103, 180, 25)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:15];
    [self addSubview:textField];
    textField.text = [TGUserCenter defaultCenter].port;
    
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
  [TGUserCenter defaultCenter].port = textField.text;
  [self hide:YES afterDelay:0.1];
  
  [TGUdp defaultUdp].port = [textField.text intValue];
}

- (void)showMaskWithView:(UIView *)view {
  [self creatMaskWithView:view];
}

@end
