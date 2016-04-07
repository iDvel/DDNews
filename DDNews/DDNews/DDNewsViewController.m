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

@interface DDNewsViewController ()
/** 频道数据模型 */
@property (nonatomic, strong) NSArray *channelList;
/** 当前要展示频道 */
@property (nonatomic, strong) NSMutableArray *list_now;
/** 已经删除的频道 */
@property (nonatomic, strong) NSMutableArray *list_del;
/** 频道列表 */
@property (nonatomic, strong) UIScrollView *smallScrollView;
@end

@implementation DDNewsViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"新闻";
		[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0392 green:0.969 blue:0.871 alpha:1]];
		self.automaticallyAdjustsScrollViewInsets = NO; // 坑爹啊，忘了这个，耽误我好久
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.smallScrollView];
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
		
		_list_now = self.channelList.copy;
		// 设置频道标题
		[self setupChannelLabel];

		//		[_smallScrollView addSubview:[self setupUnderline]];
	}
	return _smallScrollView;
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
		label.frame = CGRectMake(x, 0, label.bounds.size.width + margin, h);
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
	
}

@end
