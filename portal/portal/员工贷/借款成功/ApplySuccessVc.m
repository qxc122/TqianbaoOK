//
//  ApplySuccessVc.m
//  portal
//
//  Created by Store on 2018/1/29.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "ApplySuccessVc.h"
#import "EmployeeLoanHead.h"
@interface ApplySuccessVc ()

@end

@implementation ApplySuccessVc
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setselfArry_data];
    self.title = NSLocalizedString(@"随行借", @"");
    [self.foot.btn setTitle:@"完成" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}
- (void)customBackButton
{
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)setheadForTableView{
    EmployeeLoanHead *head = [[EmployeeLoanHead alloc]initWithFrame:CGRectMake(0, 0, 0, 242+10)];
    head.des.hidden = NO;
    head.title.text = @"申请提交成功";
    self.tableView.tableHeaderView = head;
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *data = self.Arry_data[indexPath.row];
    if ([data.title isEqualToString:NSLocalizedString(@"到账银行账户", @"")]) {
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
    cell.title.text = @"到账银行账户";
    [cell.desIcon sd_setImageWithURL:self.ApplySuccessokdata.bankIcon placeholderImage:[UIImage imageNamed:@"付款明细-银行卡"]];
//        cell.desIcon.image = [UIImage imageNamed:@"付款明细-银行卡"];
    cell.des.text = [NSString stringWithFormat:@"%@(%@)",self.ApplySuccessokdata.bankName,self.ApplySuccessokdata.bankNo];
}

#pragma --mark< 配置ScanpaymentsuccessCell 的数据>
- (void)configureScanpaymentsuccessCell:(ScanpaymentsuccessCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.title.text = @"借款金额";
    cell.des.text = [NSString stringWithFormat:@"%.2f",[self.ApplySuccessokdata.loanAmt doubleValue]];
}

- (void)setselfArry_data{
    self.Arry_data = [NSMutableArray array];
    
    setUpData *tmp11 = [setUpData new];
    tmp11.title = NSLocalizedString(@"借款金额", @"");
    [self.Arry_data addObject:tmp11];

    setUpData *tmp13 = [setUpData new];
    tmp13.title = NSLocalizedString(@"到账银行账户", @"");
    [self.Arry_data addObject:tmp13];
}

@end
