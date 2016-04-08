//
//  DDChannelModel.h
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDChannelModel : NSObject

@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy, readonly) NSString *urlString;

+ (instancetype)channelWithDict:(NSDictionary *)dict;
+ (NSArray *)channels;

@end
