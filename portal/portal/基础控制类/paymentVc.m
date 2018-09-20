//
//  paymentVc.m
//  portal
//
//  Created by Store on 2017/10/24.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "paymentVc.h"
#import "WithdrawCashVc.h"
#import "ThirdpartypaymentindesignVc.h"
#import "ScansuccessVc.h"
#import "turnOutVc.h"
#import "MaldivesPayVc.h"
@interface paymentVc ()

@end

@implementation paymentVc

- (void)payFailWith:(NSInteger)errorCode :(NSString *)msg{
    if (errorCode == kRespondCodePassworderror) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself PasswordRetrieval];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself retryPay];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (errorCode == kRespondCodePasswordinputmultipleerrors) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"找回密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself PasswordRetrieval];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)PasswordRetrieval{
    
    NSString *title = @"请联系客服找回密码，客服电话";
    NSString *des = @"分机号:";
    if ([[PortalHelper sharedInstance]get_Globaldata].customerServicePhone.length == 18) {
        title = [title stringByAppendingString:[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringToIndex:13]];
        des= [des stringByAppendingString:[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringFromIndex:14]];
        UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:title message:des preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // 点击‘取消’，做点事情
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringToIndex:13]];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }];
        
        [showAlert addAction:action1];
        [showAlert addAction:action2];
        
        [self presentViewController:showAlert animated:YES completion:nil];
    }
}
- (void)retryPay{
    if (self.boxview) {
        [self.boxview firstINput];
    } else {
        [self OpenPasswordpaymentbox];
    }
}


