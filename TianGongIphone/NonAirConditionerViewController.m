//
//  NonAirConditionerViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/19.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "NonAirConditionerViewController.h"

@interface NonAirConditionerViewController ()
{
}

@end

@implementation NonAirConditionerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.title = @"空调";
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  NSArray *imageArray = @[@"icon_off_air",@"bt_zhileng",@"bt_zhire",@"bt_chushi",@"bt_songfeng",@"bt_zidongfx",@"bt_spsf",@"bt_czsf",@"btn_zdsf",@"bt_fld",@"bt_flz",@"bt_flg"];
  for (int i = 0; i < [imageArray count]; i ++) {
    NSInteger row = i/4;
    NSInteger column = i%4;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(10 + 75 * column, 110 + 75 * row, 71, 69);
    if (i == 0) {
      btn.frame = CGRectMake(14, 113, 63, 63);
    }
    [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
    btn.tag = 100 + i;
    [self.view addSubview:btn];
  }
  
  NSArray *numArray = @[@"icon_18",@"icon_20",@"icon_22",@"icon_24",@"icon_26",@"icon_28",@"icon_30"];
  for (int i = 0; i < 7; i ++) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(10 + 42 * i, 338, 45.5, 45);
    
    [btn setImage:[UIImage imageNamed:numArray[i]] forState:UIControlStateNormal];
    btn.tag = 1000 + i;
    [self.view addSubview:btn];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
