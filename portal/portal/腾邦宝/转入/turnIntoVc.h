//
//  turnIntoVc.h
//  portal
//
//  Created by Store on 2018/1/25.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "paymentVc.h"
#import "WithdrawCashFoot.h"
#import "turnOutType.h"
#import "headRechargeandCell.h"
#import "BaoturnIn.h"
#import "topCell.h"

@interface turnIntoVc : paymentVc
@property (nonatomic,strong) tpTreasurequeryPayMethod *PayMethodData;
@property (nonatomic,strong) noticeData *MynoticeData;

@property (nonatomic,assign) NSString *Outtype;   //转出方式
@property (nonatomic,weak) WithdrawCashFoot *foot;
@property (nonatomic,assign) NSString *type;

@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *noticeType;


- (void)doneBtnoutOrIn;
@end
