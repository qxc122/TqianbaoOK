//
//  AddBankCardVc.h
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"
#import "baseFillCell.h"
#import "addBankCardselectBankcell.h"
#import "addBankCardsmscell.h"
#import "addBankCarkFoot.h"
#import "ReaNamebaseFillCell.h"
#import "ReaNameaddBankCardsmscell.h"
#import "ReaNameaddBankCardselectBankcell.h"


@interface AddBankCardVc : basicUiTableView
- (void)addFoot;
@property (nonatomic,strong) bankList *bankListdata;

@property (nonatomic,weak) addBankCarkFoot *foot;
@property (nonatomic,copy) LoadSuccess block;
@property (nonatomic,strong) NSMutableArray *Arry_data;
#pragma --mark< 配置addBankCard_smscell 的数据>
- (void)configureaddBankCardselectBankcell:(addBankCardselectBankcell *)cell atIndexPath:(NSIndexPath *)indexPath ;
#pragma --mark< 配置addBankCard_smscell 的数据>
- (void)configureaddBankCardsmscell:(addBankCardsmscell *)cell atIndexPath:(NSIndexPath *)indexPath;
#pragma --mark< 配置baseFillCell 的数据>
- (void)configurebaseFillCell:(baseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)bingBank;
@end
