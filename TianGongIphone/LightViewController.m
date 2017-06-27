//
//  LightViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/18.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "LightViewController.h"

@interface LightViewController ()
{
  NSMutableArray *array1;//开关灯
  NSMutableArray *array2;//调光灯
}

@end

@implementation LightViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  scrollView.pagingEnabled = NO;
  
  array1 = [[NSMutableArray alloc] init];
  array2 = [[NSMutableArray alloc] init];
  
  [self creatUI];
  [self reloadStatus];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reloadStatus)
                                               name:TGDevideSyncNotification
                                             object:nil];
}

- (void)creatUI {
  for (TGEquip *equip in self.equips) {
    if (equip.equipstyle == 1) {
      [array1 addObject:equip];
    }
    if (equip.equipstyle == 2) {
      [array2 addObject:equip];
    }
  }
  float origin = 0;
  for (int i = 0; i < array1.count; i ++) {
    TGEquip *equip = [array1 objectAtIndex:i];
    NSInteger row = i/2;
    NSInteger column = i%2;
    UIButton *swithBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    swithBtn.backgroundColor = [UIColor clearColor];
    swithBtn.frame = CGRectMake(14 + 165 * column, 75 + 98 * row, 98, 46);
    [swithBtn setBackgroundImage:[UIImage imageNamed:@"btn_switch_off"] forState:UIControlStateNormal];
    [swithBtn setBackgroundImage:[UIImage imageNamed:@"btn_switch_on"] forState:UIControlStateSelected];
    [swithBtn addTarget:self action:@selector(clickSwitchBtn:) forControlEvents:UIControlEventTouchUpInside];
    swithBtn.tag = 100 + i;
    [scrollView addSubview:swithBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(swithBtn.frame.origin.x + 10,
                                                                    CGRectGetMinY(swithBtn.frame) - 25,
                                                                    100,
                                                                    20)];
    [scrollView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = equip.equipName;
    
    UIImageView *lightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(swithBtn.frame) + 5,
                                                                             CGRectGetMinY(swithBtn.frame) + 6,
                                                                             26, 28)];
    lightImageV.image = [UIImage imageNamed:@"icon_light_big_nor"];
    lightImageV.tag = 1000 + i;
    [scrollView addSubview:lightImageV];
    
    origin = CGRectGetMaxY(lightImageV.frame) + 40;
  }
  
  float h = origin;
  for (int i = 0; i < array2.count; i ++) {
    TGEquip *equip = [array2 objectAtIndex:i];
    
    UIImageView * thumbImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15,
                                                                              76 * i + h + 30,
                                                                              261,
                                                                              12)];
    thumbImageV.image = [UIImage imageNamed:@"bg_rounded-rectangle_sel"];
    [scrollView addSubview:thumbImageV];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(15,
                                                                  76 * i + h + 30,
                                                                  257,
                                                                  12)];
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    [slider setThumbImage:[UIImage imageNamed:@"btn_toggle"] forState:UIControlStateNormal];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"bg_rounded-rectangle_sel"] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[UIImage imageNamed:@"bg_rounded-rectangle_nor"] forState:UIControlStateNormal];
    slider.value = 0;
    [slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    [slider addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:slider];
    slider.tag = 10000 + i;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.origin.x,
                                                                    CGRectGetMinY(slider.frame) -  35,
                                                                    100,
                                                                    20)];
    [scrollView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = equip.equipName;
    
    UIImageView *lightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(slider.frame) + 10, CGRectGetMinY(slider.frame) - 10, 26, 28)];
    lightImageV.image = [UIImage imageNamed:@"icon_light_big_sel"];
    [scrollView addSubview:lightImageV];
    
    origin = CGRectGetMaxY(lightImageV.frame) + 40;
  }
  scrollView.contentSize = CGSizeMake(Main_Screen_Width, origin + 70);
}

- (void)clickSwitchBtn:(UIButton *)btn
{
  TGEquip *equip = [array1 objectAtIndex:btn.tag - 100];
  UIImageView *lightImageV = (UIImageView *)[self.view viewWithTag:btn.tag + 900];
  if (btn.selected) {
    [TGUdp defaultUdp].result = ^(BOOL success) {
      if (!success) {
        return;
      }
      lightImageV.image = [UIImage imageNamed:@"light_off"];
      
      btn.selected = !btn.selected;
      NSMutableDictionary *status = [[TGUdp defaultUdp] statusForRoomID:equip.roomid
                                                                 nodeId:equip.equipaddr
                                                                  style:equip.equipstyle];
      [status setObject:@"off" forKey:@"power"];
    };
    [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"off" value:-1];
  }
  else
  {
    [TGUdp defaultUdp].result = ^(BOOL success) {
      if (success) {
        lightImageV.image = [UIImage imageNamed:@"light_on"];
        
        btn.selected = !btn.selected;
        NSMutableDictionary *status = [[TGUdp defaultUdp] statusForRoomID:equip.roomid
                                                                   nodeId:equip.equipaddr
                                                                    style:equip.equipstyle];
        [status setObject:@"on" forKey:@"power"];
      }
    };
    [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"on" value:-1];
  }
}

- (void)touchUp:(UISlider *)slider {
  float value = slider.value;
  TGEquip *equip = [array2 objectAtIndex:slider.tag - 10000];
  [TGUdp defaultUdp].result = ^(BOOL success) {
    if (!success) {
      slider.value = value;
    }
    else {
      NSMutableDictionary *status = [[TGUdp defaultUdp] statusForRoomID:equip.roomid
                                                                 nodeId:equip.equipaddr
                                                                  style:equip.equipstyle];
      [status setObject:@(slider.value) forKey:@"value1"];
    }
  };
  [[TGUdp defaultUdp] sendControlWithEquip:equip action:@"dimmer" value:slider.value];
}

- (void)updateValue:(UISlider *)slider {
}

- (void)reloadStatus {
  NSInteger i = 0;
  for (TGEquip *equip in array1) {
    NSDictionary *status = [[TGUdp defaultUdp] statusForRoomID:equip.roomid
                                                        nodeId:equip.equipaddr
                                                         style:equip.equipstyle];
    if (status != nil) {
      UIButton *swithBtn = (UIButton *)[scrollView viewWithTag:100 + i];
      swithBtn.selected = [[status objectForKey:@"power"] isEqualToString:@"on"];
      
      UIImageView *lightImageV = (UIImageView *)[scrollView viewWithTag:1000 + i];
      lightImageV.image = swithBtn.selected?[UIImage imageNamed:@"light_on"]:[UIImage imageNamed:@"light_off"];
    }
    i++;
  }
  
  i = 0;
  for (TGEquip *equip in array2) {
    NSDictionary *status = [[TGUdp defaultUdp] statusForRoomID:equip.roomid nodeId:equip.equipaddr style:equip.equipstyle];
    if (status != nil) {
      UISlider *slider = (UISlider *)[scrollView viewWithTag:10000 + i];
      slider.value = [[status objectForKey:@"value1"] integerValue];
    }
    i++;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
