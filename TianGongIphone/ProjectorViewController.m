//
//  ProjectorViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/20.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "ProjectorViewController.h"

@interface ProjectorViewController ()
{
}

@end

@implementation ProjectorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  
  for (int i = 0; i < self.equips.count; i ++) {
    TGEquip *equip = [self.equips objectAtIndex:i];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(Main_Screen_Width * i, 15, Main_Screen_Width, 415)];
    [scrollView addSubview:backView];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 230)];
    [backView addSubview:icon];
    icon.image = [UIImage imageNamed:@"img_touyingyi"];
    
    UIButton *onBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:onBtn];
    onBtn.frame = CGRectMake(10, 278, 58, 58);
    [onBtn setImage:[UIImage imageNamed:@"icon_open"] forState:UIControlStateNormal];
    onBtn.action = @"on";
    onBtn.equip = equip;
    [onBtn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *offBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:offBtn];
    offBtn.frame = CGRectMake(72, 278, 58, 58);
    [offBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    offBtn.action = @"off";
    offBtn.equip = equip;
    [offBtn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *hdm1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:hdm1];
    hdm1.frame = CGRectMake(135, 278, 88, 58);
    [hdm1 setImage:[UIImage imageNamed:@"button_hdm1"] forState:UIControlStateNormal];
    hdm1.action = @"hdmi1";
    hdm1.equip = equip;
    [hdm1 addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *hdm2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:hdm2];
    hdm2.frame = CGRectMake(227, 280, 83, 56);
    [hdm2 setImage:[UIImage imageNamed:@"button_hdm2"] forState:UIControlStateNormal];
    hdm2.action = @"hdmi2";
    hdm2.equip = equip;
    [hdm2 addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  }
  scrollView.contentSize = CGSizeMake(Main_Screen_Width*self.equips.count, scrollView.height);
}

- (void)responseToBtn:(UIButton *)btn
{
  [[TGUdp defaultUdp] sendControlWithEquip:btn.equip action:btn.action value:-1];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
