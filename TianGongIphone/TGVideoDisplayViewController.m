//
//  TGVideoDisplayViewController.m
//  TianGong
//
//  Created by xbwu on 15/10/15.
//  Copyright (c) 2015年 xbwu. All rights reserved.
//

#import "TGVideoDisplayViewController.h"

@interface TGVideoDisplayViewController () {
  UIWebView *webview;
}

@end

@implementation TGVideoDisplayViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self creatNavBar];
  [self showBackBtn];
  
  webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,
																												44,
																												Main_Screen_Width,
																												Main_Screen_Height - 64)];
  [self.view addSubview:webview];
	webview.delegate = self;
	
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.videoadd]];
  NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
	NSString *authStr = [NSString stringWithFormat:@"%@:%@", [self account], [self password]];
	NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
	NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]];
	[requestObj setValue:authValue forHTTPHeaderField:@"Authorization"];
	
  [webview loadRequest:requestObj];
    // Do any additional setup after loading the view.
}

- (void)back {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSLog(@"%@", error);
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
