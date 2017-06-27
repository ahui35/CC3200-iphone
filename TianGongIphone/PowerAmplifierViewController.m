//
//  PowerAmplifierViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/20.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "PowerAmplifierViewController.h"
#import "RemoteButton.h"
#import "UIButton+Action.h"

@interface PowerAmplifierViewController ()
{
  NSTimer *timer;
  UIButton *currentBtn;
}

@end

@implementation PowerAmplifierViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  
  for (int i = 0; i < self.equips.count; i ++) {
    TGEquip *equip = [self.equips objectAtIndex:i];
    
    UIScrollView *backView = [[UIScrollView alloc] initWithFrame:CGRectMake(Main_Screen_Width*i,
                                                                            15,
                                                                            Main_Screen_Width,
                                                                            scrollView.frame.size.height - 70)];
    [scrollView addSubview:backView];
    backView.contentSize = CGSizeMake(App_Frame_Width, 415);
    RemoteButton *btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(20, 30, 58, 58);
    btn.remoteType = RemoteTypeShutDown;
    btn.equip = equip;
    [backView addSubview:btn];
    btn.action = @"power";
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(Main_Screen_Width - 20 - 58, 30, 58, 58);
    btn.remoteType = RemoteTypeMute;
    [backView addSubview:btn];
    btn.action = @"mute";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(20, 220, 58, 58);
    btn.remoteType = RemoteTypeBack;
    [backView addSubview:btn];
    btn.action = @"return";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake((Main_Screen_Width - 58)/2, 260, 58, 58);
    btn.remoteType = RemoteTypeMenu;
    [backView addSubview:btn];
    btn.action = @"menu";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(Main_Screen_Width - 20 - 58, 220, 58, 58);
    [btn setImage:[UIImage imageNamed:@"icon_yinxiao"] forState:UIControlStateNormal];
    [backView addSubview:btn];
    btn.action = @"soundeffect";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 266)/2, 340, 266, 51)];
    [backView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"bg_voice"];
    imageV.userInteractionEnabled = YES;
    
    UIImageView *voice = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 10)];
    voice.image = [UIImage imageNamed:@"text_voice"];
    [imageV addSubview:voice];
    voice.center = CGPointMake(imageV.width/2, imageV.height/2);
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(1, 1.5, 48, 48);
    btn.remoteType = RemoteTypeVolumeDown;
    [imageV addSubview:btn];
    btn.action = @"vol-";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToVol:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(cancelForVol:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(imageV.width - 49, 1.5, 48, 48);
    btn.remoteType = RemoteTypeVolumeUp;
    [imageV addSubview:btn];
    btn.action = @"vol+";
    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToVol:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(cancelForVol:) forControlEvents:UIControlEventTouchUpInside];
    
    //方向控制
    UIImageView *controlV = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 214)/2, 40, 214, 214)];
    [backView addSubview:controlV];
    controlV.image = [UIImage imageNamed:@"bg_control"];
    controlV.userInteractionEnabled = YES;
    
    RemoteButton *left = [[RemoteButton alloc] init];
    left.frame = CGRectMake(23, 50, 51, 119);
    left.remoteType = RemoteTypeArrowLeft;
    [controlV addSubview:left];
    left.action = @"left";
    left.equip = equip;
    [left addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    RemoteButton *right = [[RemoteButton alloc] init];
    right.frame = CGRectMake(controlV.width - 51 - 19, 50, 51, 119);
    right.remoteType = RemoteTypeArrowRight;
    [controlV addSubview:right];
    right.action = @"right";
    right.equip = equip;
    [right addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    RemoteButton *up = [[RemoteButton alloc] init];
    up.frame = CGRectMake(49, 24, 119, 51);
    up.remoteType = RemoteTypeArrowUp;
    [controlV addSubview:up];
    up.action = @"up";
    up.equip = equip;
    [up addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    RemoteButton *down = [[RemoteButton alloc] init];
    down.frame = CGRectMake(49, controlV.height - 45 - 25, 119, 51);
    down.remoteType = RemoteTypeArrowDown;
    [controlV addSubview:down];
    down.action = @"down";
    down.equip = equip;
    [down addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    RemoteButton *ok = [[RemoteButton alloc] init];
    ok.frame = CGRectMake(63, 63, 94, 96);
    ok.remoteType = RemoteTypeOK;
    [controlV addSubview:ok];
    ok.action = @"enter";
    ok.equip = equip;
    [ok addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
  }
  scrollView.contentSize = CGSizeMake(Main_Screen_Width*self.equips.count, scrollView.height);
}

- (void)responseToBtn:(UIButton *)btn {
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
