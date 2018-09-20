//
//  VenturecapitalRealNameVc.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "VenturecapitalRealNameVc.h"
#import "ReaNamebaseFillCell.h"
@interface VenturecapitalRealNameVc ()

@end

@implementation VenturecapitalRealNameVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.head.title.text = NSLocalizedString(@"请完成实名认证", @"");
    [self SetArry_data];
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, 0, 50+60*2);
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReaNamebaseFillCell *cell = [ReaNamebaseFillCell returnCellWith:tableView];
    [self configurebaseFillCell:cell atIndexPath:indexPath];
    return  cell;
}

- (void)SetArry_data{
    [self.Arry_data removeAllObjects];
    setUpData *tmp1 = [setUpData new];
    tmp1.title = NSLocalizedString(@"姓名", @"");
    tmp1.describe = NSLocalizedString(@"请输入姓名", @"");
    tmp1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.Arry_data addObject:tmp1];
    
    setUpData *tmp11 = [setUpData new];
    tmp11.title = NSLocalizedString(@"身份证", @"");
    tmp11.describe = NSLocalizedString(@"请输入18位身份证号", @"");
    tmp11.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.Arry_data addObject:tmp11];
    
    setUpData *tmp2 = [setUpData new];
    tmp2.title = NSLocalizedString(@"持卡银行", @"");
    tmp2.describe = NSLocalizedString(@"请输入银行卡号", @"");
    [self.Arry_data addObject:tmp2];
}
@end
