//
//  Macro.h
//  CMS
//
//  Created by xbwu on 14-5-23.
//  Copyright (c) 2014年 xbwu. All rights reserved.
//

#ifndef CMS_Macro_h
#define CMS_Macro_h

#pragma mark - Frame (宏 x, y, width, height)

// Screen Scale
#define MainScreenScale         [[UIScreen mainScreen] scale]

// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] bounds].size.height
#define App_Frame_Width         [[UIScreen mainScreen] bounds].size.width

// MainScreen Height&Widthx`
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define Nav_Content_Height      [[UIScreen mainScreen] applicationFrame].size.height - 44

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define ios7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#ifdef DEBUG
#define DLog(format, ...) NSLog((format), ##__VA_ARGS__)
#else
#define DLog(format, ...)
#endif

#endif
