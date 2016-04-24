//
//  DDPhotoDetailController.h
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPhotoDetailController : UIViewController
- (instancetype)initWithPhotosetID:(NSString *)photosetID;
/** 跟贴数 */
@property (nonatomic, assign) int replyCount;

@end
