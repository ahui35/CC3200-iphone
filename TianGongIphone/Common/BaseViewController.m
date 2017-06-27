//
//  BaseViewController.m
//  TianGongIphone
//
//  Created by xbwu on 16/1/24.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () {
  UIImageView *titleView;
  UILabel *navTitleLabel;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBackBtn {
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(10, 7, 30, 30);
  [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
  [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  [navBar addSubview:btn];
}

- (void)back {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)creatNavBar {
  self.navigationController.navigationBar.hidden = YES;
  
  navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 44)];
  [self.view addSubview:navBar];
  navBar.image = [UIImage imageNamed:@"navbar"];
  navBar.userInteractionEnabled = YES;
}

- (void)creatScrollView {
  scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                              44,
                                                              Main_Screen_Width,
                                                              App_Frame_Height - 64)];
  scrollView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:scrollView];
  scrollView.pagingEnabled = YES;
}

- (void)setNavTitle:(NSString *)navTitle {
  _navTitle = navTitle;
  if (navTitleLabel == nil) {
    navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((Main_Screen_Width - 250)/2,
                                                              7,
                                                              250,
                                                              30)];
    [navBar addSubview:navTitleLabel];
    navTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    navTitleLabel.textColor = [UIColor whiteColor];
    navTitleLabel.textAlignment = 1;
  }
  navTitleLabel.text = navTitle;
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
