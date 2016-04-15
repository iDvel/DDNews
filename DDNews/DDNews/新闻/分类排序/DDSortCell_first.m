//
//  DDSortCell_first.m
//  DDNews
//
//  Created by Dvel on 16/4/16.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDSortCell_first.h"

@implementation DDSortCell_first

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		_button.titleLabel.font = [UIFont systemFontOfSize:15];
		[self addSubview:_button];
	}
	return self;
}

@end
