//
//  TGUserCenter.m
//  TianGong
//
//  Created by xbwu on 15/10/13.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "TGUserCenter.h"
#import <netdb.h>
#import <sys/socket.h>
#import <arpa/inet.h>

#define TGSettingIP @"TGSettingIP"
#define TGSettingIP1 @"TGSettingIP1"
#define TGSettingDDNS @"TGSettingDDNS"
#define TGUserName @"TGUserName"
#define TGPassword @"TGPassword"
#define TGSettingPort @"TGSettingPort"


@implementation TGUserCenter

static TGUserCenter *userCenter = nil;

+ (TGUserCenter*)defaultCenter {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		userCenter = [[TGUserCenter alloc] init];
	});
	return userCenter;
}

- (id)init {
	self = [super init];
	if (self) {
		_ip = [[NSUserDefaults standardUserDefaults] objectForKey:TGSettingIP];
		_ip1 = [[NSUserDefaults standardUserDefaults] objectForKey:TGSettingIP1];
		_ddns = [[NSUserDefaults standardUserDefaults] objectForKey:TGSettingDDNS];
		_userName = [[NSUserDefaults standardUserDefaults] objectForKey:TGUserName];
		_password = [[NSUserDefaults standardUserDefaults] objectForKey:TGPassword];
    _port = [[NSUserDefaults standardUserDefaults] objectForKey:TGSettingPort];
    if (_port == nil) {
      _port = @"20000";
    }
	}
	return self;
}

- (void)setIp:(NSString *)ip {
	_ip = ip;
	if (_ip.length > 0) {
		[[NSUserDefaults standardUserDefaults] setObject:_ip forKey:TGSettingIP];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (void)setDdns:(NSString *)ddns {
	_ddns = ddns;
	if (_ddns.length > 0) {
		self.ip1 = [self getIPWithHostName:_ddns];
		
		[[NSUserDefaults standardUserDefaults] setObject:_ddns forKey:TGSettingDDNS];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (void)setUserName:(NSString *)userName {
	_userName = userName;
	if (_userName.length > 0) {
		[[NSUserDefaults standardUserDefaults] setObject:_userName forKey:TGUserName];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (void)setPassword:(NSString *)password {
	_password = password;
	if (_password.length > 0) {
		[[NSUserDefaults standardUserDefaults] setObject:_password forKey:TGPassword];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (void)setIp1:(NSString *)ip1 {
	_ip1 = ip1;
	if (_ip1.length > 0) {
		[[NSUserDefaults standardUserDefaults] setObject:_ip1 forKey:TGSettingIP1];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (void)setPort:(NSString *)port {
  _port = port;
  if (_port.length > 0) {
    [[NSUserDefaults standardUserDefaults] setObject:_port forKey:TGSettingPort];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

- (NSString *)getIPWithHostName:(const NSString *)hostName
{
	const char *hostN = [hostName UTF8String];
	struct hostent *phot;
	@try {
		phot = gethostbyname(hostN);
	}
	@catch (NSException *exception) {
		return nil;
	}
	if (phot == NULL) {
		return nil;
	}
	struct in_addr ip_addr;
	memcpy(&ip_addr, phot->h_addr_list[0], 4);
	char ip[20] = {0};
	inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
	
	NSString *strIPAddress = [NSString stringWithUTF8String:ip];
	return strIPAddress;
}

@end
