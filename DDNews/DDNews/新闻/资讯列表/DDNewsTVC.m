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
#import "DDNewsCache.h"
#import "DDNewsDetailController.h"

#import "MJRefresh.h"

@interface DDNewsTVC ()
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation DDNewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	__weak typeof(self) weakSelf = self;
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		[weakSelf refreshData];
	}];
	self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
		[weakSelf loadMoreData];
	}];
	
	// 去除刷新前的横线
	UIView*view = [UIView new];
	view.backgroundColor= [UIColor clearColor];
	[self.tableView setTableFooterView:view];
}

- (void)setUrlString:(NSString *)urlString
{
	_urlString = urlString;
	
	[DDNewsModel newsDataListWithUrlString:urlString complection:^(NSMutableArray *array) {
		_dataList = array;
		[self.tableView reloadData]; // 不刷新的话，数据会显示复用的，而不是对应频道的。
	}];
	
	// 投机取个巧
	if ([[DDNewsCache sharedInstance] containsObject:urlString]) {
		return;
	} else{
		[[DDNewsCache sharedInstance] addObject:urlString];
		[self.tableView.mj_header beginRefreshing];
	}
}

- (void)viewWillDisappear:(BOOL)animated
{
	[[DDNewsCache sharedInstance] removeAllObjects];
}


#pragma mark 刷新
//	NSLog(@"self.urlString = %@", self.urlString); // article/headline/T1348647853363/0-20.html
//	NSLog(@"%@", [self.urlString substringWithRange:NSMakeRange(17, 14)]); // T1348647853363

/** 下拉刷新 */
- (void)refreshData
{
	// 获取tid来拼接urlString
	NSString *tid = [self.urlString substringWithRange:NSMakeRange(17, 14)];
	NSString *urlString = [NSString stringWithFormat:@"article/headline/%@/0-20.html" ,tid];
	[DDNewsModel newsDataListWithUrlString:urlString complection:^(NSMutableArray *array) {
		self.dataList = array;
		[self.tableView reloadData];
		[self.tableView.mj_header endRefreshing];
	}];
}

/** 上拉加载 */
- (void)loadMoreData
{
	// 获取tid来拼接urlString
	NSString *tid = [self.urlString substringWithRange:NSMakeRange(17, 14)];
	// 让前面的数字是20的整数倍，多出来的 减去 模剩下的，正好是20的整数倍。
	NSString *urlString = [NSString stringWithFormat:@"article/headline/%@/%zd-20.html" ,tid, self.dataList.count - self.dataList.count % 20];
//		NSLog(@"```%zd", self.dataList.count - self.dataList.count % 20);
	[DDNewsModel newsDataListWithUrlString:urlString complection:^(NSArray *array) {
		[self.dataList addObjectsFromArray:array];
		[self.tableView reloadData];
		[self.tableView.mj_footer endRefreshing];
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
	DDNewsModel *newsModel = self.dataList[indexPath.row];
	if (newsModel.photosetID) {
		NSLog(@"~");
	} else {
		// NSLog(@"newsModel.url = %@", newsModel.url); // http://3g.163.com/ntes/16/0315/21/BI7TE54L00963VRO.html
		// NSLog(@"newsModel.docid = %@", newsModel.docid); // BI7TE54L00963VRO
		DDNewsDetailController *NewsDetailC = [[DDNewsDetailController alloc] initWithUrlString:newsModel.url];
		[self.navigationController pushViewController:NewsDetailC animated:YES];
	}
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
