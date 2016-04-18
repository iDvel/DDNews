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

#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height

@interface DDPhotoDetailController () <UIScrollViewDelegate>
@property (nonatomic, strong) DDPhotoModel *photoModel;

// UI
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, assign) CGFloat totalScale;

// 图片浏览缩放：
@property (nonatomic, assign, getter=isBig) BOOL big;
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
}

/** 模型初始化后，开始搭建UI。 */
- (void)setPhotoModel:(DDPhotoModel *)photoModel
{
	_photoModel = photoModel;
	[self.view addSubview:self.imageScrollView];
	[self.view addSubview:self.backButton];
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


- (UIScrollView *)imageScrollView
{
	if (_imageScrollView == nil) {
		// 1.设置大ScrollView
		_imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScrW, ScrH)];
		_imageScrollView.contentSize = CGSizeMake(_photoModel.photos.count * ScrW, ScrH);
		_imageScrollView.showsHorizontalScrollIndicator = NO;
		_imageScrollView.pagingEnabled = YES;
		
		for (int i = 0; i < self.photoModel.photos.count; i++) {
			DDPhotoDetailModel *detailModel = self.photoModel.photos[i];
			DDPhotoScrollView *photoScrollView = [[DDPhotoScrollView alloc] initWithFrame:CGRectMake(ScrW * i, 0, ScrW, ScrH)
																				urlString:detailModel.imgurl];
			[_imageScrollView addSubview:photoScrollView];
		}
	}
	return _imageScrollView;
}

// 允许多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
	NSLog(@"tap : %@", recognizer.view);
}

- (void)pinch:(UIPinchGestureRecognizer *)recognizer
{
	/*
//	NSLog(@"%f", recognizer.scale);
//	recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
//	recognizer.scale = 1;
	
	CGFloat scale = recognizer.scale;
	
	//放大情况
	if(scale > 1.0){
		if(self.totalScale > 2.0) return;
	}
	
	//缩小情况
	if (scale < 1.0) {
		if (self.totalScale < 0.5) return;
	}
	
	recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale);
	self.totalScale *=scale;
	recognizer.scale = 1.0;
	
//	NSLog(@"%f", self.totalScale);
//	if (self.totalScale < 1) {
//		recognizer.view.width = [UIScreen mainScreen].bounds.size.width;
//	}*/
	// 捏合手势是  初始的中心点所在屏幕的位置不变
	UIScrollView *singleScrollView = (UIScrollView *)recognizer.view;
	UIImageView * imgview = singleScrollView.subviews[0];

}


#pragma mark -
- (void)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}
@end

