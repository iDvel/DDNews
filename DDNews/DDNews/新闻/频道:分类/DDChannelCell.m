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
//		NSLog(@"%s", __func__);
	}
	return self;
}

- (void)setUrlString:(NSString *)urlString
{
	_urlString = urlString;
	
	UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DDNewsTVC" bundle:nil];
	_newsTVC = [sb instantiateInitialViewController];
	_newsTVC.view.frame = self.bounds;
	_newsTVC.urlString = urlString;
	[self addSubview:_newsTVC.view];
}

@end
