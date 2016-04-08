//
//  DDNewsModel.m
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsModel.h"
#import "DDNetworkTool.h"
#import <objc/runtime.h>

@implementation DDNewsModel

+ (void)newsDataListWithUrlString:(NSString *)urlString complection:(void (^)(NSMutableArray *))complection
{
	[[DDNetworkTool ToolWithNewsBaseUrl] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
		//		NSLog(@"%@", responseObject); // 1个字典套1个数组，数组里有N个字典
		// responseObject.keyEnumerator.nextObject 可以得到 T1348647853363，即数组的key
		NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
		NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
		for (NSDictionary *dict in array) {
			[arrayM addObject:[self newsModelWithDict:dict]];
		}
		complection(arrayM);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"error = %@", error);
	}];
}

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
	id obj = [[self alloc] init];
	
	//	[obj setValuesForKeysWithDictionary:dict];
	for (NSString *key in [self properties]) {
		if (dict[key]) {
			[obj setValue:dict[key] forKey:key];
		}
	}
	
	return obj;
}

+ (NSArray *)properties
{
	unsigned int outCount = 0;
	objc_property_t *properties = class_copyPropertyList([self class], &outCount);
	
	NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:outCount];
	for (int i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		const char *name = property_getName(property);
		[arrayM addObject:[NSString stringWithUTF8String:name]];
	}
	free(properties);
	
	return arrayM;
}

@end
