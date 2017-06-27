//
//  MusicViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/25.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "MusicViewController.h"
#import "RemoteButton.h"

@interface MusicViewController () {
  NSTimer *timer;
  UIButton *currentBtn;
}

@end

@implementation MusicViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  
  for (int i = 0; i < self.equips.count; i ++) {
    TGEquip *equip = [self.equips objectAtIndex:i];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(App_Frame_Width * i, 0, App_Frame_Width, 400)];
    [scrollView addSubview:bgView];

    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(App_Frame_Width/2 - 173/2, 50, 173, 155)];
    imageV.image = [UIImage imageNamed:@"img_musiccd"];
    [bgView addSubview:imageV];
    
    NSArray *actions = @[@"power",
                         @"last",
                         @"play",
                         @"pause",
                         @"next"];
    NSArray *array = [NSArray arrayWithObjects:@(RemoteTypeShutDown),
                      @(RemoteTypePrev),
                      @(RemoteTypePlay),
                      @(RemoteTypePause),
                      @(RemoteTypeNext),nil];
    for (int i = 0; i < 5; i++) {
      RemoteButton *btn = [[RemoteButton alloc] init];
      btn.frame = CGRectMake(10 + 62*i, 230, 58, 58);
      if (i == 2) {
        btn.frame = CGRectMake(6 + 62*i, 230 - 4, 66, 66);
      }
      btn.remoteType = [[array objectAtIndex:i] intValue];
      [bgView addSubview:btn];
      btn.action = [actions objectAtIndex:i];
      btn.equip = equip;
      [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //voice
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 327, 200, 49)];
    [bgView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"bg_voice"];
    imageV.userInteractionEnabled = YES;
    
    UIImageView *voice = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 10)];
    voice.image = [UIImage imageNamed:@"text_voice"];
    [imageV addSubview:voice];
    voice.center = CGPointMake(imageV.width/2, imageV.height/2);
    
    RemoteButton *btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(2, 1, 48, 48);
    btn.remoteType = RemoteTypeVolumeDown;
    [imageV addSubview:btn];
    btn.action = @"vol-";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToVol:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(cancelForVol:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(imageV.width - 48, 1, 48, 48);
    btn.remoteType = RemoteTypeVolumeUp;
    [imageV addSubview:btn];
    btn.action = @"vol+";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToVol:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(cancelForVol:) forControlEvents:UIControlEventTouchUpInside];
    
//    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 327, 21, 18)];
//    imageV.image = [UIImage imageNamed:@"icon_volume_reduction"];
//    [bgView addSubview:imageV];
//    
//    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(210, 327, 21, 18)];
//    imageV.image = [UIImage imageNamed:@"icon_volume_add"];
//    [bgView addSubview:imageV];
    
//    UIImageView * thumbImageV = [[UIImageView alloc] initWithFrame:CGRectMake(38,
//                                                                              330,
//                                                                              164,
//                                                                              12)];
//    thumbImageV.image = [UIImage imageNamed:@"bg_roundedrectangle"];
//    [bgView addSubview:thumbImageV];
    
//    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(38,
//                                                                  330,
//                                                                  161,
//                                                                  12)];
//    slider.minimumValue = 0;
//    slider.maximumValue = 100;
//    [slider setThumbImage:[UIImage imageNamed:@"btn_toggle"] forState:UIControlStateNormal];
//    [slider setMinimumTrackImage:[UIImage imageNamed:@"bg_roundedrectangle"] forState:UIControlStateNormal];
//    [slider setMaximumTrackImage:[UIImage imageNamed:@"bg_rounded-rectangle_nor"] forState:UIControlStateNormal];
//    slider.value = 0;
//    [bgView addSubview:slider];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(250, 335, 63, 41);
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_yinyuan"] forState:UIControlStateNormal];
    [bgView addSubview:btn];
    btn.action = @"source";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  }
  scrollView.contentSize = CGSizeMake(Main_Screen_Width * self.equips.count, scrollView.frame.size.height);
}

- (void)responseToBtn:(UIButton *)btn{
  [[TGUdp defaultUdp] sendControlWithEquip:btn.equip action:btn.action value:-1];
}

- (void)responseToVol:(UIButton *)btn {
  currentBtn = btn;
  timer = [NSTimer scheduledTimerWithTimeInterval:0.4
                                           target:self
                                         selector:@selector(volAdd)
                                         userInfo:nil
                                          repeats:YES];
}

- (void)volAdd {
  [[TGUdp defaultUdp] sendControlWithEquip:currentBtn.equip action:currentBtn.action value:-1];
}

- (void)cancelForVol:(UIButton *)btn {
  if (timer) {
    [timer invalidate];
    timer = nil;
  }
  [[TGUdp defaultUdp] sendControlWithEquip:btn.equip action:btn.action value:-1];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
