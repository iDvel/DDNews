//
//  DDPhotoScrollView.m
//  DDNews
//
//  Created by Dvel on 16/4/19.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDPhotoScrollView.h"

#import "UIImageView+WebCache.h"

#define ScrW [UIScreen mainScreen].bounds.size.width
#define ScrH [UIScreen mainScreen].bounds.size.height

@interface DDPhotoScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation DDPhotoScrollView

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString
{
	self = [super initWithFrame:frame];
	if (self) {
		// 设置图片
		_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScrW, ScrH)];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.userInteractionEnabled = YES;
		[_imageView sd_setImageWithURL:[NSURL URLWithString:urlString]
				 placeholderImage:nil
						  options:SDWebImageProgressiveDownload];
		[self addSubview:_imageView];
		
		// 设置缩放
		self.delegate = self;
		self.maximumZoomScale = 2.0;
		self.minimumZoomScale = 1;
		
		// 单击手势
		UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapOnScrollView)];
		[_imageView addGestureRecognizer:singleTap];
		// 双击手势
		UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapOnScrollView:)];
		[_imageView addGestureRecognizer:doubleTap];
		[doubleTap setNumberOfTapsRequired:2];
		[singleTap requireGestureRecognizerToFail:doubleTap];

	}
	return self;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
	(scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
	CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
	(scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
	CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
									   scrollView.contentSize.height * 0.5 + offsetY);
	_imageView.center = actualCenter;
}


#pragma mark - 手势
- (void)singleTapOnScrollView
{
	NSLog(@"tap~");
}

- (void)doubleTapOnScrollView:(UITapGestureRecognizer *)recognizer
{
	CGPoint touchPoint = [recognizer locationInView:self];
	if (self.zoomScale <= 1.0) {
		CGFloat scaleX = touchPoint.x + self.contentOffset.x; // 需要放大的图片的X点
		CGFloat sacleY = touchPoint.y + self.contentOffset.y; // 需要放大的图片的Y点
		[self zoomToRect:CGRectMake(scaleX, sacleY, 10, 10) animated:YES];
	} else {
		[self setZoomScale:1.0 animated:YES]; //还原
	}
}

@end
