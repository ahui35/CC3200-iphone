//
//  UpdateView.m
//  TianGong
//
//  Created by sgao on 15/10/8.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "UpdateView.h"
#import "CCLoadingView.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "TGUserCenter.h"

@interface UpdateView () {
  NSMutableData *data;
}

@end

@implementation UpdateView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        self.frame.size.width,
                                                                        self.frame.size.height)];
    bgView.image = [UIImage imageNamed:@"update_bg"];
    [self addSubview:bgView];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 50, 180, 25)];
		[self addSubview:label];
		label.textAlignment = 1;
		label.textColor = [UIColor darkGrayColor];
		label.font = [UIFont boldSystemFontOfSize:18];
		label.text = @"配置更新服务器";
		
    textField = [[UITextField alloc] initWithFrame:CGRectMake(55, 103, 180, 25)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:15];
    [self addSubview:textField];
    textField.text = [TGUserCenter defaultCenter].ip;
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.backgroundColor = [UIColor clearColor];
    updateBtn.frame = CGRectMake((290 - 15 - 190)/2, 160, 95, 35);
    [updateBtn setBackgroundImage:[UIImage imageNamed:@"update"] forState:UIControlStateNormal];
    [self addSubview:updateBtn];
    [updateBtn addTarget:self action:@selector(downloadSqliteData) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.frame = CGRectMake(CGRectGetMaxX(updateBtn.frame) + 15, 160, 95, 35);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)clickCancelBtn
{
  [self hide:YES afterDelay:0.1];
}

- (IBAction)downloadSqliteData
{
  NSString *userName = @"tgzn";
  NSString *sqliteDataAddress = [NSString stringWithFormat:@"http://%@:8080/tiangong/%@.db", textField.text, userName];
  NSURLRequest *sqliteDataRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:sqliteDataAddress] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
  
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:sqliteDataRequest
                                                                delegate:self
                                                        startImmediately:YES];
  
  if (data == nil) {
    data = [[NSMutableData alloc] init];
  }
	
	[[CCLoadingView sharedLoading] showInView:self.window animated:YES];
}

#pragma mark -- Connection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  //do something
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d
{
  [data appendData:d];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[data writeToFile:[TGDBManager dbPath] atomically:YES];
	
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"更新成功"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
  
  [alertView show];
	
	[self performSelector:@selector(notification) withObject:nil afterDelay:1];
}

- (void)notification {
	[[CCLoadingView sharedLoading] hide:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:DBRefreshNotification object:nil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	
	[[CCLoadingView sharedLoading] hide:YES];
  //do something
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"更新出错了，请检查输入的IP地址是否正确"
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
  
  [alertView show];
}

- (void)showMaskWithView:(UIView *)view {
	[self creatMaskWithView:view];
}

@end
