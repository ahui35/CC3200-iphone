//
//  HardDiskPlayerViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/22.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "HardDiskPlayerViewController.h"
#import "RemoteButton.h"

@interface HardDiskPlayerViewController ()
{
  NSTimer *timer;
  UIButton *currentBtn;
}

@end

@implementation HardDiskPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  sv.backgroundColor = [UIColor clearColor];
  [self.view addSubview:sv];
  sv.contentSize = CGSizeMake(Main_Screen_Width, 700);
  
  RemoteButton *btn = [[RemoteButton alloc] init];
  btn.frame = CGRectMake(20, 25 + 64, 58, 58);
  btn.remoteType = RemoteTypeShutDown;
  //    btn.equip = equip;
  [sv addSubview:btn];
  btn.action = @"power";
  [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  btn = [[RemoteButton alloc] init];
  btn.frame = CGRectMake(Main_Screen_Width - 20 - 58, 25 + 64, 58, 58);
  btn.remoteType = RemoteTypeMute;
  [sv addSubview:btn];
  btn.action = @"mute";
  //    btn.equip = equip;
  [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  btn = [[RemoteButton alloc] init];
  btn.frame = CGRectMake(20, 215 + 64, 58, 58);
  btn.remoteType = RemoteTypeMenu;
  [sv addSubview:btn];
  btn.action = @"menu";
  //    btn.equip = equip;
  [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  btn = [[RemoteButton alloc] init];
  btn.frame = CGRectMake(Main_Screen_Width - 20 - 58, 215 + 64, 58, 58);
  btn.remoteType = RemoteTypeBack;
  [sv addSubview:btn];
  btn.action = @"return";
  //    btn.equip = equip;
  [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  //方向控制
  UIImageView *controlV = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 214)/2, 35 + 64, 214, 214)];
  [sv addSubview:controlV];
  controlV.image = [UIImage imageNamed:@"bg_control"];
  controlV.userInteractionEnabled = YES;
  
  RemoteButton *left = [[RemoteButton alloc] init];
  //    left.frame = CGRectMake(34, 69, 51, 119);
  left.frame = CGRectMake(23, 50, 51, 119);
  left.remoteType = RemoteTypeArrowLeft;
  [controlV addSubview:left];
  left.action = @"left";
  //    left.equip = equip;
  [left addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  RemoteButton *right = [[RemoteButton alloc] init];
  right.frame = CGRectMake(controlV.width - 51 - 19, 50, 51, 119);
  right.remoteType = RemoteTypeArrowRight;
  [controlV addSubview:right];
  right.action = @"right";
  //    right.equip = equip;
  [right addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  RemoteButton *up = [[RemoteButton alloc] init];
  up.frame = CGRectMake(49, 24, 119, 51);
  up.remoteType = RemoteTypeArrowUp;
  [controlV addSubview:up];
  up.action = @"up";
  //    up.equip = equip;
  [up addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  RemoteButton *down = [[RemoteButton alloc] init];
  down.frame = CGRectMake(49, controlV.height - 45 - 25, 119, 51);
  down.remoteType = RemoteTypeArrowDown;
  [controlV addSubview:down];
  down.action = @"down";
  //    down.equip = equip;
  [down addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  RemoteButton *ok = [[RemoteButton alloc] init];
  ok.frame = CGRectMake(63, 63, 94, 96);
  ok.remoteType = RemoteTypeOK;
  [controlV addSubview:ok];
  ok.action = @"enter";
  //    ok.equip = equip;
  [ok addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  NSArray *actions = @[@"subtitle",
                       @"language",
                       @"eject",
                       @"display",
                       ];
  NSArray *images = [NSArray arrayWithObjects:
                     @"btn_zimu",
                     @"btn_yuyan",
                     @"btn_chucang",
                     @"btn_xianshi",
                     nil];
  for (int i = 0; i < 4; i++) {
    int row = i/2;
    int column = i%2;
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(12 + 108*column, 284 + 64 + 56 *row, 102, 53);
    [btn setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
    [sv addSubview:btn];
    btn.action = [actions objectAtIndex:i];
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  }
  
  btn = [[RemoteButton alloc] init];
  btn.frame = CGRectMake(230, 284 + 64, 80, 108);
  [btn setBackgroundImage:[UIImage imageNamed:@"vtn_home"] forState:UIControlStateNormal];
  [sv addSubview:btn];
  btn.action = @"home";
  [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  
  UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(11, 64 + 473, 174, 50)];
  [sv addSubview:imageV];
  imageV.image = [UIImage imageNamed:@"bg_voice_bluRay"];
  imageV.userInteractionEnabled = YES;
  
  UIImageView *voice = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 10)];
  voice.image = [UIImage imageNamed:@"text_voice"];
  [imageV addSubview:voice];
  voice.center = CGPointMake(imageV.width/2, imageV.height/2);
  
  actions = @[@"play",
              @"stop",
              @"pause",
              @"backward",
              @"forward"];
  NSArray *array = [NSArray arrayWithObjects:@(RemoteTypePlay),
                    @(RemoteTypeStop),
                    @(RemoteTypePause),
                    @(RemoteTypeReverse),
                    @(RemoteTypeForward),nil];
  for (int i = 0; i < 5; i++) {
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(10 + 62*i, 64 + 405, 58, 58);
    btn.remoteType = [[array objectAtIndex:i] intValue];
    [sv addSubview:btn];
    btn.action = [actions objectAtIndex:i];
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  }
  
  actions = @[@"vol-",
              @"",
              @"vol+",
              @"last",
              @"next"];
  array = [NSArray arrayWithObjects:@(RemoteTypeVolumeDown),
           @(-1),
           @(RemoteTypeVolumeUp),
           @(RemoteTypePrev),
           @(RemoteTypeNext),nil];
  for (int i = 0; i < 5; i++) {
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(10 + 62*i, 64 + 471, 58, 58);
    if (i < 3) {
      btn.frame = CGRectMake(13 + 62*i, 64 + 475, 48, 48);
    }
    btn.remoteType = [[array objectAtIndex:i] intValue];
    [sv addSubview:btn];
    NSString *_action = [actions objectAtIndex:i];
    btn.action = _action;
    if ([_action isEqualToString:@"vol+"] || [_action isEqualToString:@"vol-"]) {
      [btn addTarget:self action:@selector(responseToVol:) forControlEvents:UIControlEventTouchDown];
      [btn addTarget:self action:@selector(cancelForVol:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
      [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
  }
}

- (void)responseToBtn:(UIButton *)btn{
  [[TGUdp defaultUdp] sendControlWithEquip:self.equip action:btn.action value:-1];
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
  [[TGUdp defaultUdp] sendControlWithEquip:self.equip action:currentBtn.action value:-1];
}

- (void)cancelForVol:(UIButton *)btn {
  if (timer) {
    [timer invalidate];
    timer = nil;
  }
  [[TGUdp defaultUdp] sendControlWithEquip:self.equip action:btn.action value:-1];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
