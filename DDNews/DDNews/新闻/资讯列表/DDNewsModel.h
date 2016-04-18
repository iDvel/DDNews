//
//  DDNewsModel.h
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDNewsModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 摘要 */
@property (nonatomic, copy) NSString *digest;
/** 图片链接 */
@property (nonatomic, copy) NSString *imgsrc;
/** 跟贴数 */
@property (nonatomic, assign) int replyCount;
/** 多张配图 */
@property (nonatomic, strong) NSArray *imgextra;
/** 大图标记 */
@property (nonatomic, assign) BOOL imgType;
/**
 *  图片轮播的图，栗子：
 *	url = 6Q8M0001|113133;
 *	title = "动"态两会：明星委员被记者围堵采访;
 *	subtitle = ;
 *	tag = photoset;
 *	imgsrc = http://img4.cache.netease.com/3g/2016/3/14/2016031415204580434.jpg;
 */
@property (nonatomic, copy) NSArray *ads;
/** 进入后是图片详情 */
@property (nonatomic, copy) NSString *photosetID;
/** 进入后是新闻web详情 */
@property (nonatomic, copy) NSString *url;
/** 新闻ID */
@property (nonatomic,copy) NSString *docid;
@property (nonatomic,copy) NSString *boardid;



+ (void)newsDataListWithUrlString:(NSString *)urlString complection:(void (^)(NSMutableArray *array))complection;

@end
