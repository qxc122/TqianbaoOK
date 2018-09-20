//
//  payTypeSeleTicon.h
//  portal
//
//  Created by MiNi on 2018/5/10.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "payTypeSele.h"

@interface payTypeSeleTicon : payTypeSele

@property (nonatomic,strong) NSString *payMethod;

@property (nonatomic,assign) BOOL isSuportBAL;  //是否支付零钱
@end
