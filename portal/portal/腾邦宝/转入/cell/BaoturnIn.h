//
//  BaoturnIn.h
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "RechargeandcashwithdrawalMoneyCell.h"

@interface BaoturnIn : RechargeandcashwithdrawalMoneyCell
@property (nonatomic,weak) UIButton *btnALL;
@property (nonatomic,assign) NSString *Outtype;   //转出方式

@property (nonatomic,strong) tpTreasurequeryPayMethod *PayMethodData;


@end
