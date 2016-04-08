//
//  DDNewsCell.m
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsCell.h"
#import "DDNewsModel.h"

#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"


@interface DDNewsCell () <SDCycleScrollViewDelegate>
/** 轮播图 */
@property (weak, nonatomic) IBOutlet UIView *cycleImageView;

@end

@implementation DDNewsCell

- (void)setNewsModel:(DDNewsModel *)newsModel
{
	_newsModel = newsModel;
	
	[self setupCycleImageCell:newsModel];
}

#pragma mark - 图片轮播
/** 设置轮播图 */
- (void)setupCycleImageCell:(DDNewsModel *)newsModel
{
	// 网络加载 --- 创建带标题的图片轮播器
	SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.cycleImageView.bounds delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder_cycleImage"]];
	cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
	cycleScrollView.currentPageDotColor = [UIColor whiteColor];
	
	NSMutableArray *titleArrayM = [NSMutableArray array];
	for (int i = 0; i < newsModel.ads.count; i++) {
		[titleArrayM addObject:newsModel.ads[i][@"title"]];
	}
	cycleScrollView.titlesGroup = titleArrayM;
	
	NSMutableArray *urlArrayM = [NSMutableArray array];
	for (int i = 0; i < newsModel.ads.count; i++) {
		[urlArrayM addObject:newsModel.ads[i][@"imgsrc"]];
	}
	cycleScrollView.imageURLStringsGroup = urlArrayM;
	
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
		return @"NewsCycleImageCell";
	} else if (newsModel.imgextra.count == 2) { //	if (newsModel.photosetID) {
		return @"NewsImgextrasCell";
	} else if (newsModel.imgType) {
		return @"NewsBigImageCell";
	} else {
		return @"NewsCell";
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
