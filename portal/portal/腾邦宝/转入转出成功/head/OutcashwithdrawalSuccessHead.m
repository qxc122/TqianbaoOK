//
//  OutcashwithdrawalSuccessHead.m
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "OutcashwithdrawalSuccessHead.h"



@implementation OutcashwithdrawalSuccessHead
- (void)setOutORINSuccessdata:(outORINSuccess *)outORINSuccessdata{
    _outORINSuccessdata = outORINSuccessdata;
    self.titleTop.text = @"转出申请已提交";
    self.DateTop.text = @"今天";
    
    self.titleBottom.text = @"预计到账时间";
    self.DateBottom.text = outORINSuccessdata.arrDate;
}
@end
