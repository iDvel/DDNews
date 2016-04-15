//
//  DDSortView.h
//  DDNews
//
//  Created by Dvel on 16/4/15.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSortView : UIView
- (instancetype)initWithFrame:(CGRect)frame channelList:(NSMutableArray *)channelList;

/** 箭头按钮点击回调 */
@property (nonatomic, copy) void(^arrowBtnClickBlock)();
/** 排序完成回调 */
@property (nonatomic, copy) void(^sortCompletedBlock)(NSMutableArray *channelList);
/** cell按钮点击回调 */
@property (nonatomic, copy) void(^cellButtonClick)(UIButton *button);
@end
