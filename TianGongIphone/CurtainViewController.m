//
//  CurtainViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/18.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "CurtainViewController.h"
#import "CurtainView.h"

@interface CurtainViewController ()
{
}

@end

@implementation CurtainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  
  for (int i = 0; i < self.equips.count; i ++) {
    TGEquip *equip = [self.equips objectAtIndex:i];
    CurtainView *curtainView = [[CurtainView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 280)/2 + App_Frame_Width*i,
                                                                             60,
                                                                             280,
                                                                             337)];
    [scrollView addSubview:curtainView];
    curtainView.equip = equip;
  }
  scrollView.contentSize = CGSizeMake(Main_Screen_Width*self.equips.count, scrollView.height);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
