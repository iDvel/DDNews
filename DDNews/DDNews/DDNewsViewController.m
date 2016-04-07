//
//  DDNewsViewController.m
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsViewController.h"
#import "DDChannelModel.h"
#import "DDChannelLabel.h"

#import "UIView+Extension.h"

#define AppColor [UIColor colorWithRed:0.00392 green:0.576 blue:0.871 alpha:1]

static NSString * const reuseID  = @"DDChannelCell";

@interface DDNewsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
/** 频道数据模型 */
@property (nonatomic, strong) NSArray *channelList;
/** 当前要展示频道 */
@property (nonatomic, strong) NSMutableArray *list_now;
/** 已经删除的频道 */
@property (nonatomic, strong) NSMutableArray *list_del;

/** 频道列表 */
@property (nonatomic, strong) UIScrollView *smallScrollView;
/** 新闻视图 */
@property (nonatomic, strong) UICollectionView *bigCollectionView;
/** 下划线 */
@property (nonatomic, strong) UIView *underline;

@end

@implementation DDNewsViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"新闻";
		[[UINavigationBar appearance] setBarTintColor:AppColor];
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.smallScrollView];
	[self.view addSubview:self.bigCollectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _list_now.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
	cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
	return cell;
}

#pragma mark - UICollectionViewDelegate
/** 手指滑动BigCollectionView */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if ([scrollView isEqual:self.bigCollectionView]) {
		[self scrollViewDidEndScrollingAnimation:scrollView];
	}
}

/** 手指点击smallScrollView */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	// 获得索引
	NSUInteger index = scrollView.contentOffset.x / self.bigCollectionView.width;
	// 滚动标题栏到中间位置
	DDChannelLabel *titleLable = [self getLabelArrayFromSubviews][index];
	CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
	CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
	// 在最左和最右时，标签没必要滚动到中间位置。
	if (offsetx < 0)		 {offsetx = 0;}
	if (offsetx > offsetMax) {offsetx = offsetMax;}
	[_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
	
	// 先把之前着色的去色：
	for (DDChannelLabel *label in [self getLabelArrayFromSubviews]) {
		label.textColor = [UIColor blackColor];
	}
	// 下划线滚动并着色
	[UIView animateWithDuration:0.25 animations:^{
		_underline.width = [titleLable.text sizeWithAttributes:@{NSFontAttributeName:titleLable.font}].width+16;
		_underline.centerX = titleLable.centerX;
		titleLable.textColor = AppColor;
	}];
}



#pragma mark - getter
- (NSArray *)channelList
{
	if (_channelList == nil) {
		_channelList = [DDChannelModel channels];
	}
	return _channelList;
}

- (UIScrollView *)smallScrollView
{
	if (_smallScrollView == nil) {
		_smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
		_smallScrollView.backgroundColor = [UIColor whiteColor];
		_smallScrollView.showsHorizontalScrollIndicator = NO;
		
		// 设置频道
		_list_now = self.channelList.copy;
		[self setupChannelLabel];
		
		// 设置下划线
		[_smallScrollView addSubview:({
			DDChannelLabel *firstLabel = [self getLabelArrayFromSubviews][0];
			// 获得label的宽度
			CGSize size = [firstLabel.text sizeWithAttributes:@{NSFontAttributeName:firstLabel.font}];
			// smallScrollView高度44，取下面4个点的高度为下划线的高度。16为魔法数字，增加些宽度，看着合适来的。
			_underline = [[UIView alloc] initWithFrame:CGRectMake(firstLabel.x, 40, size.width+16, 4)];
			_underline.backgroundColor = AppColor;
			_underline;
		})];
	}
	return _smallScrollView;
}

- (UICollectionView *)bigCollectionView
{
	if (_bigCollectionView == nil) {
		// 高度 = 屏幕高度 - 导航栏高度64 - 频道视图高度44
		CGFloat h = [UIScreen mainScreen].bounds.size.height - 64 - self.smallScrollView.height ;
		CGRect frame = CGRectMake(0, self.smallScrollView.maxY, [UIScreen mainScreen].bounds.size.width, h);
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		_bigCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
		_bigCollectionView.backgroundColor = [UIColor whiteColor];
		_bigCollectionView.delegate = self;
		_bigCollectionView.dataSource = self;
//		[_bigCollectionView registerClass:[DDChannelCell class] forCellWithReuseIdentifier:reuseID];
		[_bigCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
		// 设置cell的大小和细节
		flowLayout.itemSize = _bigCollectionView.bounds.size;
		flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		flowLayout.minimumInteritemSpacing = 0;
		flowLayout.minimumLineSpacing = 0;
		_bigCollectionView.pagingEnabled = YES;
		_bigCollectionView.showsHorizontalScrollIndicator = NO;
	}
	return _bigCollectionView;
}

#pragma mark - 
/** 设置频道标题 */
- (void)setupChannelLabel
{
	CGFloat margin = 20.0;
	CGFloat x = 8;
	CGFloat h = _smallScrollView.bounds.size.height;
	int i = 0;
	for (DDChannelModel *channel in _list_now) {
		DDChannelLabel *label = [DDChannelLabel channelLabelWithTitle:channel.tname];
		label.frame = CGRectMake(x, 0, label.width + margin, h);
		[_smallScrollView addSubview:label];
		NSLog(@"~%@", NSStringFromCGRect(label.frame));
		x += label.bounds.size.width;
		label.tag = i++;
		[label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
	}
	_smallScrollView.contentSize = CGSizeMake(x + margin + 0, 0);
}

/** 频道Label点击事件 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
	DDChannelLabel *label = (DDChannelLabel *)recognizer.view;
	// 点击label后，让bigCollectionView滚到对应位置。
	CGFloat offsetX = label.tag * _bigCollectionView.frame.size.width;
	[_bigCollectionView setContentOffset:CGPointMake(offsetX, 0)];
	// 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
	[self scrollViewDidEndScrollingAnimation:self.bigCollectionView];
}

/** 获取smallScrollView中所有的DDChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
	NSMutableArray *arrayM = [NSMutableArray array];
	for (DDChannelLabel *label in _smallScrollView.subviews) {
		if ([label isKindOfClass:[DDChannelLabel class]]) {
			[arrayM addObject:label];
		}
	}
	return arrayM.copy;
}

@end
