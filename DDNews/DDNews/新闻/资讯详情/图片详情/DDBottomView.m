//
//  DDBottomView.m
//  DDNews
//
//  Created by Dvel on 16/4/20.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDBottomView.h"

@interface DDBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end

@implementation DDBottomView

- (void)awakeFromNib
{
//	[self.commentCount setTitle:@" 23148" forState:UIControlStateNormal];
	[_collectBtn setImage:[UIImage imageNamed:@"comment_ collect"] forState:UIControlStateNormal];
	[_collectBtn setImage:[UIImage imageNamed:@"comment_ collect_selected"] forState:UIControlStateSelected];
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
		self.collectBlock(sender);
	}
}

- (IBAction)downloadClick:(id)sender
{
	if (self.downloadBlock) {
		self.downloadBlock();
	}
}

@end
