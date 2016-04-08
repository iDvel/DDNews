//
//  DDChannelCell.m
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDChannelCell.h"
#import "DDNewsTVC.h"

#import "UIView+Extension.h"

@implementation DDChannelCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		NSLog(@"%s", __func__);
		
		
		
	}
	return self;
}

- (void)setUrlString:(NSString *)urlString
{
	_urlString = urlString;
	
	DDNewsTVC *newsTVC = [[DDNewsTVC alloc] init];
	newsTVC.view.frame = self.bounds;
	[self addSubview:newsTVC.view];
}

//- (void)setTname:(NSString *)tname
//{
//	_tname = tname;
//
//	[self addSubview:({
//		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//		label.text = self.tname;
//		NSLog(@"~~~r%@", self.tname);
//		[label sizeToFit];
//		label.centerX = self.centerX;
//		label.centerY = self.centerY;
//		label.textColor = [UIColor blackColor];
//		label;
//	})];
//
//	
//	[self addSubview:({
//		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
//		view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
//		view;
//	})];
//}


@end
