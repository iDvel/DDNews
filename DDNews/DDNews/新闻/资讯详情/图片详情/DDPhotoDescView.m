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
		UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScrW, 0)];
		textView.text = desc;
		textView.backgroundColor = [UIColor clearColor];
		textView.textColor = [UIColor whiteColor];
		textView.font = [UIFont systemFontOfSize:16];
		// 这个37算的我莫名其妙，得不到正确的textView高度！！！！
		textView.frame = CGRectMake(0, 0, ScrW, textView.contentSize.height + 37);
		textView.userInteractionEnabled = NO;
		
		self = [[DDPhotoDescView alloc] initWithFrame:CGRectMake(0, ScrH - DescViewDefaultHeight, ScrW, 999)];
		self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
		[self addSubview:textView];
		// textView.height 和 textView.contentSize.height 我也是日了狗了。
		self.tag = textView.height > DescViewDefaultHeight ? textView.contentSize.height : DescViewDefaultHeight - 50;
		
		// 手势
		UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
		[self addGestureRecognizer:swipeUp];
		UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
		swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
		[self addGestureRecognizer:swipeDown];
		
		
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
		button.backgroundColor = [UIColor blueColor];
		[self addSubview:button];
		button.y = textView.y - 20;

	}
	return self;
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
