//
//  DDChannelCell.h
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDNewsTVC;

@interface DDChannelCell : UICollectionViewCell

@property (nonatomic, strong) DDNewsTVC *newsTVC;
@property (nonatomic, copy  ) NSString  *urlString;

@end
