//
//  SignInVc.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SignInVc.h"
#import "SignINbaseFillCell.h"
#import "SignInaddBankCardsmscell.h"
#import "RealNameHead.h"
#import "SignInFoot.h"
#import "SetpaymentpasswordVc.h"
#import "SignPicCell.h"
#import "GesturecipherVc.h"
#import "RealNameVc.h"

@interface SignInVc ()

@property (nonatomic,strong) UserInfo *userInfo;

@property (nonatomic,weak) RealNameHead *head;
@property (nonatomic,weak) SignInFoot *foot;
@property (nonatomic,strong) graphicVerifyCodeUrlInfo *graphicVerifyCodeUrlInfoinfo;


@property (nonatomic,assign) NSInteger errorNum;

@property (nonatomic,strong) NSString *sms;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *phonePre;
@property (nonatomic,strong) NSString *smsCode;
@property (nonatomic,strong) NSString *PicCode;
@end

#define errorNumAll   3

@implementation SignInVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.errorNum = 0;
    self.fd_prefersNavigationBarHidden = YES;
    self.registerClasss = @[[SignINbaseFillCell class],[SignInaddBankCardsmscell class],[SignPicCell class]];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    
    [self addHeadAndFoot];
//
//    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
//        [self setWchat];
//    }
}
- (void)setWchat{
    UILabel *title = [UILabel new];
    [self.view addSubview:title];
    
    UIView *left = [UIView new];
    [self.view addSubview:left];
    
    UIView *right = [UIView new];
    [self.view addSubview:right];
    
    UIButton *btnWx = [UIButton new];
    [self.view addSubview:btnWx];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(btnWx.mas_top).offset(-20);
    }];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(title.mas_left).offset(-20);
        make.height.equalTo(@0.5);
        make.centerY.equalTo(title);
    }];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).offset(20);
        make.right.equalTo(self.view).offset(-30);
        make.height.equalTo(@0.5);
        make.centerY.equalTo(title);
    }];
    [btnWx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view).offset(-30);
    }];
    [btnWx setImage:[UIImage imageNamed:@"验证码登录（其它方式登录）"] forState:UIControlStateNormal];
//    [btnWx addTarget:self action:@selector(btnWxClick) forControlEvents:UIControlEventTouchUpInside];
    left.backgroundColor  =ColorWithHex(0xE9ebee, 1.0);
    right.backgroundColor  =ColorWithHex(0xE9ebee, 1.0);
    [title setWithColor:0x9da4a1 Alpha:1.0 Font:12 ROrM:@"r"];
    title.text = @"其他方式登录";
    
}
//- (void)btnWxClick{
//    NSLog(@"sdf");
//    [self getUserInfoWithPlatform:UMSocialPlatformType_WechatSession];
//}



//[[WalletManager defaultManager] getUserInfocompletion:^(id result, NSError *error) {
//    if(error){
//        //失败的原因
//    }else{
//        //成功，result为一个字典对象，里面包含可提供的一些字段信息，比如用户昵称，可自行打印查看
//    }
//    //OR
////    if(result[@"retStatus"] == 0){
////        //成功，result为一个字典对象，里面包含可提供的一些字段信息，比如用户昵称，可自行打印查看
////    }else{
////        NSString *errorCode = result[@"errorCode"];//错误代码
////        NSString *errorMsg = result[@"errorMsg"];//错误信息
////    }
//}];


//[[WalletManager defaultManager] WalletPayWithSysId:(NSString *)sysId Sign:(NSString *)sign Timestamp:(NSString *)timestamp V:(NSString *)v OrderId:(NSString *)orderId  completion:^(id result, NSError *error) {
//    if(error){
//        //失败的原因
//    }else{
//        //成功，result为一个字典对象，里面包含可提供的一些字段信息
//    }
//    //OR
//    //    if(result[@"retStatus"] == 0){
//    //        //成功，result为一个字典对象，里面包含可提供的一些字段信息
//    //    }else{
//    //        NSString *errorCode = result[@"errorCode"];//错误代码
//    //        NSString *errorMsg = result[@"errorMsg"];//错误信息
//    //    }
//}];



