//
//  DDSortView.m
//  DDNews
//
//  Created by Dvel on 16/4/15.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDSortView.h"
#import "LXReorderableCollectionViewFlowLayout.h"
#import "UIView+Extension.h"

@interface DDSortView () <LXReorderableCollectionViewDataSource, LXReorderableCollectionViewDelegateFlowLayout>

@end

@implementation DDSortView

- (instancetype)initWithFrame:(CGRect)frame channelList:(NSMutableArray *)channelList
{
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
		[collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
	return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
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
