//
//  AuthenticationpasswordVc.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AuthenticationpasswordVc.h"
#import "GesturecipherVc.h"
#import "AuthenticationVc.h"
#import "GesturecipherVc.h"
#import "SetpaymentpasswordVc.h"
@interface AuthenticationpasswordVc ()
@property (nonatomic,strong) NSString *passWord;
@end

@implementation AuthenticationpasswordVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = AuthenticationpasswordVc_type_UNLock;
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self SetUI];
    self.header.hidden = YES;
}
- (void)SetUI{
    CGFloat tmp = 130;
    if (IPoneX) {
        tmp += 20;
    }
    RealNameHead *head = [[RealNameHead alloc]init];
    head.pading= 27;
    head.title.text = NSLocalizedString(@"请验证平台支付密码", @"");
    self.head = head;
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    [self.view addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@(tmp));
    }];

    SYPasswordView *passwordBox = [[SYPasswordView alloc]initWithFrame:CGRectMake(33, tmp+50, SCREENWIDTH-33-33 , 60)];
    self.passwordBox = passwordBox;
    [self.view addSubview:passwordBox];
    self.passwordBox.Fill_in_the_text = ^(NSString *inText) {
        if ([weakself.passwordBox.textField canResignFirstResponder]) {
            [weakself.passwordBox.textField resignFirstResponder];
        }
        weakself.passWord = inText;
        weakself.Next.enabled = YES;
        [weakself NextClick];
    };
    self.passwordBox.Fill_In_input = ^(NSString *inText) {
        if (inText.length >= 6) {
            weakself.Next.enabled = YES;
        } else {
            weakself.Next.enabled = NO;
        }
    };
    
    UIButton *ForgotPassword = [[UIButton alloc]init];
    self.ForgotPassword = ForgotPassword;
    [self.view addSubview:ForgotPassword];
    [ForgotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordBox);
        make.top.equalTo(self.passwordBox.mas_bottom);
        make.height.equalTo(@(46));
        make.width.equalTo(@(100));
    }];
//    self.ForgotPassword.hidden = YES;
    
    UIButton *Next = [[UIButton alloc]init];
    self.Next = Next;
    self.Next.enabled = NO;
    [self.view addSubview:Next];
    [Next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(self.ForgotPassword.mas_bottom).offset(32);
        make.height.equalTo(@(50));
    }];
    
    UILabel *des = [[UILabel alloc]init];
    self.des = des;
    [self.view addSubview:des];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Next);
        make.right.equalTo(self.Next);
        make.top.equalTo(self.ForgotPassword.mas_bottom).offset(15);
    }];
    
    [ForgotPassword setWithNormalColor:0x9DA4AE NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"忘记密码？", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [ForgotPassword addTarget:self action:@selector(ForgotPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    
    [Next setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"下一步", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [Next addTarget:self action:@selector(NextClick) forControlEvents:UIControlEventTouchUpInside];
    Next.hidden = YES;
    [Next setBackgroundImage:[ColorWithHex(0x1E2E47, 1.0) imageWithColor] forState:UIControlStateNormal];
    [Next setBackgroundImage:[ColorWithHex(0xE9EBEE, 1.0) imageWithColor] forState:UIControlStateDisabled];
    Next.enabled = NO;
    des.numberOfLines = 0;
    [des setWithColor:0x9DA4AE Alpha:1.0 Font:12 ROrM:@"r"];
    des.text = @"温馨提示：此支付密码与理财交易时用到的交易密码为不同的两个密码，请注意区分。";
}
- (void)ForgotPasswordClick{
    NSLog(@"%s",__FUNCTION__);
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.passwordBox.textField canBecomeFirstResponder]) {
        [self.passwordBox.textField becomeFirstResponder];
    }
}
- (void)NextClick{
    if (!self.passWord || self.passWord.length!=6) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确密码", @"") toView:self.view afterDelay:self.sesPro];
        [self.passwordBox clearUpPassword];
        if ([self.passwordBox.textField canBecomeFirstResponder]) {
            [self.passwordBox.textField becomeFirstResponder];
        }
        return;
    }

    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"验证中", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_usercheckPayPasswordWithpayPassword:self.passWord success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:@"验证成功" toView:weakself.view afterDelay:2.0f];
        [weakself performSelector:@selector(resetGesStr) withObject:nil afterDelay:2.0f];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [self.passwordBox clearUpPassword];
        if ([self.passwordBox.textField canBecomeFirstResponder]) {
            [self.passwordBox.textField becomeFirstResponder];
        }
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
    }];
}

#pragma --mark< 重设手势密码 >
- (void)resetGesStr{
    setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
    setUp_dataBlock.GestureCipherStr = nil;
    [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
    
    GesturecipherVc *vc = [GesturecipherVc new];
    vc.CTrollersToR = @[[self class],[AuthenticationVc class],[GesturecipherVc class]];
    vc.state = GestureSetPassword;
    if (self.type == AuthenticationpasswordVc_type_Reset) {
    } else {
        vc.Resetafterverification = YES;
    }
    [self OPenVc:vc]; 
}
@end
