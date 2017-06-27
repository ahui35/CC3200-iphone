//
//  AirConditionerViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/26.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "AirConditionerViewController.h"
#import "Convenience.h"
#import "RemoteButton.h"

@interface AirConditionerViewController () {
  NSMutableArray *array1;//非中央空调
  NSMutableArray *array2;//中央空调
}

@end

@implementation AirConditionerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_music"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatScrollView];
  scrollView.pagingEnabled = YES;
  
  [self creatUI];
}

- (void)creatUI
{
  array1 = [[NSMutableArray alloc] init];
  array2 = [[NSMutableArray alloc] init];
  
  for (TGEquip *equip in self.equips) {
    if (equip.substyle == 2) {
      [array1 addObject:equip];
    }
    if (equip.substyle == 1) {
      [array2 addObject:equip];
    }
  }
  
  //中央空调
  for (int i = 0; i < array1.count; i ++) {
    TGEquip *equip = [array1 objectAtIndex:i];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(App_Frame_Width * i, 0, App_Frame_Width, 390)];
    backView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:backView];
    
    UIImageView *circleBgView = [[UIImageView alloc] initWithFrame:CGRectMake((App_Frame_Width - 174)/2, 74, 174, 174)];
    circleBgView.image = [UIImage imageNamed:@"bg_temputer"];
    [backView addSubview:circleBgView];
    
    //设定温度
    UILabel *temp1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(circleBgView.frame), 60)];
    [circleBgView addSubview:temp1];
    temp1.text = @"20℃";
    temp1.font = [UIFont fontWithName:@"DigifaceWide" size:50];
    temp1.textAlignment = NSTextAlignmentCenter;
    temp1.textColor = [UIColor whiteColor];
    temp1.tag = 500 + i;
    
//    NSMutableAttributedString *atts = attribStringWithAttribs(@[@{@"NSColor":[UIColor whiteColor],
//                                                                  @"NSFont":[UIFont systemFontOfSize:50],
//                                                                  @"Text":@"20"},
//                                                                @{@"NSColor":[UIColor whiteColor],
//                                                                  @"NSFont":[UIFont systemFontOfSize:19],
//                                                                  @"Text":@"℃"}]);
//    temp1.attributedText = atts;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, CGRectGetWidth(circleBgView.frame), 30)];
    [circleBgView addSubview:label];
    label.font = [UIFont systemFontOfSize:19];
    label.text = @"设定温度";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBACOLOR(126, 142, 157, 1.);
    
    //风速
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 100, 25)];
    [backView addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"风速";
    label.textColor = RGBACOLOR(126, 142, 157, 1.);
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(19, CGRectGetMaxY(label.frame), 19, 19)];
    [backView addSubview:icon];
    icon.image = [UIImage imageNamed:@"icon_speed1"];
    
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame),
                                                                    CGRectGetMaxY(label.frame) + 35,
                                                                    100,
                                                                    25)];
    [backView addSubview:speedLabel];
    speedLabel.font = [UIFont systemFontOfSize:14];
    speedLabel.text = @"低速";
    speedLabel.textColor = RGBACOLOR(126, 142, 157, 1.);
    speedLabel.tag = 100 + i;
    
    UIImageView *speedIcon = [[UIImageView alloc] initWithFrame:
                              CGRectMake(CGRectGetMinX(icon.frame),
                                         CGRectGetMaxY(speedLabel.frame),
                                         19,
                                         19)];
    
    [backView addSubview:speedIcon];
    speedIcon.image = [UIImage imageNamed:@"icon_low-speed"];
    speedIcon.tag = 200 + i;
    
    //
    UILabel *directLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame),
                                                                     CGRectGetMaxY(speedLabel.frame) + 35,
                                                                     100,
                                                                     25)];
    [backView addSubview:directLabel];
    directLabel.font = [UIFont systemFontOfSize:14];
    directLabel.text = @"风向";
    directLabel.textColor = RGBACOLOR(126, 142, 157, 1.);
    directLabel.tag = 300 + i;
    
    UIImageView *directIcon = [[UIImageView alloc] initWithFrame:
                               CGRectMake(CGRectGetMinX(icon.frame),
                                          CGRectGetMaxY(directLabel.frame),
                                          19,
                                          19)];
    [backView addSubview:directIcon];
    directIcon.image = [UIImage imageNamed:@"icon_shuiping"];
    directIcon.tag = 400 + i;
    
    //时间
