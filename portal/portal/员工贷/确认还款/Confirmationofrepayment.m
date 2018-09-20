//
//  Confirmationofrepayment.m
//  portal
//
//  Created by Store on 2018/1/30.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "Confirmationofrepayment.h"
#import "ConfirmapayTypeSeleBankCell.h"
#import "ConfirmapayTypeSeleMoneyCell.h"
#import "ScanpaymentsuccessCell.h"
#import "payTypeSeleLoad.h"
@interface Confirmationofrepayment ()

@end


@implementation Confirmationofrepayment
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.typeConfirmat = @"BANK";
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.back.userInteractionEnabled = YES;
        [self.back SetFilletWith:0];
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@(378));
        }];
        
        [self.close mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.left.equalTo(self.back).offset(5.5);
            make.top.equalTo(self.back).offset(0.5);
        }];
        [self.close setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        self.title.text  =@"确认还款";
        [self.tableView registerClass:[ConfirmapayTypeSeleBankCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmapayTypeSeleBankCell class])];
        [self.tableView registerClass:[ConfirmapayTypeSeleMoneyCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmapayTypeSeleMoneyCell class])];
        [self.tableView registerClass:[ScanpaymentsuccessCell class] forCellReuseIdentifier:NSStringFromClass([ScanpaymentsuccessCell class])];
        
        {
            UIButton *btn = [UIButton new];
            [btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"确认还款" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:18 NormalROrM:@"r" backColor:0x5E7FFF backAlpha:1.0];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.height.equalTo(@50);
                make.bottom.equalTo(self).offset(-48);
            }];
            [btn SetFilletWith:8.0];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
- (void)btnClick{
    if (self.ThreeselecetTypeForH5) {
        self.ThreeselecetTypeForH5(self.typeConfirmat);
    }
}
#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        kWeakSelf(self);
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ScanpaymentsuccessCell class]) configuration:^(id cell) {
            [weakself configureScanpaymentsuccessCell:cell atIndexPath:indexPath];
        }];
    } else {
        if ([self.typeConfirmat isEqualToString:@"BAL"]) {
            kWeakSelf(self);
            return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ConfirmapayTypeSeleMoneyCell class]) configuration:^(id cell) {
                [weakself configureConfirmapayTypeSeleMoneyCell:cell atIndexPath:indexPath];
            }];
        } else {
            kWeakSelf(self);
            return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ConfirmapayTypeSeleBankCell class]) configuration:^(id cell) {
                [weakself configureConfirmapayTypeSeleBankCell:cell atIndexPath:indexPath];
            }];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    payTypeSeleLoad *view = [payTypeSeleLoad new];
    kWeakSelf(self);
    view.Selectionofrepaymentmethods = ^(NSString *type) {
        if (type != weakself.typeConfirmat) {
            weakself.typeConfirmat = type;
            [weakself.tableView reloadData];
        }
    };
    view.ThreeOkdata = self.ThreeOkdata;
    [view windosViewshow];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ScanpaymentsuccessCell *cell = [ScanpaymentsuccessCell returnCellWith:tableView];
        [self configureScanpaymentsuccessCell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        if ([self.typeConfirmat isEqualToString:@"BAL"]) {
            ConfirmapayTypeSeleMoneyCell *cell = [ConfirmapayTypeSeleMoneyCell returnCellWith:tableView];
            [self configureConfirmapayTypeSeleMoneyCell:cell atIndexPath:indexPath];
            return  cell;
        } else {
            ConfirmapayTypeSeleBankCell *cell = [ConfirmapayTypeSeleBankCell returnCellWith:tableView];
            [self configureConfirmapayTypeSeleBankCell:cell atIndexPath:indexPath];
            return  cell;
        }
    }
}
#pragma --mark< 配置ScanpaymentsuccessCell 的数据>
- (void)configureScanpaymentsuccessCell:(ScanpaymentsuccessCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.title.text = @"还款金额";
    cell.des.text = [NSString stringWithFormat:@"%.2f",[self.huanMoney doubleValue]];
}

#pragma --mark< 配置ConfirmapayTypeSeleMoneyCell 的数据>
- (void)configureConfirmapayTypeSeleMoneyCell:(ConfirmapayTypeSeleMoneyCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.icon.image = [UIImage imageNamed:@"理财余额"];
    cell.title.text = @"零钱";
    cell.des.text = [NSString stringWithFormat:@"可用余额  %.2f元",[self.ThreeOkdata.cashAcctBal doubleValue]];
}
#pragma --mark< 配置ConfirmapayTypeSeleBankCell 的数据>
- (void)configureConfirmapayTypeSeleBankCell:(ConfirmapayTypeSeleBankCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.threeOkBankOne = self.ThreeOkdata.bankCardsArray[indexPath.row-1];
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
@end
