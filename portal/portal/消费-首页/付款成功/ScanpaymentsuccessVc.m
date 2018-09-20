//
//  ScanpaymentsuccessVc.m
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScanpaymentsuccessVc.h"
#import "ScanpaymentsuccessHead.h"
#import "cashwithdrawalSuccessHead.h"
#import "ScanpaymentsuccessCell.h"
#import "ScanpaymentsuccessHasIconCell.h"
@interface ScanpaymentsuccessVc ()
@property (nonatomic,strong) NSMutableArray *Arry_data;
@end

@implementation ScanpaymentsuccessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"向个人转账", @"");
    self.registerClasss = @[[ScanpaymentsuccessCell class],[ScanpaymentsuccessHasIconCell class]];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    
    [self setUI];

}
- (void)setUI{
    ScanpaymentsuccessHead *head = [[ScanpaymentsuccessHead alloc]initWithFrame:CGRectMake(0, 0, 0, 196*PROPORTION_HEIGHT)];
    head.titlee.text = @"转账成功";
    self.tableView.tableHeaderView = head;
    UIBarButtonItem* rightBarutton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"") style:UIBarButtonItemStylePlain target:self action:@selector(OkFUNc)];
    self.navigationItem.rightBarButtonItem = rightBarutton;
    [self setRightBtn];
}
- (void)OkFUNc{
    [self popSelf];
    NSLog(@"%s",__func__);
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *data = self.Arry_data[indexPath.row];
    if ([data.title isEqualToString:NSLocalizedString(@"付款方式", @"")] && self.one) {
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
    cell.des.text = self.dataDone.bankName;
    cell.desIcon.image = ImageNamed(@"付款明细-银行卡");
}

#pragma --mark< 配置ScanpaymentsuccessCell 的数据>
- (void)configureScanpaymentsuccessCell:(ScanpaymentsuccessCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *tmp = self.Arry_data[indexPath.row];
    cell.dataScan = tmp;
    if ([tmp.title isEqualToString:@"收款方"]) {
        cell.des.text = self.dataDone.payeeName;
    } else if ([tmp.title isEqualToString:@"收款金额"]) {
        cell.des.text = self.dataDone.money;
    }else {
        cell.des.text = @"零钱支付";
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
        tmp11.title = NSLocalizedString(@"收款方", @"");
        [_Arry_data addObject:tmp11];
        
        setUpData *tmp12 = [setUpData new];
        tmp12.title = NSLocalizedString(@"收款金额", @"");
        [_Arry_data addObject:tmp12];
        
        setUpData *tmp13 = [setUpData new];
        tmp13.title = NSLocalizedString(@"付款方式", @"");
        [_Arry_data addObject:tmp13];

    }
    return _Arry_data;
}

@end
