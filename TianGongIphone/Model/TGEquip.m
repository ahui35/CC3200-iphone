//
//  TGEquip.m
//  TianGong
//
//  Created by xbwu on 15/10/6.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "TGEquip.h"

@implementation TGEquip

- (NSString *)description {
  if (self.ddns) {
    return [NSString stringWithFormat:@"roomid:%d equipaddr:%d equipName:%@ ddns:%@ account:%@ password:%@",
            self.roomid,
            self.equipaddr,
            self.equipName,
            self.ddns,
            self.account,
            self.password];
  }
  return [NSString stringWithFormat:@"roomid:%d equipaddr:%d equipName:%@",
            self.roomid,
            self.equipaddr,
            self.equipName];
}

@end
