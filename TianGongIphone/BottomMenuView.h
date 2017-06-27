//
//  BottomMenuView.h
//  TianGong
//
//  Created by xbwu on 15/9/16.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomMenuViewDelegate <NSObject>

- (void)menuClickedAtIndex:(NSInteger)index;

@end

@interface BottomMenuView : UIView {
	UIImageView *menuBgView;
	UIScrollView *scrollView;
}

@property (nonatomic, weak) id<BottomMenuViewDelegate> delegate;
@property (nonatomic, strong) NSArray *scenes;

@end
