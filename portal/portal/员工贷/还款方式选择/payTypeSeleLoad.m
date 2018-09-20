//
//  payTypeSeleLoad.m
//  portal
//
//  Created by Store on 2018/1/30.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "payTypeSeleLoad.h"

@implementation payTypeSeleLoad

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@(378));
        }];
        self.title.text  =@"选择付款方式";
        [self.close setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    }
    return self;
}


#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        kWeakSelf(self);
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([payTypeSeleBankCell class]) configuration:^(id cell) {
            [weakself configurepayTypeSeleBankCell:cell atIndexPath:indexPath];
        }];
    } else {
        kWeakSelf(self);
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([payTypeSeleMoneyCell class]) configuration:^(id cell) {
            [weakself configurepayTypeSeleMoneyCell:cell atIndexPath:indexPath];
        }];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.huanMoney doubleValue] <= [self.ThreeOkdata.cashAcctBal doubleValue]) {
        [self closeClisck];
        if (self.Selectionofrepaymentmethods) {
            self.Selectionofrepaymentmethods(indexPath.row==0?@"BANK":@"BAL");
        }
    } else {
        [MBProgressHUD showPrompt:@"您的可用余额不足～"];
    }
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        payTypeSeleMoneyCell *cell = [payTypeSeleMoneyCell returnCellWith:tableView];
        [self configurepayTypeSeleMoneyCell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        payTypeSeleBankCell *cell = [payTypeSeleBankCell returnCellWith:tableView];
        [self configurepayTypeSeleBankCell:cell atIndexPath:indexPath];
        return  cell;
    }
}
#pragma --mark< 配置payTypeSeleMoneyCell 的数据>
- (void)configurepayTypeSeleMoneyCell:(payTypeSeleMoneyCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.ThreeOkdata = self.ThreeOkdata;
    cell.icon.image = [UIImage imageNamed:@"理财余额"];
    cell.title.text = @"零钱";
    cell.des.text = [NSString stringWithFormat:@"可用余额  %.2f元",[self.ThreeOkdata.cashAcctBal doubleValue]];
}
#pragma --mark< 配置payTypeSeleBankCell 的数据>
- (void)configurepayTypeSeleBankCell:(payTypeSeleBankCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.threeOkBankOne = self.ThreeOkdata.bankCardsArray.firstObject;
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
@end
