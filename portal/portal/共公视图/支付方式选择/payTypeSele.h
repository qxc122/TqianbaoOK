//
//  payTypeSele.h
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"
#import "payTypeSeleBankCell.h"
#import "payTypeSeleMoneyCell.h"

@interface payTypeSele : windosView
@property (nonatomic,strong) Conductfinancialtransactions *ConductfinancialtransactionsData;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic, copy) void (^selecetType)(scanQRCodeBankOne *one);
@property (nonatomic, copy) void (^ThreeselecetType)(ThreeOkBankOne *one);
@property (nonatomic, copy) void (^ThreeselecetTypeForH5)(NSString *type);
@property (nonatomic,strong) scanQRCodeOk *scanQRCodeOkdata;

@property (nonatomic,strong) ThreeOk *ThreeOkdata;


@property (nonatomic,strong) NSString *money;  //要充值的金额


@property (nonatomic,weak) UILabel *title;

#pragma --mark< 配置payTypeSeleMoneyCell 的数据>
- (void)configurepayTypeSeleMoneyCell:(payTypeSeleMoneyCell *)cell atIndexPath:(NSIndexPath *)indexPath;

#pragma --mark< 配置payTypeSeleBankCell 的数据>
- (void)configurepayTypeSeleBankCell:(payTypeSeleBankCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
