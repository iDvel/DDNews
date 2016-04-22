//
//  DDNewsCell.m
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsCell.h"
#import "DDNewsModel.h"
#import "DDNewsCache.h"

#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"


@interface DDNewsCell () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *cycleImageView;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
/** 左图右字的单个图片，三图中的第一个图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
/** 三图：其余两张图片 */
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextras;
/** 大图：区分开，为了给大图设置不同的placeholder */
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;

@end

@implementation DDNewsCell

#pragma mark - 设置cell
- (void)setNewsModel:(DDNewsModel *)newsModel
{
	_newsModel = newsModel;
	
	// 图片轮播
	[self setupCycleImageCell:newsModel];
	// 标题
	self.titleLabel.text = newsModel.title;
	if ([[DDNewsCache sharedInstance] containsObject:self.titleLabel.text]) {
		self.titleLabel.textColor = [UIColor lightGrayColor];
	} else {
		self.titleLabel.textColor = [UIColor blackColor];
	}
	// 标题
	self.digestLabel.text = newsModel.digest;
	// 跟帖数
	CGFloat count = newsModel.replyCount;
	if (count > 10000) {self.replyLabel.text = [NSString stringWithFormat:@"%.1f万跟帖", count/10000.f];}
	else			   {self.replyLabel.text = [NSString stringWithFormat:@"%.0f跟帖", count];}
	
	// 单图、左图右字的第一张
	[self.iconImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc]
					  placeholderImage:[UIImage imageNamed:@"placeholder_small"]
							   options:SDWebImageDelayPlaceholder
							   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
								   if (cacheType == 1 || cacheType == 2) {return;} // 0新下载，1磁盘缓存，2内存缓存
								   self.iconImage.alpha = 0;
								   [UIView animateWithDuration:0.5 animations:^{
									   self.iconImage.alpha = 1;
								   }];
							   }
	 ];
	
	// 左图右字的其余2张
	if (newsModel.imgextra.count == 2) {
		for (int i = 0; i < 2; i++) {
			UIImageView *imageView = self.imgextras[i];
			[imageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgextra[i][@"imgsrc"]]
						 placeholderImage:[UIImage imageNamed:@"placeholder_small"]
								  options:SDWebImageDelayPlaceholder
								completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
									if (cacheType == 1 || cacheType == 2) {return;} // 0新下载，1磁盘缓存，2内存缓存
									imageView.alpha = 0;
									[UIView animateWithDuration:0.5 animations:^{
										imageView.alpha = 1;
									}];
								}];
		}
	}
	
	// 大图的单张：
	[self.bigImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc]
					 placeholderImage:[UIImage imageNamed:@"placeholder_big"]
							  options:SDWebImageDelayPlaceholder
							completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
								if (cacheType == 1 || cacheType == 2) {return;} // 0新下载，1磁盘缓存，2内存缓存
								self.bigImage.alpha = 0;
								[UIView animateWithDuration:0.5 animations:^{
									self.bigImage.alpha = 1;
								}];
							}
	 ];
}

#pragma mark - 图片轮播
/** 设置轮播图 */
- (void)setupCycleImageCell:(DDNewsModel *)newsModel
{
	// 网络加载 --- 创建带标题的图片轮播器
	SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.cycleImageView.bounds delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder_big"]];
	cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
	cycleScrollView.currentPageDotColor = [UIColor whiteColor];
	
	cycleScrollView.titlesGroup = ({
		NSMutableArray *titleArrayM = [NSMutableArray array];
		for (int i = 0; i < newsModel.ads.count; i++) {
			[titleArrayM addObject:newsModel.ads[i][@"title"]];
		}
		titleArrayM;
	});
	
	cycleScrollView.imageURLStringsGroup = ({
		NSMutableArray *urlArrayM = [NSMutableArray array];
		for (int i = 0; i < newsModel.ads.count; i++) {
			[urlArrayM addObject:newsModel.ads[i][@"imgsrc"]];
		}
		urlArrayM;
	});
	
	[self.cycleImageView addSubview:cycleScrollView];
	cycleScrollView.delegate = self;
}

/** SDCycleScrollView轮播点击事件代理 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
	NSAssert(self.cycleImageClickBlock, @"必须传入self.cycleImageClickBlock");
	self.cycleImageClickBlock(index);
}


#pragma mark - cell相关
+ (NSString *)cellReuseID:(DDNewsModel *)newsModel
{
	// 接口中，ads 和 imgextra 可能共同出现，所以有ads的就直接弄成轮播。
	if (newsModel.ads) {
		return @"NewsCycleImageCell"; // 轮播
	} else if (newsModel.imgextra.count == 2) { //	if (newsModel.photosetID) {
		return @"News3imageCell"; // 三图
	} else if (newsModel.imgType) {
		return @"NewsBigImageCell"; // 大图
	} else {
		return @"News_L_img_R_text_Cell"; // 左图右字
	}
}

+ (CGFloat)cellForHeight:(DDNewsModel *)newsModel
{
	if (newsModel.ads) {
		return 200;
	} else if (newsModel.imgextra.count == 2) { //	if (newsModel.photosetID) {
		return 140;
	} else if (newsModel.imgType) {
		return 180;
	} else {
		return 80;
	}
}


@end
