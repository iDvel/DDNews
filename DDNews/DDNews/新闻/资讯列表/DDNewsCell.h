//
//  DDNewsCell.h
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDNewsModel;

@interface DDNewsCell : UITableViewCell

@property (nonatomic, strong) DDNewsModel *newsModel;
/** 轮播点击事件 */
@property (nonatomic, copy) void(^cycleImageClickBlock)(NSInteger idx);


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


+ (NSString *)cellReuseID:(DDNewsModel *)newsModel;
+ (CGFloat)cellForHeight:(DDNewsModel *)newsModel;

@end
