//
//  WithdrawCashVc.h
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "paymentVc.h"
#import "RechargeandcashwithdrawalBankCell.h"
#import "RechargeandcashwithdrawalMoneyCell.h"

typedef enum {
    SeleVC_Recharge,
    SeleVC_WithdrawCash
} SeleVC;


typedef enum {
    WithdrawCashVc_load_type_NONE,
    WithdrawCashVc_load_type_H5
} WithdrawCashVc_load_type;


@interface WithdrawCashVc : paymentVc
@property (nonatomic,assign)WithdrawCashVc_load_type load_type; //默认 WithdrawCashVc_load_type_NONE

//@property (nonatomic,assign)SeleVC state; //是 余额 还是 充值余额
@property (nonatomic,assign)RechargeandcashwithdrawalVcState stateMoney; //默认
#pragma --mark< 配置RechargeandcashwithdrawalBankCell 的数据>
- (void)configureRechargeandcashwithdrawalBankCell:(RechargeandcashwithdrawalBankCell *)cell atIndexPath:(NSIndexPath *)indexPath;

#pragma --mark< 配置RechargeandcashwithdrawalMoneyCell 的数据>
- (void)configureRechargeandcashwithdrawalMoneyCell:(RechargeandcashwithdrawalMoneyCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end
