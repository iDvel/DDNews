//
//  DDPhotoScrollView.m
//  DDNews
//
//  Created by Dvel on 16/4/19.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDPhotoScrollView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@interface DDPhotoScrollView () <UIScrollViewDelegate>
@end

@implementation DDPhotoScrollView

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString
{
	self = [super initWithFrame:frame];
	if (self) {
		// 设置图片
		_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScrW, ScrH - 50)];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.userInteractionEnabled = YES;
		[_imageView sd_setImageWithURL:[NSURL URLWithString:urlString]
				 placeholderImage:nil
						  options:SDWebImageProgressiveDownload];
		[self addSubview:_imageView];
		
		// 设置scrollView和缩放
		self.delegate = self;
		self.showsVerticalScrollIndicator = NO;
		self.showsHorizontalScrollIndicator = NO;
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
//	NSLog(@"%@", NSStringFromCGAffineTransform(scrollView.subviews[0].transform));
}


/** 放大后，切换到下一张的时候，将原来那一张变回原来的大小 
 *  WARNING：并不会百分百调用这个方法。。。
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//	UIImageView *imageView = scrollView.subviews[0];
//	[UIView animateWithDuration:0.5 animations:^{
//		imageView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
//		imageView.frame = CGRectMake(0, 0, ScrW, ScrH);
//		scrollView.contentSize = imageView.frame.size;
//	}];
	
	// 直接模拟doubleTap即可
	UITapGestureRecognizer *recognizer = [UITapGestureRecognizer new];
	[recognizer setValue:scrollView forKey:@"view"];
	[self doubleTapOnScrollView:recognizer];
}


#pragma mark - 手势
- (void)singleTapOnScrollView
{
	if (self.singleTapBlock) {
		self.singleTapBlock();
	}
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
