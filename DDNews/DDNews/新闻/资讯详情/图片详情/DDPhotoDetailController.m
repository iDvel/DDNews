//
//  DDPhotoDetailController.m
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDPhotoDetailController.h"
#import "DDPhotoModel.h"
#import "DDPhotoDetailModel.h"
#import "DDPhotoScrollView.h"

#import "JZNavigationExtension.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "JT3DScrollView.h"

#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height

@interface DDPhotoDetailController () <UIScrollViewDelegate>
@property (nonatomic, strong) DDPhotoModel *photoModel;
@property (nonatomic, assign) NSInteger currentPage;
// UI
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) JT3DScrollView *imageScrollView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation DDPhotoDetailController

- (instancetype)initWithPhotosetID:(NSString *)photosetID
{
	self = [super init];
	if (self) {
		[DDPhotoModel photoModelWithPhotosetID:(NSString *)photosetID complection:^(DDPhotoModel *photoModel) {
			self.photoModel = photoModel;
		}];
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
	return self;
}

- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor colorWithRed:0.174 green:0.174 blue:0.164 alpha:1.000];
	self.navigationController.fullScreenInteractivePopGestureRecognizer = YES;
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
	
	[self.view addSubview:self.backButton];
	[self.view addSubview:self.bottomView];
}

/** 模型初始化后，开始搭建需要网络加载后才显示的UI。 */
- (void)setPhotoModel:(DDPhotoModel *)photoModel
{
	_photoModel = photoModel;
	[self.view insertSubview:self.imageScrollView belowSubview:self.backButton];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self setValue:@(_imageScrollView.currentPage) forKey:@"currentPage"];
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//	NSLog(@"object = %@", object);  // DDPhotoDetailController
//	NSLog(@"change = %@", change[@"old"]);
	
	// 获取新旧索引
	int oldIndex = [change[@"old"] intValue];
	int newIndex = [change[@"new"] intValue];
	
	// 防止玩命赋值，只有发生变化了才进行下一步操作。
	static int temp = -1;
	if (temp == newIndex) {return;}
	temp = newIndex;
	
	// 改UI：
	
//	DDPhotoDetailModel *detailModel = self.photoModel.photos[newIndex];
//	NSLog(@"```%@", detailModel.note);
}


#pragma mark - getter
- (UIButton *)backButton
{
	if (_backButton == nil) {
		_backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 25, 40, 40)];
		[_backButton setImage:[UIImage imageNamed:@"imageset_back_live"] forState:UIControlStateNormal];
		[_backButton setImage:[UIImage imageNamed:@"imageset_back"] forState:UIControlStateSelected];
		[_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _backButton;
}


- (JT3DScrollView *)imageScrollView
{
	if (_imageScrollView == nil) {
		// 设置大ScrollView
		_imageScrollView = [[JT3DScrollView alloc] initWithFrame:CGRectMake(0, 0, ScrW, ScrH)];
		_imageScrollView.contentSize = CGSizeMake(_photoModel.photos.count * ScrW, ScrH);
		_imageScrollView.showsHorizontalScrollIndicator = NO;
		_imageScrollView.effect = arc4random_uniform(3) + 1; // 切换的动画效果,随机枚举中的1，2，3三种效果。
		_imageScrollView.clipsToBounds = YES;
		_imageScrollView.delegate = self;
		[self addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];

		// 设置小ScrollView（装载imageView的scrollView）
		for (int i = 0; i < self.photoModel.photos.count; i++) {
			DDPhotoDetailModel *detailModel = self.photoModel.photos[i];
			DDPhotoScrollView *photoScrollView = [[DDPhotoScrollView alloc] initWithFrame:CGRectMake(ScrW * i, 0, ScrW, ScrH)
																				urlString:detailModel.imgurl];
			[_imageScrollView addSubview:photoScrollView];
		}
	}
	return _imageScrollView;
}

- (UIView *)bottomView
{
	if (_bottomView == nil) {
		_bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScrH - 40, ScrW, 40)];
		_bottomView.backgroundColor = [UIColor lightGrayColor];
	}
	return _bottomView;
}

#pragma mark -
- (void)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
	NSLog(@"~");
	[self removeObserver:self forKeyPath:@"currentPage"];
}

@end

