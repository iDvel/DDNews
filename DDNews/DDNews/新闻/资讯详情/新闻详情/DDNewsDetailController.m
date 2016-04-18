//
//  DDNewsDetailController.m
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsDetailController.h"

@interface DDNewsDetailController () <UIWebViewDelegate>

@end

@implementation DDNewsDetailController

- (instancetype)initWithUrlString:(NSString *)urlString
{
	self = [super init];
	if (self) {
		UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
		[self.view addSubview:webView];
		NSURL *url = [NSURL URLWithString:urlString];
		[webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10]];
		webView.delegate = self;
	}
	return self;
}

#pragma mark - UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//	NSLog(@"%s", __func__);
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//	NSLog(@"%s", __func__);
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//	NSLog(@"error = %@", error);
//}

@end
