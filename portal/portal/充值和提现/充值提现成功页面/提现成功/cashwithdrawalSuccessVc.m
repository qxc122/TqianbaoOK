//
//  cashwithdrawalSuccessVc.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "cashwithdrawalSuccessVc.h"
#import "cashwithdrawalSuccessHead.h"

@interface cashwithdrawalSuccessVc ()


@end

@implementation cashwithdrawalSuccessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"提现详情", @"");
    self.registerClasss = @[[ScanpaymentsuccessCell class],[ScanpaymentsuccessHasIconCell class]];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    
    [self setUI];
}
- (void)setUI{
    [self setheadForTableView];
    addBankCarkFoot *foot = [[addBankCarkFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+60)];
    self.foot = foot;
    //    [foot.btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"确认付款" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    //    [foot.btn setBackgroundImage:[ColorWithHex(0x5E7FFF, 1.0) imageWithColor] forState:UIControlStateNormal];
    
    //    foot.btn.enabled = NO;
    kWeakSelf(self);
    foot.doneBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    self.tableView.tableFooterView = foot;
}
- (void)customBackButton
{
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)setheadForTableView{
    cashwithdrawalSuccessHead *head = [[cashwithdrawalSuccessHead alloc]initWithFrame:CGRectMake(0, 0, 0, 189)];
    head.data = self.data;
    self.tableView.tableHeaderView = head;
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *data = self.Arry_data[indexPath.row];
    if ([data.title isEqualToString:NSLocalizedString(@"提现方式", @"")]) {
        ScanpaymentsuccessHasIconCell *cell = [ScanpaymentsuccessHasIconCell returnCellWith:tableView];
        [self configureScanpaymentsuccessHasIconCell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        ScanpaymentsuccessCell *cell = [ScanpaymentsuccessCell returnCellWith:tableView];
        [self configureScanpaymentsuccessCell:cell atIndexPath:indexPath];
        return  cell;
    }
}

#pragma --mark< 配置ScanpaymentsuccessHasIconCell 的数据>
- (void)configureScanpaymentsuccessHasIconCell:(ScanpaymentsuccessHasIconCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self configureScanpaymentsuccessCell:cell atIndexPath:indexPath];
//    cell.desIcon.image = [UIImage imageNamed:@"付款明细-银行卡"];
    [cell.desIcon sd_setImageWithURL:self.data.bankIcon placeholderImage:[UIImage imageNamed:@"付款明细-银行卡"]];
    cell.des.text = [NSString stringWithFormat:@"%@(%@)",self.data.bankName,self.data.cardNo];
}

#pragma --mark< 配置ScanpaymentsuccessCell 的数据>
- (void)configureScanpaymentsuccessCell:(ScanpaymentsuccessCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *data = self.Arry_data[indexPath.row];
    cell.dataScan = data;
    if ([data.title isEqualToString:NSLocalizedString(@"提现金额", @"")]) {
        cell.des.text = [NSString stringWithFormat:@"%.2f",[self.data.money doubleValue]];
    } else {
        cell.des.text = [NSString stringWithFormat:@"%.2f",[self.data.fee doubleValue]];
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}


- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        setUpData *tmp11 = [setUpData new];
        tmp11.title = NSLocalizedString(@"提现金额", @"");
        [_Arry_data addObject:tmp11];
        
        setUpData *tmp13 = [setUpData new];
        tmp13.title = NSLocalizedString(@"提现方式", @"");
        [_Arry_data addObject:tmp13];
        
        setUpData *tmp14 = [setUpData new];
        tmp14.title = NSLocalizedString(@"手续费 ", @"");
        [_Arry_data addObject:tmp14];
        
    }
    return _Arry_data;
}


@end
