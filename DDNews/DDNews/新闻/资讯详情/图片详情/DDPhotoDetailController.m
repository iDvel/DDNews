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
#import "DDPhotoDescView.h"

#import "JZNavigationExtension.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "JT3DScrollView.h"

@interface DDPhotoDetailController () <UIScrollViewDelegate>
@property (nonatomic, strong) DDPhotoModel *photoModel;
@property (nonatomic, assign) NSInteger currentPage;
// UI
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) JT3DScrollView *imageScrollView;
@property (nonatomic, strong) DDPhotoDescView *photoDescView;
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
//	[self.view insertSubview:self.descView aboveSubview:self.imageScrollView];
//	_photoDescView = [DDPhotoDescView new];
//	[self.view insertSubview:_photoDescView aboveSubview:self.imageScrollView];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self setValue:@(_imageScrollView.currentPage) forKey:@"currentPage"];
}


#pragma mark - KVO
static int temp = -1;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//	NSLog(@"object = %@", object);  // DDPhotoDetailController
//	NSLog(@"change = %@", change[@"old"]);
	
	// 获取新旧索引
	int oldIndex = [change[@"old"] intValue];
	int newIndex = [change[@"new"] intValue];
	
	// 防止玩命赋值，只有发生变化了才进行下一步操作。
	if (temp == newIndex) {return;}
	temp = newIndex;
	
	// 改UI：
	
	DDPhotoDetailModel *detailModel = _photoModel.photos[newIndex];
	
	// 先remove
	[_photoDescView removeFromSuperview];
	// 再加入
	_photoDescView = [[DDPhotoDescView alloc] initWithTitle:_photoModel.setname
													   desc:detailModel.note
													  index:newIndex
												 totalCount:_photoModel.photos.count];
	[self.view insertSubview:_photoDescView belowSubview:self.bottomView];
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

//- (UIView *)descView
//{
//	if (_descView == nil) {
//		UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScrW, 0)];
//		textView.text = @"按时打算的撒打发的山东省打发斯东省法师打发斯东省法师打发斯东省法师打发斯.完";
//		textView.backgroundColor = [UIColor clearColor];
//		textView.textColor = [UIColor whiteColor];
//		textView.font = [UIFont systemFontOfSize:16];
//		textView.frame = CGRectMake(0, 0, ScrW, textView.contentSize.height);
//		textView.userInteractionEnabled = NO;
//		
//		_descView = [[UIView alloc] initWithFrame:CGRectMake(0, ScrH - 150, ScrW, 999)];
//		_descView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
//		[_descView addSubview:textView];
//		_descView.tag = textView.contentSize.height;
//		
//		// 手势
//		UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
//		swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//		[_descView addGestureRecognizer:swipeUp];
//		UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
//		swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//		[_descView addGestureRecognizer:swipeDown];
//		
//		
//		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//		button.backgroundColor = [UIColor blueColor];
//		[_descView addSubview:button];
//		button.y = textView.y - 20;
//
//	}
//	return _descView;
//}

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

//- (void)swipe:(UISwipeGestureRecognizer *)recognizer
//{
////	NSLog(@"recognizer.direction == %zd", recognizer.direction); // 上4下8
////	NSLog(@"%@", recognizer.view); // _descView
//	if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
//		NSLog(@"up");
//		[UIView animateWithDuration:0.3 animations:^{
//			recognizer.view.y = ScrH - recognizer.view.tag - 50;
//		}];
//	} else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
//		NSLog(@"down");
//		[UIView animateWithDuration:0.3 animations:^{
//			recognizer.view.y = ScrH - 150;
//		}];
//	} else {
//		NSLog(@"wocao");
//	}
//}


- (void)dealloc
{
	NSLog(@"~");
	temp= -1;
	[self removeObserver:self forKeyPath:@"currentPage"];
}

@end