- (void)OpenPasswordpaymentbox{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
    Passwordpaymentbox *view = [Passwordpaymentbox new];
    self.boxview = view;
    kWeakSelf(self);
    view.Fill_in_the_text = ^(NSString *inText) {
//        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
        [weakself Passwordinputsuccessful:inText];
//        [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    };
    view.cannelPay = ^{
        [weakself boxviewcannelPay];
    };
    view.changePassWord = ^{
        [weakself PasswordRetrieval];
    };
    UIView *tmp = self.view;
    [view windosViewshowWithsubView:tmp];
}
- (void)boxviewcannelPay{
    [self cannelPay];
}
- (void)sendSmsCodebindId:(NSInteger )bindId Money:(double)money codeId:(NSString *)codeId{
    if ([self.smsSendOKFlag isEqualToString:@"1"]) {
        self.Verificationbox.hidden = NO;
        if ([self.Verificationbox.codeInput canBecomeFirstResponder]) {
            [self.Verificationbox.codeInput becomeFirstResponder];
        }
        [MBProgressHUD showPrompt:@"验证码已发送!" toView:self.view];
    } else {
        kWeakSelf(self);
        NSString *type;
        if ([self isKindOfClass:[WithdrawCashVc class]]) {
            WithdrawCashVc *tmp = (WithdrawCashVc *)self;
            if (tmp.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
                if (tmp.load_type == WithdrawCashVc_load_type_H5) {
                    type = @"10";
                } else {
                    type = @"03";
                }
            } else {
                type = @"04";
            }
        } else if ([self isKindOfClass:[ScansuccessVc class]]) {
            type = @"05";
        } else if ([self isKindOfClass:[ThirdpartypaymentindesignVc class]]) {
            type = @"06";
        } else if ([self isKindOfClass:[turnOutVc class]]) {
            type = @"13";
        } else if ([self isKindOfClass:[MaldivesPayVc class]]) {
            type = @"16";
        }
        if (self.smsCodetype) {
            type = self.smsCodetype;
        }
        [MBProgressHUD showLoadingMessage:@"发送短信验证吗中..." toView:self.view];
        [[ToolRequest sharedInstance]moneySystemsendVerifyCodeWithmobile:[[PortalHelper sharedInstance] get_userInfo].bankMobile type:type bindId:bindId money:money codeId:codeId success:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.smsSendOKFlag = @"1";
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:@"发送成功" toView:weakself.view];
            if (!weakself.Verificationbox) {
                [weakself OpenVerificationCodeBox];
            }else{
                weakself.Verificationbox.hidden = NO;
                if ([weakself.Verificationbox.codeInput canBecomeFirstResponder]) {
                    [weakself.Verificationbox.codeInput becomeFirstResponder];
                }
            }
            [weakself.Verificationbox creatTimer];
            weakself.Verificationbox.resendSmsCode = ^{
                [weakself sendSmsCodebindId:bindId Money:money codeId:codeId];
            };
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }
}
- (void)OpenVerificationCodeBox{
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
    VerificationCodeBox *view = [VerificationCodeBox new];
    self.Verificationbox = view;
    kWeakSelf(self);
    view.Fill_in_the_text = ^(NSString *inText) {
        weakself.smsCode = inText;
        [weakself checkVerifyCodeWithtype];
    };
    view.cannelPay = ^{
        [weakself cannelPay];
    };
    view.timeOut = ^{
        weakself.smsSendOKFlag = nil;
    };
    UIView *tmp = self.view;
    [view windosViewshowWithsubView:tmp];
}
- (void)checkVerifyCodeWithtype{
    [MBProgressHUD showLoadingMessage:@"验证码校验中..." toView:self.view];
    kWeakSelf(self);
    NSString *type;
    if ([self isKindOfClass:[WithdrawCashVc class]]) {
        WithdrawCashVc *tmp = (WithdrawCashVc *)self;
        if (tmp.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
            if (tmp.load_type == WithdrawCashVc_load_type_H5) {
                type = @"10";
            } else {
                type = @"03";
            }
        } else {
            type = @"04";
        }
    } else if ([self isKindOfClass:[ScansuccessVc class]]) {
        type = @"05";
    } else if ([self isKindOfClass:[ThirdpartypaymentindesignVc class]]) {
        type = @"06";
    } else if ([self isKindOfClass:[turnOutVc class]]) {
        type = @"13";
    } else if ([self isKindOfClass:[MaldivesPayVc class]]) {
        type = @"16";
    }
    [[ToolRequest sharedInstance]URLBASIC_tpursesystemcheckVerifyCodeWithtype:type verifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        weakself.Verificationbox.hidden = YES;
        if (weakself.Verificationbox.codeInput.isFirstResponder) {
            [weakself.Verificationbox.codeInput resignFirstResponder];
        };
        weakself.smsSendOKFlag = nil;
        if ([weakself isKindOfClass:[MaldivesPayVc class]]) {
            [weakself  OpenChangePassWordVc];
        }else{
            [weakself OpenPasswordpaymentbox];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
    
//    [MBProgressHUD hideHUDForView:weakself.view];
//    weakself.Verificationbox.hidden = YES;
//    if (weakself.Verificationbox.codeInput.isFirstResponder) {
//        [weakself.Verificationbox.codeInput resignFirstResponder];
//    };
//    [weakself OpenPasswordpaymentbox];
}
- (void)OpenChangePassWordVc{
    
}
- (void)cannelPay{

        
        kWeakSelf(self);
        
        NSString *title;
        NSString *btnStr;
        if ([self isKindOfClass:[WithdrawCashVc class]]) {
            title = @"温馨提示";
            WithdrawCashVc *tmp = (WithdrawCashVc *)self;
            if (tmp.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
                btnStr = @"继续充值";
            } else {
                btnStr = @"继续提现";
            }
        }else  if ([self isKindOfClass:[ScansuccessVc class]]) {
            title = @"您要放弃转帐吗？";
            btnStr = @"继续";
        } else if ([self isKindOfClass:[ThirdpartypaymentindesignVc class]]) {
            title = @"您要放弃支付吗";
            btnStr = @"继续";
        } else if ([self isKindOfClass:[MaldivesPayVc class]]) {
            if (self.Verificationbox && self.Verificationbox.hidden == NO) {
                self.Verificationbox.hidden = YES;
                [self OpenPasswordpaymentbox];
                [self.boxview.RightBtn setWithNormalColor:0xF7FFC NormalAlpha:0.7 NormalTitle:NSLocalizedString(@"忘记密码?", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
            }else{
                [self.boxview closeClisck];
                self.boxview = nil;
            }
        }
        if (title) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            if (btnStr.length) {
                [alert addAction:[UIAlertAction actionWithTitle:btnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
            }
            [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakself.boxview closeClisck];
                weakself.boxview = nil;
                //        [weakself.Verificationbox closeClisck];
                
                weakself.Verificationbox.hidden = YES;
//                if (weakself.Verificationbox.codeInput.isFirstResponder) {
//                    [weakself.Verificationbox.codeInput resignFirstResponder];
//                }
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
}


- (void)smsCodeinputsuccessful:(NSString *)inText{
    self.smsCode = inText;
    [self.Verificationbox closeClisck];
    [self OpenPasswordpaymentbox];
}

- (void)Passwordinputsuccessful:(NSString *)inText{
    
}

@end
