//
//  payTypeSeleMoneyCell.h
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "payTypeSeleBankCell.h"

@interface payTypeSeleMoneyCell : payTypeSeleBankCell
@property (nonatomic,weak) UILabel *des;
@property (nonatomic,strong) scanQRCodeOk *scanQRCodeokdata;
@property (nonatomic,strong) ThreeOk *ThreeOkdata;
@end
