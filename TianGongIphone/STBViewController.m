//
//  STBViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/22.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "STBViewController.h"
#import "RemoteButton.h"

@interface STBViewController ()
{
  NSTimer *timer;
  UIButton *currentBtn;
}


@end

@implementation STBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    bgView.image = [UIImage imageNamed:@"bg_music"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    sv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sv];
    sv.contentSize = CGSizeMake(Main_Screen_Width, 725);
    
    RemoteButton *btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(20, 30 + 64, 58, 58);
    btn.remoteType = RemoteTypeShutDown;
    //    btn.equip = equip;
    [sv addSubview:btn];
    btn.action = @"power";
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(Main_Screen_Width - 20 - 58, 30 + 64, 58, 58);
    btn.remoteType = RemoteTypeStart;
    [sv addSubview:btn];
    btn.action = @"power1";
    //    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(20, 220 + 64, 58, 58);
    btn.remoteType = RemoteTypeMenu;
    [sv addSubview:btn];
    btn.action = @"menu";
    //    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(Main_Screen_Width - 20 - 58, 220 + 64, 58, 58);
    btn.remoteType = RemoteTypeBack;
    [sv addSubview:btn];
    btn.action = @"return";
    //    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //方向控制
    UIImageView *controlV = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 214)/2, 40 + 64, 214, 214)];
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
    
    
    NSArray *actions = @[@"1",
                         @"2",
                         @"3",
                         @"4",
                         @"5",
                         @"6",
                         @"7",
                         @"8",
                         @"9",
                         @"0",
                         @"separator",
                         @"source"];
    NSArray *titles = @[@"btn_no1",
                        @"btn_no2",
                        @"btn_no3",
                        @"btn_no4",
                        @"btn_no5",
                        @"btn_no6",
                        @"btn_no7",
                        @"btn_no8",
                        @"btn_no9",
                        @"btn_no0",
                        @"btn_no11",
                        @"btn_noavtv"];
    for (int i = 0; i < 12; i++) {
        int row = i/3;
        int column = i%3;
        btn = [[RemoteButton alloc] init];
        btn.frame = CGRectMake(12 + 80*column, 64 + 290 + 54 *row, 76, 50);
        [btn setBackgroundImage:[UIImage imageNamed:titles[i]] forState:UIControlStateNormal];
        [sv addSubview:btn];
        btn.action = [actions objectAtIndex:i];
        [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //voice
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 514 + 64, 233, 49)];
    [sv addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"bg_voice"];
    imageV.userInteractionEnabled = YES;
    
    UIImageView *voice = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 10)];
    voice.image = [UIImage imageNamed:@"text_voice"];
    [imageV addSubview:voice];
    voice.center = CGPointMake(imageV.width/2, imageV.height/2);
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(2, 1, 48, 48);
    btn.remoteType = RemoteTypeVolumeDown;
    [imageV addSubview:btn];
    btn.action = @"vol-";
    //    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToVol:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(cancelForVol:) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(imageV.width - 48, 1, 48, 48);
    btn.remoteType = RemoteTypeVolumeUp;
    [imageV addSubview:btn];
    btn.action = @"vol+";
    //    btn.equip = equip;
    [btn addTarget:self action:@selector(responseToVol:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(cancelForVol:) forControlEvents:UIControlEventTouchUpInside];

    //频道
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(253, 64 + 289, 59, 56);
    [btn setImage:[UIImage imageNamed:@"btn_volume_up"] forState:UIControlStateNormal];
    [sv addSubview:btn];
    btn.action = @"p+";
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame), 59, 97)];
    [sv addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"btn_volume_middletext"];
    
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(CGRectGetMinX(imageV.frame), CGRectGetMaxY(imageV.frame), 59, 61);
    [btn setImage:[UIImage imageNamed:@"btn_volume_down"] forState:UIControlStateNormal];
    [sv addSubview:btn];
    btn.action = @"p-";
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //静音
    btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(254, 575, 56, 56);
    btn.remoteType = RemoteTypeMute;
    [sv addSubview:btn];
    btn.action = @"mute";
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
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
