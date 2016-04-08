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

@property (weak, nonatomic) IBOutlet UIView *cycleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextras;

@end

@implementation DDNewsCell

#pragma mark - 设置cell
- (void)setNewsModel:(DDNewsModel *)newsModel
{
	_newsModel = newsModel;
	
	[self setupCycleImageCell:newsModel];
	
	[self.iconImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholder_cycleImage"]];
	self.titleLabel.text = newsModel.title;
	self.digestLabel.text = newsModel.digest;
	//	self.replyLabel.text = [NSString stringWithFormat:@"%zd", newsModel.replyCount];
	CGFloat count = newsModel.replyCount;
	if (count > 10000) {
		self.replyLabel.text = [NSString stringWithFormat:@"%.1f万跟帖", count/10000];
	} else {
		self.replyLabel.text = [NSString stringWithFormat:@"%.0f跟帖", count];
	}
	
	if (newsModel.imgextra.count == 2) {
		for (int i = 0; i < 2; i++) {
			UIImageView *imageView = self.imgextras[i];
			[imageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgextra[i][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"placeholder_cycleImage"]];
		}
	}

}

#pragma mark - 图片轮播
/** 设置轮播图 */
- (void)setupCycleImageCell:(DDNewsModel *)newsModel
{
	// 网络加载 --- 创建带标题的图片轮播器
	SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.cycleImageView.bounds delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder_cycleImage"]];
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
