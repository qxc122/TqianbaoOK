//
//  MaldivesPaySuccessVc.m
//  portal
//
//  Created by Store on 2018/3/13.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "MaldivesPaySuccessVc.h"
#import "typeCell.h"
#import "youhuiCell.h"
#import "MaldivesPaySuccessHead.h"
@interface MaldivesPaySuccessVc ()
@property (nonatomic,strong) NSMutableArray *Arry_data;
@end

@implementation MaldivesPaySuccessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
    self.title = NSLocalizedString(@"付款结果", @"");
    self.registerClasss = @[[youhuiCell class],[typeCell class]];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
//    self.fd_interactivePopDisabled = YES;
    [self setUI];
}
- (void)setUI{
    [self setheadForTableView];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, SCREENWIDTH, 26);
    imageView.image = [UIImage imageNamed:@"付款背景.png"];
//    imageView.contentMode = UIViewContentModeCenter;
    imageView.clipsToBounds = YES;
    self.tableView.tableFooterView = imageView;
}
- (void)customBackButton
{
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftBarutton;
    {
        UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtn)];
        leftBarutton.tintColor = [UIColor colorWithRed:238/255.0 green:199/255.0 blue:131/255.0 alpha:1/1.0];
        self.navigationItem.rightBarButtonItem = leftBarutton;
    }
}
- (void)doneBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setheadForTableView{
    MaldivesPaySuccessHead *head = [[MaldivesPaySuccessHead alloc]initWithFrame:CGRectMake(0, 0, 0, 180)];
    head.noticationdata = self.noticationdata;
    self.tableView.tableHeaderView = head;
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *data = self.Arry_data[indexPath.row];
    if ([data.title isEqualToString:NSLocalizedString(@"付款明细", @"")]) {
        typeCell *cell = [typeCell returnCellWith:tableView];
        [self configuretypeCell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        youhuiCell *cell = [youhuiCell returnCellWith:tableView];
        [self configureyouhuiCell:cell atIndexPath:indexPath];
        return  cell;
    }
}

#pragma --mark< 配置ScanpaymentsuccessHasIconCell 的数据>
- (void)configuretypeCell:(typeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *data = self.Arry_data[indexPath.row];
    cell.dataScan = data;
    if (self.noticationdata.conten.bankName.length) {
        [cell.desIcon sd_setImageWithURL:[NSURL URLWithString:self.noticationdata.conten.bankIconUrl] placeholderImage:[UIImage imageNamed:@"付款明细-银行卡"]];
        cell.des.text = [NSString stringWithFormat:@"%@(%@)",self.noticationdata.conten.bankName,self.noticationdata.conten.bankCardNo];
    } else {
        cell.desIcon.image = [UIImage imageNamed:@"付款明细-银行卡"];
        cell.des.text = @"零钱";
    }
    cell.lastLabel.text = [NSString stringWithFormat:@"-%.2f",[self.noticationdata.conten.tranAmt doubleValue]];
}

#pragma --mark< 配置ScanpaymentsuccessCell 的数据>
- (void)configureyouhuiCell:(youhuiCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *data = self.Arry_data[indexPath.row];
    cell.dataScan = data;
    cell.des.text = @"T比抵扣";
    cell.lastLabel.text = @"0.00";
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}


- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        setUpData *tmp11 = [setUpData new];
        tmp11.title = NSLocalizedString(@"优惠明细", @"");
        [_Arry_data addObject:tmp11];
        
        setUpData *tmp13 = [setUpData new];
        tmp13.title = NSLocalizedString(@"付款明细", @"");
        [_Arry_data addObject:tmp13];

        
    }
    return _Arry_data;
}


@end
