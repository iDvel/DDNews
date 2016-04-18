//
//  DDPhotoModel.h
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPhotoModel : NSObject

/** DDPhotoDetailModel模型 */
@property (nonatomic, strong) NSArray *photos;
/** 标题 */
@property (nonatomic, copy) NSString *setname;
/** 描述 */
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *scover;

@property (nonatomic, copy) NSString *reporter;

@property (nonatomic, copy) NSString *creator;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *clientadurl;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *postid;

@property (nonatomic, strong) NSArray *relatedids;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *settag;

@property (nonatomic, copy) NSString *imgsum;

@property (nonatomic, copy) NSString *commenturl;

@property (nonatomic, copy) NSString *tcover;

@property (nonatomic, copy) NSString *createdate;

@property (nonatomic, copy) NSString *series;

@property (nonatomic, copy) NSString *datatime;

@property (nonatomic, copy) NSString *autoid;

@property (nonatomic, copy) NSString *boardid;

+ (instancetype)photoModelWithDict:(NSDictionary *)dict;

+ (void)photoModelWithPhotosetID:(NSString *)photosetID complection:(void (^)(DDPhotoModel *photoModel))complection;

@end




