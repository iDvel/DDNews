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

@property (nonatomic, copy) void(^arrowBtnClickBlock)();
@end
