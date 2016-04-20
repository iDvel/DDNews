//
//  DDPhotoDescView.m
//  DDNews
//
//  Created by Dvel on 16/4/20.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDPhotoDescView.h"

#import "UIView+Extension.h"

#define DescViewDefaultHeight 130

@implementation DDPhotoDescView

- (instancetype)initWithDesc:(NSString *)desc
{
	self = [super init];
	if (self) {
		// 描述文本
		UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScrW, 0)];
		textView.text = desc;
		textView.backgroundColor = [UIColor clearColor];
		textView.textColor = [UIColor whiteColor];
		textView.font = [UIFont systemFontOfSize:16];
		// 这个37算的我莫名其妙，得不到正确的textView高度！！！！
		textView.frame = CGRectMake(0, 0, ScrW, textView.contentSize.height + 37);
		textView.userInteractionEnabled = NO;
		
		// self
		self = [[DDPhotoDescView alloc] initWithFrame:CGRectMake(0, ScrH - DescViewDefaultHeight, ScrW, 999)];
		self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
		[self addSubview:textView];
		// textView.height 和 textView.contentSize.height 我也是日了狗了。
		self.tag = textView.height > DescViewDefaultHeight ? textView.contentSize.height : DescViewDefaultHeight - 50;
		
		// 标题
		UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScrW, 30)];
		titleView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
		titleView.y = textView.y - 30;
		[self addSubview:titleView];
		
		// 手势
		UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
		[self addGestureRecognizer:swipeUp];
		UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
		[self addGestureRecognizer:swipeDown];
		// 标题也加上
		[titleView addGestureRecognizer:swipeUp];
		[titleView addGestureRecognizer:swipeDown];
		
		
	}
	return self;
}

/** 为了使超出self范围titleView也能响应手势，重写hitTest方法 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	UIView *view = [super hitTest:point withEvent:event];
	if (view == nil) {
		for (UIView *subView in self.subviews) {
			CGPoint p = [subView convertPoint:point fromView:self];
			if (CGRectContainsPoint(subView.bounds, p)) {
				view = subView;
			}
		}
	}
	return view;
}

- (void)swipe:(UISwipeGestureRecognizer *)recognizer
{
	if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
		[UIView animateWithDuration:0.3 animations:^{
			self.y = ScrH - self.tag - 50;
		}];
	} else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
		[UIView animateWithDuration:0.3 animations:^{
			self.y = ScrH - DescViewDefaultHeight;
		}];
	} else {
		NSLog(@"wocao");
	}
}
@end
