//
//  SetpaymentpasswordVc.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SetpaymentpasswordVc.h"
#import "GesturecipherVc.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AuthenticationSmsVc.h"
#import "RealNameVc.h"
@interface SetpaymentpasswordVc ()
@property (nonatomic,strong) NSString *passWord;
@property (nonatomic,weak) UILabel *error;
@end

@implementation SetpaymentpasswordVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iLogin = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *error = [[UILabel alloc]init];
    self.error = error;
    [self.view addSubview:error];
    [error mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordBox);
        make.right.equalTo(self.passwordBox);
        make.top.equalTo(self.head.mas_bottom).offset(18);
    }];
    
    self.head.title.text = NSLocalizedString(@"请设置6位数平台支付密码", @"");
    self.des.text = NSLocalizedString(@"温馨提示：此支付密码与理财交易时用到的交易密码为不同的两个密码，请注意区分。", @"");

    
//
    [self.des mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Next);
        make.right.equalTo(self.Next);
        make.top.equalTo(self.passwordBox.mas_bottom).offset(78);
    }];
    self.Next.hidden = YES;
    self.ForgotPassword.hidden = YES;
    
    error.numberOfLines = 0;
    [error setWithColor:0xF4333C Alpha:1.0 Font:14 ROrM:@"r"];
    error.text = NSLocalizedString(@"您两次输入的密码不一致，请重新设置", @"");
    self.error.hidden = YES;
    
    kWeakSelf(self);
    self.passwordBox.Fill_in_the_text = ^(NSString *inText) {
        if (weakself.passWord) {
            if ([weakself.passWord isEqualToString:inText]) {
                if ([weakself.passwordBox.textField canResignFirstResponder]) {
                    [weakself.passwordBox.textField resignFirstResponder];
                }
                [weakself setpayPassword];
                weakself.error.hidden = YES;
            }else{
                [weakself.passwordBox clearUpPassword];
                weakself.error.hidden = NO;
            }
        }else{
            weakself.head.title.text = NSLocalizedString(@"请再次确认平台支付密码", @"");
            weakself.des.text = NSLocalizedString(@"支付密码是您投资、提现等交易操作的重要凭证，请妥善保管。", @"");
            weakself.passWord = inText;
            [weakself.passwordBox clearUpPassword];
        }
    };
}

- (void)setpayPassword{
    if ([[PortalHelper sharedInstance] get_accessToken].sessionKey.length >=16 && [[PortalHelper sharedInstance] get_accessToken].sessionSecret.length >=24) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:self.passWord key:key iv:iv];
        
        
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"设置中", @"") toView:self.view];
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_useraddPayPasswordWithpayPassword:passDes success:^(id dataDict, NSString *msg, NSInteger code) {
            [[PortalHelper sharedInstance] set_userInfo:weakself.userInfo];
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:NSLocalizedString(@"设置成功", @"") toView:weakself.view afterDelay:2.0f];
            weakself.passwordBox.textField.userInteractionEnabled = NO;
            UserInfoDeatil *tmp = [[PortalHelper sharedInstance]get_userInfoDeatil];
            UserInfo *tmp2 = [[PortalHelper sharedInstance]get_userInfo];
            tmp.payPasswordFlag = STRING_1;
            tmp2.payPasswordFlag = YES;
            
            weakself.isSuccess = YES;
            [[PortalHelper sharedInstance]set_userInfoDeatil:tmp];
            [[PortalHelper sharedInstance]set_userInfo:tmp2];
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    EMError *error = [[EMClient sharedClient] loginWithUsername:[[PortalHelper sharedInstance]get_userInfo].easemobId password:@"111111"];
                    NSLog(@"sdf");
                });
            }
            
            if (!weakself.threePay) {
                NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:2.0f];
//            if (weakself.iLogin) {
//                if (![[[PortalHelper sharedInstance]get_setUpAlldata].Arry_allPhone containsObject:weakself.phone] && ![[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1]){
//                    [weakself kaiqi];
//                }else{
//                    [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:2.0f];
//                }
//            }else{
//                [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:2.0f];
//            }
            
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
        }];
    }else{
        [MBProgressHUD showPrompt:NSLocalizedString(@"SetpaymentpasswordVcsessionKey或者sessionSecret长度有误", @"") toView:self.view afterDelay:self.sesPro];
    }
}

- (void)TOuchIdSetAlert{
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    context.localizedFallbackTitle = @"";
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否开启指纹解锁登录功能？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself TouchIdSet];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"不,谢谢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             [weakself SetgestureFlagAlert];
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    } else {
        [self SetgestureFlagAlert];
    }
}
- (void)TouchIdSet{
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = nil;
    kWeakSelf(self);
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"Home键验证已有手机指纹", nil) reply:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"验证通过");
            [weakself SetgestureFlagAlert];
        } else {
            switch (error.code) {
                case LAErrorUserCancel: //认证被用户取消.例如点击了 cancel 按钮.
                    NSLog(@"密码取消");
                    break;
                case LAErrorAuthenticationFailed: // 此处会自动消失，然后下一次弹出的时候，又需要验证数字 // 认证没有成功,因为用户没有成功的提供一个有效的认证资格
                    NSLog(@"连输三次后，密码失败");
                    break;
                case LAErrorPasscodeNotSet: // 认证不能开始,因为此台设备没有设置密码.
                    NSLog(@"密码没有设置");
                    break;
                case LAErrorSystemCancel: //认证被系统取消了(例如其他的应用程序到前台了)
                    NSLog(@"系统取消了验证");
                    break;
                case LAErrorUserFallback: //当输入觉的会有问题的时候输入
                    NSLog(@"登陆");
                    break;
                case LAErrorTouchIDNotAvailable: //认证不能开始,因为 touch id 在此台设备尚是无效的.
                    NSLog(@"touch ID 无效");
                default:
                    NSLog(@"您不能访问私有内容");
                    break;
            } }
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([[[PortalHelper sharedInstance]get_userInfoDeatil].realFlag isEqualToString:STRING_0]) {
        [self Quitwithoutnotice];
    }
}
- (void)popSelf{
    if ([self isKindOfClass:[AuthenticationSmsVc class]]) {
        if ([[PortalHelper sharedInstance]get_setUpWith:self.userInfo.fullMobile].GestureCipherStr && [[PortalHelper sharedInstance]get_setUpWith:self.userInfo.fullMobile].GestureCipherStr.length) {
            if (self.isUnlock) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [super popSelf];
            }
        } else {
            GesturecipherVc *vc = [GesturecipherVc new];
            vc.CTrollersToR = @[[self class]];
            vc.state = GestureSetPassword;
            vc.isUnlock = self.isUnlock;
            [self OPenVc:vc];
        }
    }else{
        [super popSelf];
    }
}
- (void)SetgestureFlagAlert{
    if (![[PortalHelper sharedInstance]get_userInfo].gestureFlag) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否开启手势密码登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            GesturecipherVc *vc = [GesturecipherVc new];
            vc.state = GestureSetPassword;
            vc.CTrollersToR = @[[self class]];
            [weakself OPenVc:vc]; 
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"不,谢谢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakself popSelf];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (UserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[PortalHelper sharedInstance]get_userInfo];
    }
    return _userInfo;
}
@end
