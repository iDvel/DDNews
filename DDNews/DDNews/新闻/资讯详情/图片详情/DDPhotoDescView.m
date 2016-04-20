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

- (instancetype)initWithTitle:(NSString *)title desc:(NSString *)desc index:(NSInteger)index totalCount:(NSInteger)totalCount
{
	self = [super init];
	if (self) {
		// 描述文本
		UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScrW, 0)];
		textView.text = desc;
		textView.backgroundColor = [UIColor clearColor];
		textView.textColor = [UIColor colorWithWhite:0.896 alpha:1.000];
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
		
		// 标题View
		UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScrW, 30)];
		titleView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
		titleView.y = textView.y - 30;
		[self addSubview:titleView];
		
		// 标题View里的index
		UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		NSMutableAttributedString *aStrM = [[NSMutableAttributedString alloc]
											initWithString:[NSString stringWithFormat:@"%zd", index + 1]
											attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
		[aStrM appendAttributedString:[[NSAttributedString alloc] initWithString:@"/"]];
		[aStrM appendAttributedString:[[NSAttributedString alloc]
									   initWithString:[NSString stringWithFormat:@"%zd", totalCount]
									   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}]];
		[aStrM addAttribute:NSKernAttributeName value:@2 range:NSMakeRange(0, aStrM.length)];
		indexLabel.attributedText = aStrM;
		indexLabel.textAlignment = NSTextAlignmentRight;
		indexLabel.textColor = [UIColor whiteColor];
		[indexLabel sizeToFit];
		indexLabel.x = ScrW - indexLabel.width - 5;
		[titleView addSubview:indexLabel];
		
		// 标题View里的标题
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, indexLabel.left, 30)];
		titleLabel.text = title;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:20];
		[titleLabel sizeToFit];
		[titleView addSubview:titleLabel];
		
		// 手势 ***一个view可以有多个手势，一个手势只能对应一个view
		UISwipeGestureRecognizer *swipeUp	= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		swipeUp.direction	= UISwipeGestureRecognizerDirectionUp;
		swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
		[self addGestureRecognizer:swipeUp];
		[self addGestureRecognizer:swipeDown];
		
		UISwipeGestureRecognizer *swipeUp2   = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		UISwipeGestureRecognizer *swipeDown2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		swipeUp2.direction	 = UISwipeGestureRecognizerDirectionUp;
		swipeDown2.direction = UISwipeGestureRecognizerDirectionDown;
		[titleView addGestureRecognizer:swipeUp2];
		[titleView addGestureRecognizer:swipeDown2];
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
