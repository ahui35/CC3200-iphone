//
//  CurtainView.m
//  TianGongIphone
//
//  Created by sgao on 16/1/18.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "CurtainView.h"
#import "TGUdp.h"
#import "UIButton+Action.h"

@implementation CurtainView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 337)];
    bgView.image = [UIImage imageNamed:@"bg_chuanglain1"];
    [self addSubview:bgView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, 25)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 191)/2, 50, 191, 191)];
    _imageV.image = [UIImage imageNamed:@"img_chuanglian"];
    [self addSubview:_imageV];
    
    NSArray *btnArr = @[@"icon_on", @"icon_off", @"icon_stop"];
    NSArray *actions = @[@"on", @"off", @"stop"];
    for (int i = 0; i < 3; i ++) {
      UIButton *onBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      onBtn.frame = CGRectMake(45 + 68 * i, 256, 57, 57);
      [onBtn setImage:[UIImage imageNamed:btnArr[i]] forState:UIControlStateNormal];
      [self addSubview:onBtn];
      onBtn.action = [actions objectAtIndex:i];
      [onBtn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
  }
  return self;
}

- (void)setEquip:(TGEquip *)equip {
  _equip = equip;
  _titleLabel.text = equip.equipName;
}

- (void)responseToBtn:(UIButton *)btn {
  [[TGUdp defaultUdp] sendControlWithEquip:_equip action:btn.action value:-1];
}

@end
