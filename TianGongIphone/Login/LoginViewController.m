//
//  LoginViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/11.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "LoginViewController.h"
#import "CommonTF.h"
#import "RoomViewController.h"
#import "SettingViewController.h"

@interface LoginViewController () {
  CommonTF *nameTF;
  CommonTF *pwdTF;
  UISwitch *sw;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        Main_Screen_Width,
                                                                        Main_Screen_Height)];
    bgView.image = [UIImage imageNamed:@"bg_login"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 312)/2,
                                                                          0,
                                                                          312,
                                                                          175)];
    headView.image = [UIImage imageNamed:@"logo_login"];
    [bgView addSubview:headView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user"]];
    nameTF = [[CommonTF alloc] initWithFrame:CGRectMake(30,
                                                        CGRectGetMaxY(headView.frame) - 20,
                                                        Main_Screen_Width - 50,
                                                        40)];
    nameTF.backgroundColor = [UIColor clearColor];
    nameTF.leftView = leftView;
    nameTF.font = [UIFont systemFontOfSize:15];
    nameTF.leftViewMode = UITextFieldViewModeAlways;
    nameTF.textColor = [UIColor whiteColor];
    nameTF.placeholder = @"用户账号";
    [nameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [bgView addSubview:nameTF];
    nameTF.text = [TGUserCenter defaultCenter].userName;

    UIImageView *lineImageV = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 280)/2,
                                                                            CGRectGetMaxY(nameTF.frame) - 0.5,
                                                                            280,
                                                                            0.5)];
    lineImageV.image = [UIImage imageNamed:@"line_inputbox"];
    [bgView addSubview:lineImageV];

    leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"]];
    pwdTF = [[CommonTF alloc] initWithFrame:CGRectMake(30,
                                                       CGRectGetMaxY(nameTF.frame) + 10,
                                                       Main_Screen_Width - 50,
                                                       40)];
    pwdTF.backgroundColor = [UIColor clearColor];
    pwdTF.leftView = leftView;
    pwdTF.font = [UIFont systemFontOfSize:15];
    pwdTF.leftViewMode = UITextFieldViewModeAlways;
    pwdTF.textColor = [UIColor whiteColor];
    pwdTF.placeholder = @"登录密码";
    pwdTF.secureTextEntry = YES;
    [pwdTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [bgView addSubview:pwdTF];
    pwdTF.text = [TGUserCenter defaultCenter].password;

    lineImageV = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 280)/2,
                                                               CGRectGetMaxY(pwdTF.frame) - 0.5,
                                                               280,
                                                               0.5)];
    lineImageV.image = [UIImage imageNamed:@"line_inputbox"];
    [bgView addSubview:lineImageV];
    
    UILabel *localNetLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                              CGRectGetMaxY(lineImageV.frame) + 20,
                                                              50,
                                                              20)];
    localNetLabel.backgroundColor = [UIColor clearColor];
    localNetLabel.text = @"内网";
    localNetLabel.textColor = [UIColor colorWithRed:130/255. green:142/255. blue:154/255. alpha:1.];
    localNetLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:localNetLabel];
    
    sw = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(localNetLabel.frame) - 10,
                                                    CGRectGetMinY(localNetLabel.frame) - 5,
                                                    10,
                                                    10)];
    [bgView addSubview:sw];
    sw.onTintColor = [UIColor blackColor];
    sw.tintColor = [UIColor colorWithRed:80/255. green:93/255. blue:114/255. alpha:1.];
    sw.thumbTintColor = [UIColor colorWithRed:130/255. green:142/255. blue:154/255. alpha:1.];
//    [sw addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *etherNetLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sw.frame) + 10,
                                                              CGRectGetMinY(localNetLabel.frame),
                                                              50,
                                                              20)];
    etherNetLabel.backgroundColor = [UIColor clearColor];
    etherNetLabel.text = @"外网";
    etherNetLabel.textColor = [UIColor colorWithRed:130/255. green:142/255. blue:154/255. alpha:1.];
    etherNetLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:etherNetLabel];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor clearColor];
    loginBtn.frame = CGRectMake((Main_Screen_Width - 280)/2, CGRectGetMaxY(lineImageV.frame) + 68, 280, 46);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"button_login_text"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginBtn];
    
    UILabel *copyRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        Main_Screen_Height - 50 - 20,
                                                                        Main_Screen_Width,
                                                                        50)];
    copyRightLabel.backgroundColor = [UIColor clearColor];
    copyRightLabel.font = [UIFont systemFontOfSize:11];
    copyRightLabel.textAlignment = NSTextAlignmentCenter;
    copyRightLabel.text = @"Copy Right智能天工版权所有";
    copyRightLabel.textColor = [UIColor colorWithRed:130/255. green:142/255. blue:154/255. alpha:1.];
    [bgView addSubview:copyRightLabel];
  
  UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  setBtn.frame = CGRectMake(App_Frame_Width - 60, CGRectGetMinY(localNetLabel.frame) - 5, 30, 30);
  [self.view addSubview:setBtn];
  [setBtn setImage:[UIImage imageNamed:@"setting_button"] forState:UIControlStateNormal];
  [setBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(loginSuccess)
                                               name:TGLoginSuccessNotification
                                             object:nil];
}

- (void)setting {
  SettingViewController *set = [[SettingViewController alloc] init];
  [self presentViewController:set animated:YES completion:NULL];
}

- (void)clickLoginBtn
{
#ifdef DEBUG
//		ipTF.text = @"192.168.8.101";
//		portTF.text = @"20000";
		[TGUdp defaultUdp].host = @"192.168.1.23";
		[TGUdp defaultUdp].port = 20000;
		[self loginSuccess];
		return;
#endif
  
  if ([nameTF.text isEqualToString:DemoUserName] && [pwdTF.text isEqualToString:DemoPassword]) {
    [self loginSuccess];
    return;
  }
  if (nameTF.text.length <= 0  || pwdTF.text.length <= 0) {
    [[CCAlertView sharedAlert] showInView:self.view title:@"请输入用户名或密码" animated:YES];
    [[CCAlertView sharedAlert] hide:YES afterDelay:1];
    return;
  }
  
  if (sw.on) {
    [TGUdp defaultUdp].host = [TGUserCenter defaultCenter].ip1;
  }
  else {
    [TGUdp defaultUdp].host = [TGUserCenter defaultCenter].ip;
  }
  
  [TGUdp defaultUdp].port = [[TGUserCenter defaultCenter].port intValue];
  [[TGUdp defaultUdp] loginWithName:nameTF.text password:pwdTF.text];
}

- (void)loginSuccess {
  RoomViewController *room = [[RoomViewController alloc] init];
  [self presentViewController:room animated:YES completion:nil];
  room.selectedFloor = 0;
  //	HomeViewController *homeVC = [[HomeViewController alloc] init];
  //	[self presentViewController:homeVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
