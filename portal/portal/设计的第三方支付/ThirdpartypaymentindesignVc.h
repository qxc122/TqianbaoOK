//
//  ThirdpartypaymentindesignVc.h
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "paymentVc.h"

@interface ThirdpartypaymentindesignVc : paymentVc
@property (nonatomic,strong) NSDictionary *pasteboarddata;

@property (nonatomic,assign) BOOL isOA;
@property (nonatomic,strong) NSDictionary *payIdForOA;


@property (nonatomic,strong) ThreeOk *ThreeOkdata;
@property (nonatomic,strong) NSString *tcoinFlag;
@property (nonatomic,strong) ThreeOkBankOne *one;
- (void)popSelfCanl;
- (void)FootpayPre;
- (void)paySucces:(id)dataDict;
- (void)returenCustomaryAPPPro:(id)data;
@end
