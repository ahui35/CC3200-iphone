//
//  BaseViewController.h
//  TianGongIphone
//
//  Created by xbwu on 16/1/24.
//  Copyright © 2016年 com.int-hub.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController {
  UIScrollView *scrollView;
  UIImageView *navBar;
}

- (void)addBgView;

- (void)setTitleImage:(NSString *)image;
- (void)creatNavBar;

- (void)creatScrollView;
- (void)showBackBtn;

@property (nonatomic, strong) NSArray *equips;
@property (nonatomic, strong) TGEquip *equip;
@property (nonatomic, strong) NSString *navTitle;

@end
