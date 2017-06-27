//
//  MainViewController.m
//  TianGongIphone
//
//  Created by xbwu on 16/1/24.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "MainViewController.h"
#import "PlayViewController.h"
#import "CurtainViewController.h"
#import "HeatingViewController.h"
#import "LightViewController.h"
#import "NonAirConditionerViewController.h"
#import "CameraViewController.h"
#import "PowerAmplifierViewController.h"
#import "NetPlayerViewController.h"
#import "ProjectorViewController.h"
#import "KaraokeViewController.h"
#import "BluRayViewController.h"
#import "HardDiskPlayerViewController.h"
#import "STBViewController.h"
#import "MusicViewController.h"
#import "AirConditionerViewController.h"

@interface MainViewController () {
  NSArray *equips;
  NSArray *equipsArray;

  NSArray *scenes;
  
  UIView *menuView;
  UIImageView *imageV;
  UIButton *expandBtn;
  
  BottomMenuView *bottomView;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  equips = [TGDBManager equipsForRoom:self.roomId];
  scenes = [TGDBManager scenesForRoom:self.roomId];

  [self creatNavBar];
  [self creatMenuView];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(App_Frame_Width - 50, 7, 30, 30);
  [navBar addSubview:btn];
  [btn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
  [btn setImage:[UIImage imageNamed:@"icon_home"] forState:UIControlStateNormal];
  
  bottomView = [[BottomMenuView alloc] initWithFrame:CGRectMake(0, App_Frame_Height - 70 - 20, App_Frame_Width, 70)];
  [self.view addSubview:bottomView];
  bottomView.scenes = scenes;
  // Do any additional setup after loading the view.
}

- (void)home {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)creatMenuView {
  menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, App_Frame_Width, 36)];
  [self.view addSubview:menuView];
  menuView.userInteractionEnabled = YES;
  menuView.clipsToBounds = YES;
  menuView.backgroundColor = [UIColor clearColor];
  
  imageV = [[UIImageView alloc] init];
  imageV.frame = CGRectMake(0, 0, App_Frame_Width, 0);
  imageV.image = [UIImage imageNamed:@"bg_popup"];
  [menuView addSubview:imageV];
  imageV.userInteractionEnabled = YES;
  
  float h = 0;
  for (NSInteger i = 0; i < equips.count; i++) {
    int row = i/3;
    int column = i%3;
    
    NSDictionary *dict = [equips objectAtIndex:i];
    NSString *iconName = [dict objectForKey:@"iconName"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(column*App_Frame_Width/3.0, 93*row, App_Frame_Width/3, 93);
    [btn addTarget:self action:@selector(respondsToMenu:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-nor", iconName]]
         forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(App_Frame_Width/6 - 70/2, 19, App_Frame_Width/6 - 70/2, 19)];
    [imageV addSubview:btn];
    btn.tag = 100 + i;
    h = MAX(h, CGRectGetMaxY(btn.frame));
    if (i == 0) {
      [self respondsToMenu:btn];
    }
  }
  
  for (int i = 0; i < equips.count/3; i++) {
    UIImageView *line1 = [[UIImageView alloc] init];
    [imageV addSubview:line1];
    line1.frame = CGRectMake(0, 92*i, App_Frame_Width, 1);
    line1.image = [UIImage imageNamed:@"line_horizontal"];
  }
  
  expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [expandBtn setImage:[UIImage imageNamed:@"img_more"] forState:UIControlStateNormal];
  [menuView addSubview:expandBtn];
  [expandBtn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
  imageV.frame = CGRectMake(0, -h, App_Frame_Width, h);
  expandBtn.frame = CGRectMake(0, CGRectGetMaxY(imageV.frame), App_Frame_Width, 36);

  for (int i = 0; i < 3; i++) {
    UIImageView *line1 = [[UIImageView alloc] init];
    [imageV addSubview:line1];
    line1.frame = CGRectMake(i*App_Frame_Width/3.0, 0, 1, imageV.frame.size.height);
    line1.image = [UIImage imageNamed:@"line_vertical"];
  }
  
  [self.view bringSubviewToFront:navBar];
}

- (void)expand:(UIButton *)btn {
  btn.selected = !btn.selected;
  if (btn.selected) {
    [UIView animateWithDuration:0.5 animations:^{
      menuView.frame = CGRectMake(0,
                                  44,
                                  menuView.width,
                                  imageV.height + 36);
      imageV.frame = CGRectMake(0, 0, App_Frame_Width, imageV.height);
      expandBtn.frame = CGRectMake(0, CGRectGetMaxY(imageV.frame), expandBtn.width, expandBtn.height);
    }];
  } else {
    [UIView animateWithDuration:0.5 animations:^{
      menuView.frame = CGRectMake(0,
                                  44,
                                  menuView.frame.size.width,
                                  36);
      imageV.frame = CGRectMake(0, -imageV.height, App_Frame_Width, imageV.height);
      expandBtn.frame = CGRectMake(0, CGRectGetMaxY(imageV.frame), expandBtn.width, expandBtn.height);
    }];
  }
}

/*
 1	开关灯类
 2	调光灯类
 3	窗帘类
 4	播放器类
 5	功放类
 6	投影仪
 7	空调类
 8	背景音乐类
 9	地暖类
	摄像头单独一张表
 */
- (void)respondsToMenu:(UIButton *)btn {
  [self expand:expandBtn];
  [self dismissTopViewController];
  
  NSDictionary *dict = [equips objectAtIndex:btn.tag - 100];
  equipsArray = [dict objectForKey:@"equips"];
  TGEquip *equip = [equipsArray objectAtIndex:0];
  
  switch (equip.equipstyle) {
    case 1:
      [self showLight];
      break;
    case 2:
      [self showLight];
      break;
    case 3:
      [self showCurtain];
      break;
    case 4:
      [self showPlayer];
      break;
    case 5:
      [self showPowerAmplifier];
      break;
    case 6:
      [self showProjector];
      break;
    case 7:
      [self showAirConditioner];
      break;
    case 8:
      [self showMusic];
      break;
    case 9:
      [self showHeating];
      break;
    case 10:
      [self showCamera];
      break;
    default:
      break;
  }
}

- (void)showPlayer {
  PlayViewController *player = [[PlayViewController alloc] init];
  player.equips = equipsArray;
  [self prensetViewController:player];
  self.navTitle = self.roomName;
}

- (void)showMusic {
  MusicViewController *music = [[MusicViewController alloc] init];
  music.equips = equipsArray;
  [self prensetViewController:music];
  self.navTitle = self.roomName;
}

//完成
- (void)showLight {
  LightViewController *lvc = [[LightViewController alloc] init];
  lvc.equips = equipsArray;
  [self prensetViewController:lvc];
  self.navTitle = self.roomName;
}

- (void)showAirConditioner
{
  AirConditionerViewController *vc = [[AirConditionerViewController alloc] init];
  vc.equips = equipsArray;
  [self prensetViewController:vc];
  vc.navTitle = self.roomName;
}

//完成
- (void)showPowerAmplifier
{
  PowerAmplifierViewController *powerVC = [[PowerAmplifierViewController alloc] init];
  powerVC.equips = equipsArray;
  [self prensetViewController:powerVC];
  self.navTitle = self.roomName;
}

//完成
- (void)showHeating
{
  HeatingViewController *heatingVC = [[HeatingViewController alloc] init];
  heatingVC.equips = equipsArray;
  [self prensetViewController:heatingVC];
  self.navTitle = self.roomName;
}

//完成，返回按钮
- (void)showCamera
{
  CameraViewController *cameraVC = [[CameraViewController alloc] init];
  cameraVC.equips = equipsArray;
  [self prensetViewController:cameraVC];
  self.navTitle = self.roomName;
}

//完成
- (void)showProjector
{
  ProjectorViewController *projectorVC = [[ProjectorViewController alloc] init];
  projectorVC.equips = equipsArray;
  [self prensetViewController:projectorVC];
  self.navTitle = self.roomName;
}

//完成
- (void)showCurtain
{
  CurtainViewController *curtainVC = [[CurtainViewController alloc] init];
  curtainVC.equips = equipsArray;
  [self prensetViewController:curtainVC];
  self.navTitle = self.roomName;
}

- (void)prensetViewController:(UIViewController *)vc {
  [self addChildViewController:vc];
  vc.view.frame = CGRectMake(0, 0, App_Frame_Width, App_Frame_Height);
  [self.view addSubview:vc.view];
  
  [self.view bringSubviewToFront:menuView];
  [self.view bringSubviewToFront:navBar];
  [self.view bringSubviewToFront:bottomView];
}

- (void)dismissTopViewController {
  UIViewController *topVC = [self.childViewControllers firstObject];
  if (topVC) {
    [topVC.view removeFromSuperview];
    [topVC removeFromParentViewController];
  }
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
