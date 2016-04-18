//
//  DDPhotoDetailModel.h
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPhotoDetailModel : NSObject

@property (nonatomic, copy) NSString *imgurl;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, copy) NSString *photoid;

@property (nonatomic, copy) NSString *timgurl;

@property (nonatomic, copy) NSString *simgurl;

@property (nonatomic, copy) NSString *imgtitle;

@property (nonatomic, copy) NSString *newsurl;

@property (nonatomic, copy) NSString *photohtml;

@property (nonatomic, copy) NSString *squareimgurl;

@property (nonatomic, copy) NSString *cimgurl;




+ (instancetype)photoDetailModelWithDict:(NSDictionary *)dict;

@end