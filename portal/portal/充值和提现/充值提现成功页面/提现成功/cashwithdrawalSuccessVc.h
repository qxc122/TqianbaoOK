//
//  cashwithdrawalSuccessVc.h
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"
#import "ScanpaymentsuccessCell.h"
#import "ScanpaymentsuccessHasIconCell.h"
#import "addBankCarkFoot.h"

@interface cashwithdrawalSuccessVc : basicUiTableView
@property (nonatomic,strong) NSMutableArray *Arry_data;
@property (nonatomic,strong) Successincashwithdrawal *data;
@property (nonatomic,weak) addBankCarkFoot *foot;
@end
