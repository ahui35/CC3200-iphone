//
//  RemoteButton.h
//  TianGong
//
//  Created by xbwu on 15/9/20.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	RemoteTypeShutDown,			//关机
	RemoteTypeStart,				//开机
	RemoteTypePlay,
	RemoteTypePause,
	RemoteTypeStop,
	RemoteTypeVolumeUp,     //音量大
	RemoteTypeVolumeDown,		//音量下
	RemoteTypeMute,					//静音
	RemoteTypeChannelNext,  //频道上
	RemoteTypeChannelPrev,	//频道下
	RemoteTypeMenu,					//menu
	RemoteTypeBack,					//返回
	RemoteTypeOK,						//ok
	RemoteTypeArrowUp,			//上下左右箭头
	RemoteTypeArrowDown,
	RemoteTypeArrowLeft,
	RemoteTypeArrowRight,
	RemoteTypeNumber1,
	RemoteTypeNumber2,
	RemoteTypeNumber3,
	RemoteTypeNumber4,
	RemoteTypeNumber5,
	RemoteTypeNumber6,
	RemoteTypeNumber7,
	RemoteTypeNumber8,
	RemoteTypeNumber9,
	RemoteTypeNumber0,
	RemoteTypeAVTV,					//AVTV
	RemoteTypeSlash,				//斜杠/
	RemoteTypeForward,			//快进
	RemoteTypeReverse,			//倒退
	RemoteTypeHome,					//主页
	RemoteTypeSubtitles,		//字幕
	RemoteTypeSpeech,				//语音
	RemoteTypeDischarger,		//出仓
	RemoteTypeSource,				//视源
	RemoteTypeNext,					//上一首
	RemoteTypePrev,					//下一首
  RemoteTypeLanguage,     //语言
  RemoteTypeShow          //显示

} RemoteType;

@interface RemoteButton : UIButton

@property (nonatomic, assign) RemoteType remoteType;

@end