#pragma --mark<友盟登陆>
//- (void)getUserInfoWithPlatform:(UMSocialPlatformType)platformType{
//    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Landing...", @"Landing...") toView:self.view];
//    kWeakSelf(self);
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
//
//        UMSocialUserInfoResponse *resp = result;
//        if (resp) {
//            // 第三方登录数据(为空表示平台未提供)
//            // 授权数据
//            NSLog(@" uid: %@", resp.uid);
//            NSLog(@" openid: %@", resp.openid);
//            NSLog(@" accessToken: %@", resp.accessToken);
//            NSLog(@" refreshToken: %@", resp.refreshToken);
//            NSLog(@" expiration: %@", resp.expiration);
//
//            // 用户数据
//            NSLog(@" name: %@", resp.name);
//            NSLog(@" iconurl: %@", resp.iconurl);
//            NSLog(@" gender: %@", resp.gender);
//
//            // 第三方平台SDK原始数据
//            NSLog(@" originalResponse: %@", resp.originalResponse);
//
//            NSString *chlType;
//            if (platformType == UMSocialPlatformType_WechatSession){
//                chlType = @"WECHAT";
//            } else if (platformType == UMSocialPlatformType_QQ){
//                chlType = @"QQ";
//            }
            //            NSString *gender = NSLocalizedString(@"female", @"female");
            //            if ([resp.gender isEqualToString:@"m"]){
            //                gender = NSLocalizedString(@"male", @"male");
            //            } else if ([resp.gender isEqualToString:@"f"]){
            //                gender = NSLocalizedString(@"female", @"female");
            //            }
            
//            [[ToolRequest sharedInstance]userthirdUserLoginWithchlType:chlType nickname:resp.name province:nil city:nil gender:resp.unionGender avatar:resp.iconurl country:nil openId:resp.openid unionid:resp.uid ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
    
//                UserInfo *BindPre = [UserInfo mj_objectWithKeyValues:dataDict];
//                if ([BindPre.bindFlag isEqualToString:STRING_0]) {
//                    weakself.unionid = resp.uid;
//                    weakself.ThirdBack.hidden = YES;
//                    weakself.sms.text = nil;
//                    weakself.phone.text = nil;
//                    [weakself removeTimer];
//                    [weakself.login setTitle:NSLocalizedString(@"Bind immediately", @"Bind immediately") forState:UIControlStateNormal];
//                    weakself.IsLogin = NO;
//                    weakself.titlee.text =NSLocalizedString(@"Bind mobile phone number",@"Bind mobile phone number");
//                    if (!weakself.IsLogin && [weakself.phone canBecomeFirstResponder]) {
//                        [weakself.phone becomeFirstResponder];
//                    }
//                    [MBProgressHUD hideHUDForView:weakself.view];
//                    [MBProgressHUD showPrompt:NSLocalizedString(@"You have not bound your cell phone number. Please bind your cell phone number first", @"You have not bound your cell phone number. Please bind your cell phone number first")];
//                } else {
//                    [PortalHelper sharedInstance].userInfo= BindPre;
//                    if (weakself.Successblock) {
//                        weakself.Successblock();
//                    }
//                    if (weakself.blockWithStaue) {
//                        weakself.blockWithStaue(@"0");
//                    }
//                    [MBProgressHUD hideHUDForView:weakself.view];
//                    [MBProgressHUD showPrompt:NSLocalizedString(@"Login successful", @"Login successful")];
//                    [weakself.navigationController popViewControllerAnimated:YES];
//                }
//#ifdef DEBUG
//                NSString *strTmp = [dataDict DicToJsonstr];
//                NSLog(@"strTmp=%@",strTmp);
//#endif
//            } failure:^(NSInteger errorCode, NSString *msg) {
//                [MBProgressHUD hideHUDForView:weakself.view];
//                [MBProgressHUD showPrompt:msg toView:weakself.view];
//            }];
//        } else {
//            [MBProgressHUD hideHUDForView:weakself.view];
//            [MBProgressHUD showPrompt:NSLocalizedString(@"Landing failure", @"Landing failure") toView:weakself.view];
//        }
//    }];
//}

- (void)addHeadAndFoot{
    CGFloat tmp = 134;
    if (IPoneX) {
        tmp += 20;
    }
    RealNameHead *head = [[RealNameHead alloc]initWithFrame:CGRectMake(0, 0, 0, tmp)];
    head.pading= 39;
    head.title.text = NSLocalizedString(@"登录", @"");
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    self.tableView.tableHeaderView = head;
    
    SignInFoot *foot = [[SignInFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+42+60)];
    foot.doneBtn = ^{
        [weakself userlogin];
        NSLog(@"%s",__func__);
    };
    foot.openWkWebVc = ^(id url) {
        [weakself Openprotocollist];
    };
    foot.ReSendBtn = ^{
        [weakself resengPicIsBtn:YES];
    };
    [self.foot.btn setTitle:NSLocalizedString(@"登录", @"") forState:UIControlStateNormal];
    self.tableView.tableFooterView = foot;
    self.foot = foot;
    self.foot.error.hidden = YES;
    self.foot.reSend.hidden = YES;
    self.head = head;
    self.foot.btn.enabled = NO;
}

