//
//  GesturecipherVc.h
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"
#import "YHGesturePasswordView.h"

//typedef enum {
//    GesturecipherVcStateSet, //设置手势密码
//    GesturecipherVcStateAuthentication //已有手势密码教验
//} GesturecipherVcState;


@interface GesturecipherVc : basicVc

@property (nonatomic,assign) BOOL Resetafterverification; //验证后重设置
@property (nonatomic,assign)PasswordState state; //默认 GesturecipherVcStateAuthentication
@end
