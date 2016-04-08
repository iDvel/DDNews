//
//  DDChannelLabel.h
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDChannelLabel : UILabel

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat textWidth;

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@end