//    UIImageView *timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(26, 232, 15, 15)];
//    timeIcon.image = [UIImage imageNamed:@"icon_clock"];
//    [backView addSubview:timeIcon];
//    
//    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(timeIcon.frame) + 5, 100, 25)];
//    [backView addSubview:timeLabel];
//    timeLabel.font = [UIFont systemFontOfSize:20];
//    timeLabel.text = @"22:20";
//    timeLabel.textColor = [UIColor whiteColor];
    
    //模式
    label = [[UILabel alloc] initWithFrame:CGRectMake(App_Frame_Width - 20 - 100, 45, 100, 25)];
    [backView addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"模式";
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = RGBACOLOR(126, 142, 157, 1.);
    
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(278, CGRectGetMaxY(label.frame), 22, 20)];
    [backView addSubview:icon];
    icon.image = [UIImage imageNamed:@"icon_mode1"];
    
    UILabel *modelLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame) + 35, 100, 25)];
    [backView addSubview:modelLabel];
    modelLabel.font = [UIFont systemFontOfSize:14];
    modelLabel.text = @"冷风";
    modelLabel.textAlignment = NSTextAlignmentRight;
    modelLabel.textColor = RGBACOLOR(126, 142, 157, 1.);
    modelLabel.tag = 700 + i;

    UIImageView *modelIcon = [[UIImageView alloc] initWithFrame:CGRectMake(278, CGRectGetMaxY(modelLabel.frame), 19, 19)];
    [backView addSubview:modelIcon];
    modelIcon.image = [UIImage imageNamed:@"icon_mode_cool"];
    modelIcon.tag = 800 + i;

    //室内温度
    label = [[UILabel alloc] initWithFrame:CGRectMake(250, 230, 100, 20)];
    [backView addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"室内温度";
    label.textColor = RGBACOLOR(126, 142, 157, 1.);
    
    UILabel *temp2 = [[UILabel alloc] initWithFrame:CGRectMake(260, CGRectGetMaxY(label.frame), 80, 30)];
    [backView addSubview:temp2];
    temp2.text = @"20℃";
    temp2.textColor = [UIColor whiteColor];
    temp2.font = [UIFont fontWithName:@"DigifaceWide" size:20];
    temp2.tag = 600 + i;
    
//    atts = attribStringWithAttribs(@[@{@"NSColor":[UIColor whiteColor],
//                                       @"NSFont":[UIFont systemFontOfSize:20],
//                                       @"Text":@"20"},
//                                     @{@"NSColor":[UIColor whiteColor],
//                                       @"NSFont":[UIFont systemFontOfSize:13],
//                                       @"Text":@"℃"}]);
//    temp2.attributedText = atts;

    NSArray *array = [NSArray arrayWithObjects:
                      @"icon_mode",
                      @"icon_speed",
                      @"icon_direction",
                      @"icon_temperaturup",
                      @"icon_temperaturedown", nil];
    
    UIImageView *function = [[UIImageView alloc] initWithFrame:CGRectMake(0, 310, App_Frame_Width, 50)];
    function.backgroundColor = [UIColor clearColor];
    [backView addSubview:function];
    function.userInteractionEnabled = YES;
    
    RemoteButton *btn = [[RemoteButton alloc] init];
    btn.frame = CGRectMake(12, 0, 46, 46);
    btn.remoteType = RemoteTypeShutDown;
    [function addSubview:btn];
    btn.action = @"power";
    [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.equip = equip;
    
    for (int i = 0; i < 5; i++) {
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      btn.frame = CGRectMake(66 + 49*i, 2, 49, 46);
      [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_nor", [array objectAtIndex:i]]]
           forState:UIControlStateNormal];
      [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", [array objectAtIndex:i]]]
           forState:UIControlStateHighlighted];
      [btn addTarget:self
              action:@selector(function:) forControlEvents:UIControlEventTouchUpInside];
      [function addSubview:btn];
      btn.equip = equip;
      btn.tag = 10000 + i;
    }
  }

  //非中央空调
  for (int i = 0; i < array2.count; i ++) {
    TGEquip *equip = [array2 objectAtIndex:i];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(App_Frame_Width * (array1.count + i),
                                                                30,
                                                                App_Frame_Width,
                                                                340)];
    backView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:backView];
    
    NSArray *actions = [NSArray arrayWithObjects:
                        @"power",
                        @"cool",
                        @"heat",
                        @"dry",
                        @"fan",
                        @"swing-a",
                        @"swing-v",
                        @"swing-h",
                        @"fspeed-a",
                        @"fspeed-l",
                        @"fspeed-m",
                        @"fspeed-h",
                        @"18c",
                        @"20c",
                        @"22c",
                        @"24c",
                        @"26c",
                        @"28c",
                        @"30c",
                        nil];
    
    NSArray *imageArray = @[@"icon_off_air",
                            @"bt_zhileng",
                            @"bt_zhire",
                            @"bt_chushi",
                            @"bt_songfeng",
                            @"bt_zidongfx",
                            @"bt_spsf",
                            @"bt_czsf",
                            @"btn_zdsf",
                            @"bt_fld",
                            @"bt_flz",
                            @"bt_flg"];
    for (int j = 0; j < [imageArray count]; j ++) {
      NSInteger row = j/4;
      NSInteger column = j%4;
      
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      btn.backgroundColor = [UIColor clearColor];
      btn.frame = CGRectMake(10 + 75 * column, 50 + 75 * row, 71, 69);
      if (j == 0) {
        btn.frame = CGRectMake(14, 53, 63, 63);
      }
      [btn setImage:[UIImage imageNamed:imageArray[j]] forState:UIControlStateNormal];
      [backView addSubview:btn];
      btn.action = [actions objectAtIndex:j];
      btn.equip = equip;
      [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSArray *numArray = @[@"icon_18",
                          @"icon_20",
                          @"icon_22",
                          @"icon_24",
                          @"icon_26",
                          @"icon_28",
                          @"icon_30"];
    for (int j = 0; j < 7; j ++) {
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      btn.backgroundColor = [UIColor clearColor];
      btn.frame = CGRectMake(10 + 42 * j, 338 - 60, 45.5, 45);
      
      [btn setImage:[UIImage imageNamed:numArray[j]] forState:UIControlStateNormal];
      [backView addSubview:btn];
      btn.action = [actions objectAtIndex:j + 12];
      btn.equip = equip;
      [btn addTarget:self action:@selector(responseToBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
  }
  scrollView.contentSize = CGSizeMake(Main_Screen_Width  * (array1.count + array2.count), scrollView.frame.size.height);
  
  [self reloadStatus];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reloadStatus)
                                               name:TGDevideSyncNotification
                                             object:nil];
}

- (void)reloadStatus {
  NSInteger i = 0;
  for (TGEquip *equip in array1) {
    NSDictionary *status = [[TGUdp defaultUdp] statusForRoomID:equip.roomid
                                                        nodeId:equip.equipaddr
                                                         style:equip.equipstyle];
    if (status != nil) {
      [self reloadModel:[status objectForKey:@"mode"] Index:i];
      [self reloadSpeed:[status objectForKey:@"speed"] Index:i];
      [self reloadFan:[status objectForKey:@"fan"] Index:i];
      //设定温度
      UILabel *temp1 = (UILabel *)[self.view viewWithTag:500 + i];
      temp1.text = [NSString stringWithFormat:@"%d℃", [[status objectForKey:@"value2"] intValue]];
      //室内温度
      UILabel *temp2 = (UILabel *)[self.view viewWithTag:600 + i];
      temp2.text = [NSString stringWithFormat:@"%d℃", [[status objectForKey:@"value1"] intValue]];
    }
    i++;
  }
}

- (void)reloadModel:(NSString *)s Index:(NSInteger)index {
  UILabel *modeLabel = (UILabel *)[self.view viewWithTag:700 + index];
  UIImageView *modeIcon = (UIImageView *)[self.view viewWithTag:800 + index];
  if ([s isEqualToString:@"cool"]) {
    modeLabel.text = @"制冷";
    modeIcon.image = [UIImage imageNamed:@"icon_mode_cool"];
  }
  if ([s isEqualToString:@"heat"]) {
    modeLabel.text = @"制热";
    modeIcon.image = [UIImage imageNamed:@"icon_mode_hot"];
  }
  if ([s isEqualToString:@"dry"]) {
    modeLabel.text = @"除湿";
    modeIcon.image = [UIImage imageNamed:@"icon_mode_water"];
  }
  if ([s isEqualToString:@"fan"]) {
    modeLabel.text = @"送风";
    modeIcon.image = [UIImage imageNamed:@"icon_mode_wind"];
  }
}

- (void)reloadFan:(NSString *)s Index:(NSInteger)index {
  UILabel *directLabel = (UILabel *)[self.view viewWithTag:300 + index];
  UIImageView *directIcon = (UIImageView *)[self.view viewWithTag:400 + index];
  if ([s isEqualToString:@"swing-h"]) {
    directLabel.text = @"垂直扫风";
    directIcon.image = [UIImage imageNamed:@"icon_chuizhi"];
  }
  if ([s isEqualToString:@"swing-v"]) {
    directLabel.text = @"水平扫风";
    directIcon.image = [UIImage imageNamed:@"icon_shuiping"];
  }
  if ([s isEqualToString:@"swing-a"]) {
    directLabel.text = @"自动扫风";
    directIcon.image = [UIImage imageNamed:@"icon_recycle"];
  }
}

- (void)reloadSpeed:(NSString *)s Index:(NSInteger)index {
  UILabel *speedLabel = (UILabel *)[self.view viewWithTag:100 + index];
  UIImageView *speedIcon = (UIImageView *)[self.view viewWithTag:200 + index];
  if ([s isEqualToString:@"fspeed-l"]) {
    speedLabel.text = @"风量低";
    speedIcon.image = [UIImage imageNamed:@"icon_low-speed"];
  }
  if ([s isEqualToString:@"fspeed-m"]) {
    speedLabel.text = @"风量中";
    speedIcon.image = [UIImage imageNamed:@"icon_m-speed"];
  }
  if ([s isEqualToString:@"fspeed-h"]) {
    speedLabel.text = @"风量高";
    speedIcon.image = [UIImage imageNamed:@"icon_speed_big"];
  }
  if ([s isEqualToString:@"fspeed-a"]) {
    speedLabel.text = @"自动风量";
    speedIcon.image = [UIImage imageNamed:@"icon_a-speed"];
  }
}

- (void)function:(UIButton *)btn {
  NSString *action = nil;
  switch (btn.tag) {
    case 10000:
      action = @"mode";
      break;
    case 10001:
      action = @"fspeed";
      break;
    case 10002:
      action = @"swing";
      break;
    case 10003:
      action = @"temp+";
      break;
    case 10004:
      action = @"temp-";
      break;
    default:
      break;
  }
  [[TGUdp defaultUdp] sendControlWithEquip:btn.equip action:action value:-1];
}

- (void)responseToBtn:(UIButton *)btn {
  [[TGUdp defaultUdp] sendControlWithEquip:btn.equip action:btn.action value:-1];
  /*
   if (btn.tag >= 1000) {
   TGEquip *equip = [array2 objectAtIndex:btn.tag - 1000];
   [[TGUdp defaultUdp] sendControlWithEquip:equip action:btn.action value:-1];
   }
   else
   {
   TGEquip *equip = [array1 objectAtIndex:btn.tag];
   [[TGUdp defaultUdp] sendControlWithEquip:equip action:btn.action value:-1];
   }
   */
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
