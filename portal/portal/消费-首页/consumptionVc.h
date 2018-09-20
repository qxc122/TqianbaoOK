//
//  consumptionVc.h
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"

typedef enum {
    consumptionVcState_Scancodepayment = 5, //扫码付款
    consumptionVcState_Paymentcode      //付款码
} consumptionVcState;

@interface consumptionVc : basicVc
@property (nonatomic,assign)consumptionVcState state; //默认 consumptionVcState_Paymentcode
@end
