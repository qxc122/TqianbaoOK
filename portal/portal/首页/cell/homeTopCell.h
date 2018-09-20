//
//  homeTopCell.h
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

typedef enum {
    homeTopCellType_Recharge,
    homeTopCellType_WithdrawCash,
    homeTopCellType_consumption,
    homeTopCellType_balance,
    homeTopCellType_Financial_gold,
    homeTopCellType_Immediate_investment,
} homeTopCellType;



@interface homeTopCell : baseCell
@property (nonatomic,strong) UserInfoDeatil *userData;
@property (nonatomic, copy) void (^ClicBtnTag)(homeTopCellType type);
@end
