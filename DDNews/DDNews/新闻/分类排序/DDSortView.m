//
//  DDSortView.m
//  DDNews
//
//  Created by Dvel on 16/4/15.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDSortView.h"
#import "DDSortCell.h"

#import "LXReorderableCollectionViewFlowLayout.h"
#import "UIView+Extension.h"

static NSString * const reuseID1 = @"ShouYeCell";
static NSString * const reuseID2 = @"OthersCell";

@interface DDSortView () <LXReorderableCollectionViewDataSource, LXReorderableCollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *channelList;
@end

@implementation DDSortView

- (instancetype)initWithFrame:(CGRect)frame channelList:(NSMutableArray *)channelList
{
	_channelList = channelList;
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		// 上面高度44的描述栏(覆盖smallScrollView)
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 0, 0)];
		label.text = @"点击进入，长按拖动";
		label.font = [UIFont systemFontOfSize:15];
		[label sizeToFit];
		[self addSubview:label];
		
		// 中间的排序collectionView,
		LXReorderableCollectionViewFlowLayout *flowLayout = [LXReorderableCollectionViewFlowLayout new];
		UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44,
																							  frame.size.width,
																							  frame.size.height - 44 - 49)
															  collectionViewLayout:flowLayout];
		collectionView.backgroundColor = [UIColor whiteColor];
		collectionView.dataSource = self;
		[collectionView registerClass:[DDSortCell class] forCellWithReuseIdentifier:reuseID2];
//		[collectionView registerNib:[UINib nibWithNibName:@"DDChannelSortCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier:reuseID2];
		[self addSubview:collectionView];
		
		// 设置cell的大小和细节,每排4个
		CGFloat margin = 20.0;
		CGFloat width  = ([UIScreen mainScreen].bounds.size.width - margin * 5) / 4.f;
		CGFloat height = width * 3.f / 7.f; // 按图片比例来的
		flowLayout.sectionInset = UIEdgeInsetsMake(5, margin, 5, margin);
		flowLayout.itemSize = CGSizeMake(width, height);
		flowLayout.minimumInteritemSpacing = margin;
		flowLayout.minimumLineSpacing = 20;
		
		// 下面49高度的箭头（覆盖tabbar）
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame),
																	 frame.size.width, 49)];
		button.backgroundColor = [UIColor whiteColor];
		[button setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
		button.layer.shadowColor = [UIColor whiteColor].CGColor;
		button.layer.shadowRadius = 5;
		button.layer.shadowOffset = CGSizeMake(0, -10);
		button.layer.shadowOpacity = 1;
		[button addTarget:self action:@selector(arrowButtonClick) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
	}
	return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _channelList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	DDSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID2 forIndexPath:indexPath];
	[cell.button setTitle:[_channelList[indexPath.row] valueForKey:@"tname"] forState:UIControlStateNormal];
	return cell;
}

#pragma mark 点击事件
/** 箭头按钮点击事件 */
- (void)arrowButtonClick
{
	self.arrowBtnClickBlock();
}



- (void)dealloc
{
	NSLog(@"~");
}
@end