- (void)Openprotocollist{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    kWeakSelf(self);
    [alert addAction:[UIAlertAction actionWithTitle:@"T钱包服务协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].tpurseServicetAgreementUrl];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"腾邦创投服务协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].vcServiceAgreementUrl];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"腾邦创投隐私协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].vcPrivacyAgreementUrl];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    return;
}


#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *one = self.Arry_data[indexPath.row];
    if ([one.describe isEqualToString:NSLocalizedString(@"请输入手机号码", @"")]) {
        SignINbaseFillCell *cell = [SignINbaseFillCell returnCellWith:tableView];
        [self configureSignINbaseFillCell:cell atIndexPath:indexPath];
        return  cell;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请输入验证码", @"")]) {
        SignInaddBankCardsmscell *cell = [SignInaddBankCardsmscell returnCellWith:tableView];
        [self configureSignInaddBankCardsmscell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        SignPicCell *cell = [SignPicCell returnCellWith:tableView];
        [self configureSignPicCell:cell atIndexPath:indexPath];
        return  cell;
    }
}
#pragma --mark< 配置SignInaddBankCardsmscell 的数据>
- (void)configureSignInaddBankCardsmscell:(SignInaddBankCardsmscell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.smsOK = self.sms;
    [self configureSignINbaseFillCell:(SignINbaseFillCell *)cell atIndexPath:indexPath];
    kWeakSelf(self);
    cell.doneClick = ^(baseCell_Click_type type) {
        if ([weakself.phone IsTelNumber]) {
            [weakself sendVerifyCodeWithmobile:weakself.phone];
        }else{
            [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的手机号", @"") toView:weakself.view afterDelay:weakself.sesPro];
        }
    };
}

- (void)userlogin{
    if (!self.phone || !self.phone.length || ![self.phone IsTelNumber]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的手机号", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    if (!self.smsCode || !self.smsCode.length || self.smsCode.length != 6) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入六位验证码", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    if (self.errorNum >=errorNumAll && (!self.PicCode || !self.PicCode.length || self.PicCode.length != 4)) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的图形验证码", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }

    
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"登录中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]userloginWithmobile:self.phone verifyCode:self.smsCode graphicVerifyCode:self.PicCode success:^(id dataDict, NSString *msg, NSInteger code) {
        [[PortalHelper sharedInstance] set_bankListdata:nil];
        [[PortalHelper sharedInstance] set_userInfoDeatil:nil];
        UserInfo *userInfo =[UserInfo mj_objectWithKeyValues:dataDict];
        userInfo.fullMobile = weakself.phone;
        weakself.userInfo = userInfo;
        
        weakself.isSuccess = YES;
        NSLog(@"strTmp=%@",userInfo.bankMobile);
        NSLog(@"strTmp=%@",userInfo.bankMobile);
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        


        if (!userInfo.payPasswordFlag) {
            SetpaymentpasswordVc *vc = [SetpaymentpasswordVc new];
            vc.WillOpenVcs = self.WillOpenVcs;
            vc.CTrollersToR = @[[weakself class]];
            vc.phone = weakself.phone;
            vc.userInfo = userInfo;
            vc.isUnlock = weakself.isUnlock;
            vc.threePay = weakself.threePay;
            [weakself OPenVc:vc];
        }else{
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    EMError *error = [[EMClient sharedClient] loginWithUsername:[[PortalHelper sharedInstance]get_userInfo].easemobId password:@"111111"];
                    NSLog(@"sdf");
                });
            }
            [[PortalHelper sharedInstance] set_userInfo:weakself.userInfo];
            if (!weakself.threePay) {
                NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            if (![[[PortalHelper sharedInstance]get_setUpAlldata].Arry_allPhone containsObject:weakself.phone] && ![[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1]){
//                [weakself kaiqi];
                [MBProgressHUD showPrompt:NSLocalizedString(@"登录成功", @"")];
                [weakself popSelf];
            }else{
                if (weakself.threePay && ![[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:STRING_1]){
                    [MBProgressHUD showPrompt:@"请先实名认证"];
                    RealNameVc *vc = [RealNameVc new];
                    vc.CTrollersToR = @[[weakself class]];
                    [weakself OPenVc:vc];
                }else{
                    [MBProgressHUD showPrompt:NSLocalizedString(@"登录成功", @"")];
                    [weakself popSelf];
                }
            }
        }
//#ifndef DEBUG
        setUpAll *tmp = [[PortalHelper sharedInstance]get_setUpAlldata];
        [tmp.Arry_allPhone addObject:userInfo.fullMobile];
        [[PortalHelper sharedInstance]set_setUpAlldata:tmp];
        if (weakself.block) {
            weakself.block();
        }
//#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
        if (errorCode == KRespondCodeVerificationcodeerror) {
            weakself.errorNum ++;
            if (weakself.errorNum >= errorNumAll && weakself.Arry_data.count < 3) {

                [weakself resengPicIsBtn:NO];
                setUpData *tmp3 = [setUpData new];
                tmp3.describe = NSLocalizedString(@"请输入图形验证码", @"");
                tmp3.clearButtonMode = UITextFieldViewModeWhileEditing;
//                tmp3.keyboardType = UIKeyboardTypeNumberPad;
                tmp3.contentType = baseFillCellType_NumbersAndletters;
                tmp3.existedLength = 4;
                [weakself.Arry_data addObject:tmp3];
                weakself.foot.btn.enabled = NO;
                
                [weakself.tableView beginUpdates];
                [weakself.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakself.Arry_data.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                [weakself.tableView endUpdates];
                weakself.foot.reSend.hidden = NO;
            }
        }
    }];
}
- (void)resengPicIsBtn:(BOOL)IsBtn{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"发送中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]tpursesystemgetGraphicVerifyCodesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        weakself.graphicVerifyCodeUrlInfoinfo =[graphicVerifyCodeUrlInfo mj_objectWithKeyValues:dataDict];
        [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakself.Arry_data.count-1 inSection:0]] withRowAnimation:IsBtn?UITableViewRowAnimationNone:UITableViewRowAnimationNone];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
    }];
}
- (void)sendVerifyCodeWithmobile:(NSString *)phone{
    self.sms = @"eeee";
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"发送中0000");
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"发送中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]systemsendVerifyCodeWithmobile:self.phone type:SYSTEMSENDVERIFYCODEWITHMOBILETYPE_LOGIN success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        weakself.phonePre = phone;
        [MBProgressHUD showPrompt:NSLocalizedString(@"发送成功", @"") toView:weakself.view afterDelay:weakself.sesPro];
        weakself.sms = @"YES";
        [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
    }];
}


