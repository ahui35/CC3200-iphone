//
//  CameraViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/19.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "CameraViewController.h"
#import "TGVideoDisplayViewController.h"

@interface CameraViewController ()
{
}

@end

@implementation CameraViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      Main_Screen_Width,
                                                                      Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  
  CGFloat h = 0;
  for (int i = 0; i < self.equips.count; i ++) {
    TGEquip *equip = [self.equips objectAtIndex:i];
    NSInteger row = i/2;
    NSInteger column = i%2;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(10 + 155 * column, 60 + 186 * row, 144, 150);
    [btn setImage:[UIImage imageNamed:@"icon_shexiangt"] forState:UIControlStateNormal];
    btn.tag = 100 + i;
    [scrollView addSubview:btn];
    [btn addTarget:self action:@selector(showVideo:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame),
                                                               CGRectGetMaxY(btn.frame),
                                                               144, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = equip.equipName;
    [scrollView addSubview:label];
    
    h = CGRectGetMaxY(label.frame);
  }
  scrollView.contentSize = CGSizeMake(Main_Screen_Width, h + 80);
}

- (void)showVideo:(UIButton *)btn {
  TGEquip *equip = [self.equips objectAtIndex:btn.tag - 100];
  NSLog(@"%@", equip);
  TGVideoDisplayViewController *dvc = [[TGVideoDisplayViewController alloc] init];
  dvc.videoadd = [NSString stringWithFormat:@"%@", equip.ddns];
  dvc.account = equip.account;
  dvc.password = equip.password;
  [self presentViewController:dvc animated:YES completion:NULL];
  dvc.navTitle = equip.equipName;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
