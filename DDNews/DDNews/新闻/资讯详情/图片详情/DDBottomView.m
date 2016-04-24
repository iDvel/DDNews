//
//  DDBottomView.m
//  DDNews
//
//  Created by Dvel on 16/4/20.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDBottomView.h"

@interface DDBottomView ()

@end

@implementation DDBottomView

- (void)awakeFromNib
{
//	[self.commentCount setTitle:@" 23148" forState:UIControlStateNormal];
}

- (IBAction)backBtn:(id)sender
{
	if (self.backBtnBlock) {
		self.backBtnBlock();
	}
}

- (IBAction)commentCountClick:(id)sender
{
	if (self.commentCountBlock) {
		self.commentCountBlock();
	}
}

- (IBAction)writeClick:(UIButton *)sender
{
	if (self.writeBlock) {
		self.writeBlock();
	}
}

- (IBAction)collecClick:(id)sender
{
	if (self.collectBlock) {
		self.collectBlock();
	}
}

- (IBAction)downloadClick:(id)sender
{
	if (self.downloadBlock) {
		self.downloadBlock();
	}
}

@end
