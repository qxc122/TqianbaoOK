//
//  payTypeSeleBankCell.h
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface payTypeSeleBankCell : baseCell
@property (nonatomic,strong) scanQRCodeBankOne *scanQRCodeBankOne;
@property (nonatomic,strong) ThreeOkBankOne *threeOkBankOne;
@property (nonatomic,strong) Conductfinancialtransactions *ConductfinancialtransactionsData;
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIImageView *hook;
@property (nonatomic,weak) UIView *line;
@end
