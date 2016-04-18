//
//  DDNetworkTool.m
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNetworkTool.h"

@implementation DDNetworkTool

+ (instancetype)ToolWithNewsBaseUrl
{
	static DDNetworkTool *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
		NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
		instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
		
		// 加入 text/html 解析
		instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
	});
	return instance;
}

+ (instancetype)sharedTool
{
	static DDNetworkTool *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURL *url = [NSURL URLWithString:@""];
		NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
		instance = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
		
		// 加入 text/html 解析
		instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
	});
	return instance;
}

@end
