//
//  DDPhotoDetailModel.m
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDPhotoDetailModel.h"
#import <objc/runtime.h>

@implementation DDPhotoDetailModel



+ (instancetype)photoDetailModelWithDict:(NSDictionary *)dict
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
