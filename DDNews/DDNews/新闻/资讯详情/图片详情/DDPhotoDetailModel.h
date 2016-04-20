//
//  DDPhotoDetailModel.h
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPhotoDetailModel : NSObject

/** 单个图片urlString */
@property (nonatomic, copy) NSString *imgurl;
/** 单个图片的简介 */
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