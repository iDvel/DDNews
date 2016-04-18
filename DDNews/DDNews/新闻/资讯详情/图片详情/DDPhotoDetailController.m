//
//  DDPhotoDetailController.m
//  DDNews
//
//  Created by Dvel on 16/4/18.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDPhotoDetailController.h"
#import "DDPhotoModel.h"

#import "JT3DScrollView.h"
#import "JZNavigationExtension.h"

@interface DDPhotoDetailController ()
@property (nonatomic, strong) DDPhotoModel *photoModel;

@end

@implementation DDPhotoDetailController

- (instancetype)initWithPhotosetID:(NSString *)photosetID
{
	self = [super init];
	if (self) {
		[DDPhotoModel photoModelWithPhotosetID:(NSString *)photosetID complection:^(DDPhotoModel *photoModel) {
			self.photoModel = photoModel;
		}];
		self.view.backgroundColor = [UIColor colorWithRed:0.174 green:0.174 blue:0.164 alpha:1.000];
		self.navigationController.fullScreenInteractivePopGestureRecognizer = YES;
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
	}
	return self;
}

/** 模型初始化后，开始搭建UI。 */
- (void)setPhotoModel:(DDPhotoModel *)photoModel
{
	
}

@end
