//
//  RechargeandcashwithdrawalBankCell.h
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"





@interface RechargeandcashwithdrawalBankCell : baseCell
@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) UIImageView *Banklogo;
@property (nonatomic,weak) UILabel *BankName;
@property (nonatomic,weak) UILabel *BankNumber;


@property (nonatomic,weak) UIImageView *more;
@property (nonatomic,strong) ThreeOk *ThreeOkData;
@property (nonatomic,strong) UserInfoDeatil *userData;
@property (nonatomic,strong) Conductfinancialtransactions *ConductfinancialtransactionsData;

@property (nonatomic,strong) NSString *type;


@property (nonatomic,strong) ThreeOkBankOne *oneBank;
@end
