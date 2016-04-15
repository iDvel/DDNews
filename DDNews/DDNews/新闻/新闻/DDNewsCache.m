//
//  DDNewsCache.m
//  DDNews
//
//  Created by Dvel on 16/4/16.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsCache.h"

@implementation DDNewsCache


+ (instancetype)sharedInstance
{
	static id _instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [NSMutableArray array];
	});
	return _instance;
}


@end
