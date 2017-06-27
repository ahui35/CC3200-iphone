//
//  RoomViewController.m
//  TianGongIphone
//
//  Created by sgao on 16/1/12.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import "RoomViewController.h"
#import "MainViewController.h"

@interface RoomViewController () <UIActionSheetDelegate> {
  NSArray *floors;
  NSArray *rooms;
  UIButton *rightBtn;
}

@end

@implementation RoomViewController

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
  
  [self creatScrollView];
  [self creatNavBar];
  self.navTitle = @"选择房间";

  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [navBar addSubview:rightBtn];
  rightBtn.frame = CGRectMake(App_Frame_Width - 70, 7, 60, 30);
  rightBtn.layer.borderWidth = 1;
  rightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
  rightBtn.layer.cornerRadius = 5;
  [rightBtn addTarget:self action:@selector(floorSelect) forControlEvents:UIControlEventTouchUpInside];
  floors = [TGDBManager allFloors];
}

- (void)floorSelect {
  
  UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"楼层选择"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:nil];
  for (TGFloor *floor in floors) {
    [sheet addButtonWithTitle:floor.floorName];
  }
  [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex > 0) {
    self.selectedFloor = buttonIndex - 1;
  }
}

- (void)setSelectedFloor:(NSInteger)selectedFloor {
  _selectedFloor = selectedFloor;
  if (selectedFloor >= floors.count) {
    return;
  }
  //  UIButton *b = (UIButton *)[self.view viewWithTag:self.selectedFloor + 10000];
  //  b.selected = YES;
  
  [scrollView removeAllSubViews];
  
  TGFloor *floor = [floors objectAtIndex:selectedFloor];
  rooms = [TGDBManager roomsForFloor:floor.floorId];
  [rightBtn setTitle:floor.floorName forState:UIControlStateNormal];
  
  float h = 0;
  float gap = (App_Frame_Width - 86*3 - 28)/2;
  NSInteger count = rooms.count;
  for (int i = 0; i < count; i++) {
    TGRoom *room = [rooms objectAtIndex:i];
    int row = i/3;
    int column = i%3;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    button.frame = CGRectMake(14 + (gap + 86) * column, 16 + 121 * row, 86, 86);
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img_room_%d", room.style]]
            forState:UIControlStateNormal];
    
    [scrollView addSubview:button];
    [button addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 100 + i;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(button.frame),
                                                               CGRectGetMaxY(button.frame),
                                                               86,
                                                               25)];
    [scrollView addSubview:label];
    label.textAlignment = 1;
    label.text = room.roomName;
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    label.tag = 100000 + i;
    h = CGRectGetMaxY(label.frame) + 10;
  }
  
  //居中
  if (count%3 == 1) {
    UIButton *button = [self.view viewWithTag:count - 1 + 100];
    UIButton *label = [self.view viewWithTag:count - 1 + 100000];
    button.frame = CGRectMake(App_Frame_Width/2 - 86/2, button.frame.origin.y, 86, 86);
    label.frame = CGRectMake(CGRectGetMinX(button.frame),
                             CGRectGetMaxY(button.frame),
                             86,
                             25);
  }
  if (count%3 == 2) {
    UIButton *button1 = [self.view viewWithTag:count - 2 + 100];
    UIButton *label1 = [self.view viewWithTag:count - 2 + 100000];
    UIButton *button2 = [self.view viewWithTag:count - 1 + 100];
    UIButton *label2 = [self.view viewWithTag:count - 1 + 100000];
    button1.frame = CGRectMake((App_Frame_Width - (86*2 + gap))/2, button1.frame.origin.y, 86, 86);
    button2.frame = CGRectMake(button1.frame.origin.x + (gap + 86), button2.frame.origin.y, 86, 86);
    label1.frame = CGRectMake(CGRectGetMinX(button1.frame),
                              CGRectGetMaxY(button1.frame),
                              86,
                              25);
    label2.frame = CGRectMake(CGRectGetMinX(button2.frame),
                              CGRectGetMaxY(button2.frame),
                              86,
                              25);
  }
  
  scrollView.contentSize = CGSizeMake(scrollView.width, h);
}

- (void)home:(UIButton *)btn {
  NSInteger index = btn.tag - 100;
  TGRoom *room = [rooms objectAtIndex:index];
  MainViewController *home = [[MainViewController alloc] init];
  home.roomId = room.roomId;
  TGFloor *floor = [floors objectAtIndex:_selectedFloor];
  home.roomName = [NSString stringWithFormat:@"%@.%@", floor.floorName, room.roomName];
  [self presentViewController:home animated:YES completion:NULL];
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
