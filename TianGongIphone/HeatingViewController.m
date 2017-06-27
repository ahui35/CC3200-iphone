//
//  HeatingViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/18.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "HeatingViewController.h"

@interface HeatingViewController ()
{
}

@end

@implementation HeatingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];

  [self creatScrollView];
  
  for (int i = 0; i < self.equips.count; i++) {
    TGEquip *equip = [self.equips objectAtIndex:i];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(App_Frame_Width * i, 0, App_Frame_Width, 300)];
    [scrollView addSubview:bgView];
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.backgroundColor = [UIColor clearColor];
    minusBtn.frame = CGRectMake(14, 60, 77, 66);
    [minusBtn setImage:[UIImage imageNamed:@"btn_Temperature_left"] forState:UIControlStateNormal];
    [bgView addSubview:minusBtn];
    [minusBtn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.equip = equip;
    minusBtn.action = @"temp-";

    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(minusBtn.frame),
                                                                               CGRectGetMinY(minusBtn.frame),
                                                                               135, 66)];
    tempImageView.image = [UIImage imageNamed:@"btn_Temperature_middle"];
    [bgView addSubview:tempImageView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor clearColor];
    addBtn.frame = CGRectMake(CGRectGetMaxX(tempImageView.frame), CGRectGetMinY(minusBtn.frame), 82, 66);
    [addBtn setImage:[UIImage imageNamed:@"btn_Temperature_right"] forState:UIControlStateNormal];
    [bgView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.equip = equip;
    addBtn.action = @"temp+";

    NSArray *actions = @[@"18c", @"20c", @"22c", @"24c", @"26c", @"28c"];
    NSArray *imageArray = @[@"btn_18", @"btn_20", @"btn_22", @"btn_24", @"btn_26", @"btn_28"];
    for (int i = 0; i < [imageArray count]; i ++) {
      NSInteger row = i/3;
      NSInteger column = i%3;
      
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      btn.backgroundColor = [UIColor clearColor];
      btn.frame = CGRectMake(14 + 100 * column, 150 + 60 * row, 94, 53);
      [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
      [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
      [bgView addSubview:btn];
      btn.equip = equip;
      btn.action = [actions objectAtIndex:i];
    }
  }
  scrollView.contentSize = CGSizeMake(App_Frame_Width*self.equips.count, scrollView.height);
}

- (void)responseToBtn:(UIButton *)btn {
  [[TGUdp defaultUdp] sendControlWithEquip:btn.equip action:btn.action value:-1];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
