//
//  Confirmationofrepayment.h
//  portal
//
//  Created by Store on 2018/1/30.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "payTypeSele.h"

@interface Confirmationofrepayment : payTypeSele
@property (nonatomic,strong) NSString *typeConfirmat;  //银行卡 还是余额

@property (nonatomic,strong) NSString *huanMoney;  //要还款的金额
@end
