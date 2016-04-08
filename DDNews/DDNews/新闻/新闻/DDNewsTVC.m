//
//  DDNewsTVC.m
//  DDNews
//
//  Created by Dvel on 16/4/8.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsTVC.h"
#import "DDNewsModel.h"
#import "DDNewsCell.h"

@interface DDNewsTVC ()
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation DDNewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setUrlString:(NSString *)urlString
{
	_urlString = urlString;
	
	[DDNewsModel newsDataListWithUrlString:urlString complection:^(NSMutableArray *array) {
		_dataList = array;
		[self.tableView reloadData]; // 不刷新的话，数据会显示复用的，而不是对应频道的。
	}];

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DDNewsModel *newsModel = self.dataList[indexPath.row];
	DDNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[DDNewsCell cellReuseID:newsModel] forIndexPath:indexPath];
	cell.newsModel = newsModel;
	[self setupCycleImageClickWithCell:cell newsModel:newsModel];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DDNewsModel *newsModel = self.dataList[indexPath.row];
	return [DDNewsCell cellForHeight:newsModel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"%s", __func__);
}

#pragma mark -
/** 轮播点击事件 */
- (void)setupCycleImageClickWithCell:(DDNewsCell *)cell newsModel:(DDNewsModel *)newsModel
{
	cell.cycleImageClickBlock = ^(NSInteger idx){
		NSLog(@"%zd", idx);
	};
}


@end
