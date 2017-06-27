//
//  PlayViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/12.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "PlayViewController.h"
#import "BluRayViewController.h"
#import "NetPlayerViewController.h"
#import "HardDiskPlayerViewController.h"
#import "STBViewController.h"
#import "KaraokeViewController.h"

@interface PlayViewController ()
{
}

@end

@implementation PlayViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  
  float maxY = 0;
  for (int i = 0; i < self.equips.count; i ++) {
    TGEquip *equip = [self.equips objectAtIndex:i];
    NSInteger row = i/2;
    NSInteger column = i%2;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(23 + 160 * column, 50 + 132 * row, 114, 79);
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"play_btn_%d", equip.substyle]]
         forState:UIControlStateNormal];
    btn.tag = 100 + i;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame) - 10, 114, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = equip.equipName;
    [scrollView addSubview:label];
    
    maxY = CGRectGetMaxY(btn.frame);
  }
  
  scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,
                                      maxY + 90);
  
//  UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 137 + 64, Main_Screen_Width, 1)];
//  lineView.image = [UIImage imageNamed:@"line_horizontal"];
//  [self.view addSubview:lineView];
//  
//  lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame) + 135, Main_Screen_Width, 1)];
//  lineView.image = [UIImage imageNamed:@"line_horizontal"];
//  [self.view addSubview:lineView];
//  
//  lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame) + 135, Main_Screen_Width, 1)];
//  lineView.image = [UIImage imageNamed:@"line_horizontal"];
//  [self.view addSubview:lineView];
//  
//  lineView = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 1)/2, 64, 1, 410)];
//  lineView.image = [UIImage imageNamed:@"line_verticalline"];
//  [self.view addSubview:lineView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)responseToBtn:(UIButton *)btn {
  TGEquip *equip = [self.equips objectAtIndex:btn.tag - 100];
  if (equip.substyle == 1) {
#ifdef DEBUG
    BluRayViewController *blue = [[BluRayViewController alloc] init];
    blue.equip = equip;
    [self presentViewController:blue];
    blue.navTitle = self.navTitle;
#endif
    [TGUdp defaultUdp].result = ^(BOOL success) {
      if (success) {
        BluRayViewController *blue = [[BluRayViewController alloc] init];
        blue.equip = equip;
        [self presentViewController:blue];
        blue.navTitle = self.navTitle;
      }
    };
    [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"turn" value:-1];
  }
  else if (equip.substyle == 2) {
#ifdef DEBUG
    NetPlayerViewController *net = [[NetPlayerViewController alloc] init];
    net.equip = equip;
    [self presentViewController:net];
    net.navTitle = self.navTitle;
#endif
    [TGUdp defaultUdp].result = ^(BOOL success) {
      if (success) {
        NetPlayerViewController *net = [[NetPlayerViewController alloc] init];
        net.equip = equip;
        [self presentViewController:net];
        net.navTitle = self.navTitle;
      }
    };
    [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"turn" value:-1];
		}
  else if (equip.substyle == 3) {
#ifdef DEBUG
    HardDiskPlayerViewController *harddisk = [[HardDiskPlayerViewController alloc] init];
    harddisk.equip = equip;
    [self presentViewController:harddisk];
    harddisk.navTitle = self.navTitle;
#endif
    [TGUdp defaultUdp].result = ^(BOOL success) {
      if (success) {
        HardDiskPlayerViewController *harddisk = [[HardDiskPlayerViewController alloc] init];
        harddisk.equip = equip;
        [self presentViewController:harddisk];
        harddisk.navTitle = self.navTitle;
      }
    };
    [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"turn" value:-1];
  }
  else if (equip.substyle == 4) {
#ifdef DEBUG
    STBViewController *stb = [[STBViewController alloc] init];
    stb.equip = equip;
    [self presentViewController:stb];
    stb.navTitle = self.navTitle;
#endif
    [TGUdp defaultUdp].result = ^(BOOL success) {
      if (success) {
        STBViewController *stb = [[STBViewController alloc] init];
        stb.equip = equip;
        [self presentViewController:stb];
        stb.navTitle = self.navTitle;
      }
    };
    [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"turn" value:-1];
  }
  else if (equip.substyle == 5) {
#ifdef DEBUG
    KaraokeViewController *kvc = [[KaraokeViewController alloc] init];
    kvc.equip = equip;
    [self presentViewController:kvc];
    kvc.navTitle = self.navTitle;
#endif
    [TGUdp defaultUdp].result = ^(BOOL success) {
      if (success) {
        KaraokeViewController *kvc = [[KaraokeViewController alloc] init];
        kvc.equip = equip;
        [self presentViewController:kvc];
        kvc.navTitle = self.navTitle;
      }
    };
    [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"turn" value:-1];
  }
}

- (void)presentViewController:(UIViewController *)vc {
  [self addChildViewController:vc];
  vc.view.frame = CGRectMake(0, 0, 1024 - 130, 748);
  [self.view addSubview:vc.view];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
