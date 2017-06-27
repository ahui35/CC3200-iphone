//
//  SettingViewController.m
//  TianGongIphone
//
//  Created by xbwu on 16/1/28.
//  Copyright (c) 2016年 com.int-hub.demo. All rights reserved.
//

#import "SettingViewController.h"
#import "UpdateView.h"
#import "IPView.h"
#import "TGUserCenter.h"
#import "DDNSView.h"
#import "PortView.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate> {
  NSArray *_itemsArray;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      Main_Screen_Width,
                                                                      Main_Screen_Height)];
  bgView.image = [UIImage imageNamed:@"bg_login"];
  bgView.userInteractionEnabled = YES;
  [self.view addSubview:bgView];
  
  [self creatNavBar];
  [self showBackBtn];
  [self setNavTitle:@"设置"];

  UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                     44,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height - 44)];
  table.backgroundColor = [UIColor clearColor];
  [self.view addSubview:table];
  table.dataSource = self;
  table.delegate = self;
  table.separatorStyle = 0;

  _itemsArray = @[@"显示设备端口号", @"显示设备ip地址", @"显示设备域名地址", @"配置更新"];
    // Do any additional setup after loading the view.
}

- (void)back {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 43, App_Frame_Width, 0.5)];
    [cell addSubview:line];
    line.backgroundColor = [UIColor whiteColor];
  }
  cell.textLabel.textColor = [UIColor whiteColor];
  cell.textLabel.text = _itemsArray[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.row == 3) {
    UpdateView *updateView = [[UpdateView alloc] initWithFrame:CGRectMake(0, 0, 290, 240)];
    [updateView showInView:self.view animated:YES];
  }
  else if (indexPath.row == 2) {
    DDNSView *ddnsView = [[DDNSView alloc] initWithFrame:CGRectMake(0, 0, 290, 240)];
    [ddnsView showInView:self.view animated:YES];
  }
  else if (indexPath.row == 1) {
    IPView *ipView = [[IPView alloc] initWithFrame:CGRectMake(0, 0, 290, 240)];
    [ipView showInView:self.view animated:YES];
  }
  else if (indexPath.row == 0) {
    PortView *port = [[PortView alloc] initWithFrame:CGRectMake(0, 0, 290, 240)];
    [port showInView:self.view animated:YES];
  }
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
