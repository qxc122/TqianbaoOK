//
//  AuthenticationpasswordVc.h
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"
#import "RealNameHead.h"
#import "SYPasswordView.h"
#import "Cryptor.h"


typedef enum {
    AuthenticationpasswordVc_type_UNLock,
    AuthenticationpasswordVc_type_Reset,
} AuthenticationpasswordVc_type;


@interface AuthenticationpasswordVc : basicUiTableView
@property (nonatomic,weak) RealNameHead *head;
@property (nonatomic,weak) SYPasswordView *passwordBox;

@property (nonatomic,weak) UIButton *ForgotPassword;
@property (nonatomic,weak) UIButton *Next;
@property (nonatomic,weak) UILabel *des;

@property (nonatomic,assign) AuthenticationpasswordVc_type type; //默认 是AuthenticationpasswordVc_type_UNLock

@end
