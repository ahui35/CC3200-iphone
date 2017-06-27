//
//  BottomMenuView.m
//  TianGong
//
//  Created by xbwu on 15/9/16.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "BottomMenuView.h"
#import "TGUdp.h"
#import "UIAlertView+Block.h"

@implementation BottomMenuView

//CGRectMake(2, 615, 890, 135)
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		menuBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70 - 28, Main_Screen_Width, 28)];
		menuBgView.image = [UIImage imageNamed:@"bg_footer_mune"];
		menuBgView.userInteractionEnabled = YES;
		[self addSubview:menuBgView];
        
		scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
		[self addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
	}
	return self;
}

- (void)setScenes:(NSArray *)scenes {
	float w = 0;
	_scenes = scenes;
  
  float origin = 16;
  if (scenes.count < 4) {
    origin = (Main_Screen_Width - 76*(scenes.count - 1) - 60) / 2;
  }
  for (int i = 0; i < scenes.count; i ++) {
    TGScene *scene = [scenes objectAtIndex:i];
		UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		menuBtn.frame = CGRectMake(origin + 76*i, 0, 60, 70);
		[menuBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_footer_%d", i%4 + 1]]
											 forState:UIControlStateNormal];
		[menuBtn addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
		[scrollView addSubview:menuBtn];
		menuBtn.tag = 100 + i;
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70 - 24, 60, 24)];
		[menuBtn addSubview:label];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = 1;
		label.font = [UIFont boldSystemFontOfSize:11];
		label.text = scene.scenename;
		
		w = CGRectGetMaxX(menuBtn.frame);
	}
	scrollView.contentSize = CGSizeMake(w + 16, 70);
}

- (void)clickMenuBtn:(UIButton *)btn {
  NSInteger index = btn.tag - 100;
  TGScene *scene = [_scenes objectAtIndex:index];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                  message:[NSString stringWithFormat:@"是否启动%@模式", scene.scenename]
                                                 delegate:self
                                        cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
  
  [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
    if (buttonIndex == 1) {
      TGEquip *equip = [[TGEquip alloc] init];
      equip.equipaddr = scene.sceneaddr;
      equip.roomid = scene.roomid;
      [[TGUdp defaultUdp] sendSceneWithEquip:equip action:@"" value:-1];
      
      if ([self.delegate respondsToSelector:@selector(menuClickedAtIndex:)]) {
        [self.delegate menuClickedAtIndex:btn.tag - 100];
      }
    }
  }];
}

@end
