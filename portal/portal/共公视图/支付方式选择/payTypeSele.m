//
//  payTypeSele.m
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "payTypeSele.h"

#import "MJRefresh.h"

@interface payTypeSele ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UIView *titleDesBack;
@property (nonatomic,weak) UILabel *titleDes;

@property (nonatomic,strong) NSIndexPath *SelectindexPath;
@end


@implementation payTypeSele
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
            make.height.equalTo(@(50+55+200));
        }];
        
        [self.close mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.left.equalTo(self.back).offset(5.5);
            make.top.equalTo(self.back).offset(0.5);
        }];
        [self.close setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        UILabel *title = [UILabel new];
        [self.back addSubview:title];
        self.title = title;
        
        UIView *titleDesBack = [UIView new];
        [self.back addSubview:titleDesBack];
        self.titleDesBack = titleDesBack;
        
        UILabel *titleDes = [UILabel new];
        [self.back addSubview:titleDes];
        self.titleDes = titleDes;
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.centerY.equalTo(self.close);
        }];
        [self.titleDesBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.top.equalTo(self.close.mas_bottom).offset(3.5);
//            make.height.equalTo(@55);
            make.height.equalTo(@20);
        }];
        [self.titleDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleDesBack).offset(20);
            make.right.equalTo(self.titleDesBack).offset(-20);
            make.top.equalTo(self.titleDesBack);
            make.bottom.equalTo(self.titleDesBack);
        }];
//        titleDes.backgroundColor = ColorWithHex(0xF5F5F5, 1.0);
//        titleDes.text  =@"优先使用所选付款方式，如付款失败将尝试使用其他方式完成付款";
        
        [title setWithColor:0x161E2B Alpha:1.0 Font:17 ROrM:@"r"];
        [titleDes setWithColor:0xCBCED3 Alpha:1.0 Font:14 ROrM:@"r"];
        title.textAlignment = NSTextAlignmentCenter;
        titleDes.numberOfLines = 0;
        title.text  =@"选择优先付款方式";
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.backgroundColor =  [UIColor clearColor];
    self.tableView = tableView;
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.back);
        make.left.equalTo(self.back);
        make.top.equalTo(self.titleDesBack.mas_bottom);
        make.bottom.equalTo(self.back);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;


    [self.tableView registerClass:[payTypeSeleBankCell class] forCellReuseIdentifier:NSStringFromClass([payTypeSeleBankCell class])];
    [self.tableView registerClass:[payTypeSeleMoneyCell class] forCellReuseIdentifier:NSStringFromClass([payTypeSeleMoneyCell class])];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
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
    if (self.SelectindexPath) {
        payTypeSeleBankCell *cell = [tableView cellForRowAtIndexPath:self.SelectindexPath];
        cell.hook.highlighted = NO;
    }
    self.SelectindexPath = indexPath;
    payTypeSeleBankCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.hook.highlighted = YES;
    

    if (self.selecetType) {
        scanQRCodeBankOne *tmp;
        if (indexPath.row != 0) {
            tmp = self.scanQRCodeOkdata.bankCardArray[indexPath.row-1];
        }
        self.selecetType(tmp);
    }
    if (self.ThreeselecetType) {
        ThreeOkBankOne *tmp;
        if (indexPath.row != 0) {
            tmp = self.ThreeOkdata.bankCardsArray[indexPath.row-1];
        }
        self.ThreeselecetType(tmp);
    }
    if(self.ConductfinancialtransactionsData){
        NSString *type;
        if(indexPath.row == 0){
            type = @"TPURSE";
        }else{
            type = @"BANK";
        }
        if(self.ThreeselecetTypeForH5){
            if ([type isEqualToString:@"TPURSE"] && [self.ConductfinancialtransactionsData.tpurseAcctBal floatValue] < [self.money floatValue]) {
                [MBProgressHUD showPrompt:@"您的T钱包零钱不足,请选用银行卡充值" afterDelay:2.0];
            } else {
                self.ThreeselecetTypeForH5(type);
            }
        }
    }
    [self closeClisck];
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
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
    if (self.scanQRCodeOkdata) {
        cell.scanQRCodeokdata = self.scanQRCodeOkdata;
    } else if(self.ThreeOkdata){
        cell.ThreeOkdata = self.ThreeOkdata;
    } else if(self.ConductfinancialtransactionsData){
        cell.ConductfinancialtransactionsData = self.ConductfinancialtransactionsData;
    }
}
#pragma --mark< 配置payTypeSeleBankCell 的数据>
- (void)configurepayTypeSeleBankCell:(payTypeSeleBankCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.scanQRCodeOkdata) {
        cell.scanQRCodeBankOne = self.scanQRCodeOkdata.bankCardArray.firstObject;
    } else if(self.ThreeOkdata){
        cell.threeOkBankOne = self.ThreeOkdata.bankCardsArray.firstObject;
    } else if(self.ConductfinancialtransactionsData){
        cell.ConductfinancialtransactionsData = self.ConductfinancialtransactionsData;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.scanQRCodeOkdata) {
        return self.scanQRCodeOkdata.bankCardArray.count +1;
    } else if(self.ThreeOkdata){
        return self.ThreeOkdata.bankCardsArray.count +1;
    } else if(self.ConductfinancialtransactionsData){
        return 2;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