#pragma --mark< 配置SignPicCell 的数据>
- (void)configureSignPicCell:(SignPicCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self configureSignINbaseFillCell:(SignINbaseFillCell *)cell atIndexPath:indexPath];
    cell.graphicVerifyCodeUrlInfoinfo = self.graphicVerifyCodeUrlInfoinfo;
}

#pragma --mark< 配置SignINbaseFillCell 的数据>
- (void)configureSignINbaseFillCell:(SignINbaseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.Arry_data[indexPath.row];

    cell.inputInfo = one;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText,UITextField *intput) {
        if ([identifer isEqualToString:NSLocalizedString(@"请输入手机号码", @"")]) {
            weakself.phone = inText;
            if ([inText IsTelNumber] && ![weakself.phonePre isEqualToString:weakself.phone]) {
                [weakself sendVerifyCodeWithmobile:weakself.phone];
            }
        }else if ([identifer isEqualToString:NSLocalizedString(@"请输入验证码", @"")]) {
            weakself.smsCode = inText;
        } else {
            weakself.PicCode = inText;
        }
        [weakself setselffootbtnenabled];
    };
    if ([one.describe isEqualToString:NSLocalizedString(@"请输入手机号码", @"")]) {
        cell.input.text = self.phone;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请输入验证码", @"")]) {
        cell.input.text = self.smsCode;
    } else {
        cell.input.text = self.PicCode;
    }
}

- (void)popSelf{
    if (self.isUnlock) {
        if (!self.userInfo) {
            [self setLoginOut];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [super popSelf];
    }
}
- (void)setselffootbtnenabled{
    if (self.phone && self.smsCode  && self.phone.length && self.smsCode.length && (self.errorNum < errorNumAll || (self.errorNum >=errorNumAll && self.PicCode && self.PicCode.length))) {
        self.foot.btn.enabled = YES;
    }else{
        self.foot.btn.enabled = NO;
    }
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        
        setUpData *tmp1 = [setUpData new];
        tmp1.describe = NSLocalizedString(@"请输入手机号码", @"");
        tmp1.clearButtonMode = UITextFieldViewModeWhileEditing;
        tmp1.keyboardType = UIKeyboardTypeNumberPad;
        tmp1.contentType = UIKeyboardTypeNumberPad;
        tmp1.existedLength = 11;
        [_Arry_data addObject:tmp1];

        
        setUpData *tmp2 = [setUpData new];
        tmp2.describe = NSLocalizedString(@"请输入验证码", @"");
        tmp2.clearButtonMode = UITextFieldViewModeWhileEditing;
        tmp2.keyboardType = UIKeyboardTypeNumberPad;
        tmp2.contentType = UIKeyboardTypeNumberPad;
        tmp2.existedLength = 6;
        [_Arry_data addObject:tmp2];
    }
    return _Arry_data;
}





@end
