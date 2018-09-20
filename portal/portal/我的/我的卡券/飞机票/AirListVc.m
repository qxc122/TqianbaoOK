//
//  AirListVc.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "AirListVc.h"
#import "AirListVcCell.h"
#import "AirTicketsAndBankCardsShow.h"
@interface AirListVc ()
@property (nonatomic,strong) bankList *airArry;
@end

@implementation AirListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.header beginRefreshing];
    self.NodataTitle = @"暂无飞机票";
    self.registerClasss = @[[AirListVcCell class]];
//    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AirListVcCell *cell = [AirListVcCell returnCellWith:tableView];
    [self configureAirListVcCell:cell atIndexPath:indexPath];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AirTicketsAndBankCardsShow *view = [AirTicketsAndBankCardsShow new];
    UserInfoDeatil *tmp = [UserInfoDeatil new];
    for (bankCard *one in self.airArry.Arry_list) {
        one.type = HOME_TYPE_AIR;
    }
    tmp.Arry_list = self.airArry.Arry_list;
    view.userData = tmp;
    view.indexx = indexPath.row;
    [view windosViewshow];
}


#pragma --mark< 配置AirListVcCell 的数据>
- (void)configureAirListVcCell:(AirListVcCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.one = self.airArry.Arry_list[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.airArry.Arry_list.count;
}
- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpurseuserqueryMyFlightsuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.airArry = [bankList mj_objectWithKeyValues:dataDict];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
//        weakself.header.hidden = YES;
    } failure:^(NSInteger errorCode, NSString *msg) {
//        weakself.header.hidden = YES;
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}
#pragma --<空白页处理>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.empty_type == succes_empty_num) {
        return [UIImage imageNamed:@"暂无可用券"];
    }else{
        return [super imageForEmptyDataSet:scrollView];
    }
    return nil;
}
@end
