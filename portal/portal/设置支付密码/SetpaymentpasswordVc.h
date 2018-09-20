//
//  SetpaymentpasswordVc.h
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AuthenticationpasswordVc.h"

@interface SetpaymentpasswordVc : AuthenticationpasswordVc


@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,strong) NSString *phone;

@property (nonatomic,assign) BOOL iLogin; //是否是登录的时候
@end
