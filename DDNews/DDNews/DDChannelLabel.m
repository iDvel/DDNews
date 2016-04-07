//
//  DDChannelLabel.m
//  DDNews
//
//  Created by Dvel on 16/4/7.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDChannelLabel.h"

@implementation DDChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title
{
	DDChannelLabel *label = [self new];
	label.text = title;
	label.textAlignment = NSTextAlignmentCenter;
	label.font = [UIFont systemFontOfSize:18];
	[label sizeToFit];
	label.userInteractionEnabled = YES;
	return label;
}

- (NSString *)description
{
//	NSDictionary *dict = [self dictionaryWithValuesForKeys:@[]];
	return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.text];
}

@end
