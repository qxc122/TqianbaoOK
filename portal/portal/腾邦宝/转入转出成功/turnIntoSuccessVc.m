//
//  turnIntoSuccessVc.m
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "turnIntoSuccessVc.h"
#import "IncashwithdrawalSuccessHead.h"
@interface turnIntoSuccessVc ()

@end

@implementation turnIntoSuccessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"转入详情", @"");
    [self setselfArry_data];
    [self.foot.btn setTitle:@"完成" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}
- (void)customBackButton
{
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *data = self.Arry_data[indexPath.row];
    if ([data.title isEqualToString:NSLocalizedString(@"转入方式", @"")]) {
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
    [cell.desIcon sd_setImageWithURL:self.outORINSuccessdata.bankIcon placeholderImage:[UIImage imageNamed:@"付款明细-银行卡"]];
//    cell.desIcon.image = [UIImage imageNamed:@"付款明细-银行卡"];
    cell.des.text = [NSString stringWithFormat:@"%@(%@)",self.outORINSuccessdata.bankName,self.outORINSuccessdata.cardNo];
}

#pragma --mark< 配置ScanpaymentsuccessCell 的数据>
- (void)configureScanpaymentsuccessCell:(ScanpaymentsuccessCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *data = self.Arry_data[indexPath.row];
    cell.dataScan = data;
    if ([data.title isEqualToString:NSLocalizedString(@"转入金额", @"")]) {
        cell.des.text = [NSString stringWithFormat:@"%.2f",[self.outORINSuccessdata.price doubleValue]];
    } else {
        cell.des.text = [NSString stringWithFormat:@"%.2f",[self.outORINSuccessdata.fee doubleValue]];
    }
}


- (void)setheadForTableView{
    IncashwithdrawalSuccessHead *head = [[IncashwithdrawalSuccessHead alloc]initWithFrame:CGRectMake(0, 0, 0, 269)];
    head.outORINSuccessdata = self.outORINSuccessdata;
    self.tableView.tableHeaderView = head;
}


- (void)setselfArry_data{
    self.Arry_data = [NSMutableArray array];
    setUpData *tmp11 = [setUpData new];
    tmp11.title = NSLocalizedString(@"转入金额", @"");
    [self.Arry_data addObject:tmp11];
    
    setUpData *tmp13 = [setUpData new];
    tmp13.title = NSLocalizedString(@"转入方式", @"");
    [self.Arry_data addObject:tmp13];
    
    setUpData *tmp14 = [setUpData new];
    tmp14.title = NSLocalizedString(@"手续费 ", @"");
    [self.Arry_data addObject:tmp14];
}

@end
