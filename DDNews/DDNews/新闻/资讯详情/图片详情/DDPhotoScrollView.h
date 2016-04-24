//
//  DDPhotoScrollView.h
//  DDNews
//
//  Created by Dvel on 16/4/19.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPhotoScrollView : UIScrollView

@property (nonatomic, copy) void(^singleTapBlock)();

@property (nonatomic, strong) UIImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;

@end
