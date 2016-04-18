//
//  DDNetworkTool.h
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface DDNetworkTool : AFHTTPSessionManager

+ (instancetype)ToolWithNewsBaseUrl;
+ (instancetype)sharedTool;
@end
