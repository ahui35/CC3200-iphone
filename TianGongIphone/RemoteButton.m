//
//  RemoteButton.m
//  TianGong
//
//  Created by xbwu on 15/9/20.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "RemoteButton.h"

@implementation RemoteButton

- (void)setRemoteType:(RemoteType)remoteType {
	_remoteType = remoteType;
	NSString *imageName;
	switch (remoteType) {
		case RemoteTypeShutDown:
			imageName = @"RemoteTypeShutDown";
			break;
		case RemoteTypeStart:
			imageName = @"RemoteTypeStart";
			break;
		case RemoteTypePlay:
			imageName = @"RemoteTypePlay";
			break;
		case RemoteTypePause:
			imageName = @"RemoteTypePause";
			break;
		case RemoteTypeStop:
			imageName = @"RemoteTypeStop";
			break;
		case RemoteTypeVolumeUp:
			imageName = @"RemoteTypeVolumeUp";
			break;
		case RemoteTypeVolumeDown:
			imageName = @"RemoteTypeVolumeDown";
			break;
		case RemoteTypeMute:
			imageName = @"RemoteTypeMute";
			break;
		case RemoteTypeChannelNext:
			imageName = @"RemoteTypeChannelNext";
			break;
		case RemoteTypeChannelPrev:
			imageName = @"RemoteTypeChannelPrev";
			break;
		case RemoteTypeMenu:
			imageName = @"RemoteTypeMenu";
			break;
		case RemoteTypeBack:
			imageName = @"RemoteTypeBack";
			break;
		case RemoteTypeOK:
			imageName = @"RemoteTypeOK";
			break;
		case RemoteTypeArrowUp:
			imageName = @"RemoteTypeArrowUp";
			break;
		case RemoteTypeArrowDown:
			imageName = @"RemoteTypeArrowDown";
			break;
		case RemoteTypeArrowLeft:
			imageName = @"RemoteTypeArrowLeft";
			break;
		case RemoteTypeArrowRight:
			imageName = @"RemoteTypeArrowRight";
			break;
		case RemoteTypeNumber1:
			imageName = @"RemoteTypeNumber1";
			break;
		case RemoteTypeNumber2:
			imageName = @"RemoteTypeNumber2";
			break;
		case RemoteTypeNumber3:
			imageName = @"RemoteTypeNumber3";
			break;
		case RemoteTypeNumber4:
			imageName = @"RemoteTypeNumber4";
			break;
		case RemoteTypeNumber5:
			imageName = @"RemoteTypeNumber5";
			break;
		case RemoteTypeNumber6:
			imageName = @"RemoteTypeNumber6";
			break;
		case RemoteTypeNumber7:
			imageName = @"RemoteTypeNumber7";
			break;
		case RemoteTypeNumber8:
			imageName = @"RemoteTypeNumber8";
			break;
		case RemoteTypeNumber9:
			imageName = @"RemoteTypeNumber9";
			break;
		case RemoteTypeNumber0:
			imageName = @"RemoteTypeNumber0";
			break;
		case RemoteTypeAVTV:
			imageName = @"RemoteTypeAVTV";
			break;
		case RemoteTypeSlash:
			imageName = @"RemoteTypeSlash";
			break;
		case RemoteTypeForward:
			imageName = @"RemoteTypeForward";
			break;
		case RemoteTypeReverse:
			imageName = @"RemoteTypeReverse";
			break;
		case RemoteTypeHome:
			imageName = @"RemoteTypeHome";
			break;
		case RemoteTypeSubtitles:
			imageName = @"RemoteTypeSubtitles";
			break;
		case RemoteTypeSpeech:
			imageName = @"RemoteTypeSpeech";
			break;
		case RemoteTypeDischarger:
			imageName = @"RemoteTypeDischarger";
			break;
		case RemoteTypeSource:
			imageName = @"RemoteTypeSource";
			break;
		case RemoteTypeNext:
			imageName = @"RemoteTypeNext";
			break;
		case RemoteTypePrev:
			imageName = @"RemoteTypePrev";
			break;
    case RemoteTypeLanguage:
      imageName = @"RemoteTypeLanguage";
      break;
    case RemoteTypeShow:
      imageName = @"RemoteTypeShow";
      break;
  default:
			self.userInteractionEnabled = NO;
			break;
	}
	[self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
