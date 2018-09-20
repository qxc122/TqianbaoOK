//
//  applyAuthCodeVc.m
//  portal
//
//  Created by Store on 2017/12/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//




#import "applyAuthCodeVc.h"
#import "UIColor+Add.h"
#import "GesturecipherVc.h"
#import "SignInVc.h"
//TwalletAuth00000001   授权 dataForAuth  
//TwalletPay00000002   支付

@interface applyAuthCodeVc ()
@property (nonatomic,weak) UIView *top;
@property (nonatomic,weak) UILabel *zhanghao;
@property (nonatomic,weak) UIImageView *icon;

@property (nonatomic,weak) UIView *bottom;
@property (nonatomic,weak) UILabel *titlee;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UIImageView *cirey;
@property (nonatomic,weak) UILabel *des;

@property (nonatomic,weak) UIButton *goo;

@property (nonatomic,assign) NSInteger errorCode;
@property (nonatomic,strong) NSString *msg;
@end

@implementation applyAuthCodeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"T钱包授权";
    self.fd_interactivePopDisabled = YES;
    UIView *top = [UIView new];
    [self.view addSubview:top];
    self.top = top;
    
    UILabel *zhanghao = [UILabel new];
    [self.view addSubview:zhanghao];
    self.zhanghao = zhanghao;

    UIView *bottom = [UIView new];
    [self.view addSubview:bottom];
    self.bottom = bottom;
    
    UIImageView *icon = [UIImageView new];
    [self.view addSubview:icon];
    self.icon = icon;
    
    UILabel *titlee = [UILabel new];
    [self.view addSubview:titlee];
    self.titlee = titlee;
    
    UIView *line = [UIView new];
    [self.view addSubview:line];
    self.line = line;
    
    UIImageView *cirey = [UIImageView new];
    [self.view addSubview:cirey];
    self.cirey = cirey;
    
    UILabel *des = [UILabel new];
    [self.view addSubview:des];
    self.des = des;
    
    UIButton *goo = [UIButton new];
    [self.view addSubview:goo];
    self.goo = goo;
    
    [self.top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    [self.zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.top.mas_bottom);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    [self.bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.top.mas_bottom);
        make.height.equalTo(@143);
    }];
    
    [self.titlee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.icon.mas_bottom).offset(20);
        make.height.equalTo(@17);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlee);
        make.right.equalTo(self.titlee);
        make.top.equalTo(self.titlee.mas_bottom).offset(20);
        make.height.equalTo(@0.5);
    }];
    
    [self.cirey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.centerY.equalTo(self.des);
        make.width.equalTo(@6);
        make.height.equalTo(@6);
    }];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.line.mas_bottom).offset(20);
        make.height.equalTo(@14);
    }];
    
    [self.goo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.bottom.mas_bottom).offset(30);
        make.height.equalTo(@50);
    }];
    [self.cirey SetFilletWith:6.0];
    self.cirey.backgroundColor = ColorWithHex(0x9DA4AE, 1.0);
    self.view.backgroundColor = ColorWithHex(0xF0F1F5, 1.0);
    self.top.backgroundColor = ColorWithHex(0x1E2E47, 1.0);
    self.bottom.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
    self.line.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);

    [self.zhanghao setWithColor:0xE3BF7C Alpha:1.0 Font:14 ROrM:@"r"];
    [self.titlee setWithColor:0x1E2E47 Alpha:1.0 Font:16 ROrM:@"m"];
    [self.des setWithColor:0x475468 Alpha:1.0 Font:14 ROrM:@"r"];

    [self.goo setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"确定授权" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:nil backColor:0x0 backAlpha:0];
    [self.goo setBackgroundImage:[ColorWithHex(0x5E7FFF, 1.0) imageWithColor] forState:UIControlStateNormal];
    self.icon.image = [UIImage imageNamed:@"OAlogo"];
    
//    [self.goo SetFilletWith:]
    self.zhanghao.textAlignment = NSTextAlignmentCenter;
    self.zhanghao.text = @"T钱包账号：";
    self.titlee.text = @"您同意将以下信息授权给 T钱包";
    self.des.text = @"获取你的公开信息（昵称，头像等）";
    
    [self.goo addTarget:self action:@selector(gooClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [self setGesturecipherVc];
    }else{
        [MBProgressHUD showPrompt:@"请先登录"];
        [self openLoginView:nil];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        self.zhanghao.text = [NSString stringWithFormat:@"T钱包账号：%@",[[PortalHelper sharedInstance]get_userInfo].userId];
    }
}
- (void)gooClick{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [MBProgressHUD showLoadingMessage:@"申请授权中..." toView:self.view];
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_tpursetpursesystemapplyAuthCodesuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:@"授权成功，即将返回" afterDelay:1.0];
            [weakself performSelector:@selector(success:) withObject:dataDict afterDelay:1.0];
        } failure:^(NSInteger errorCode, NSString *msg) {
            weakself.errorCode = errorCode;
            weakself.msg = msg;
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showError:msg toView:weakself.view];
        }];
    }else{
        [MBProgressHUD showPrompt:@"请先登录"];
        [self openLoginView:nil];
    }
}
- (void)popSelf{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您要放弃授权吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"继续授权" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself gooClick];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (weakself.msg) {
            [weakself returnOAwithauthWithretStatus:@"-1" errorCode:[NSString stringWithFormat:@"%ld",(long)weakself.errorCode] errorMsg:weakself.msg authCode:@""];
        } else {
            [weakself returnOAwithauthWithretStatus:@"-1" errorCode:@"" errorMsg:@"用户取消了授权" authCode:@""];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)success:(NSDictionary *)dic{
    [self returnOAwithauthWithretStatus:@"0" errorCode:@"" errorMsg:@"" authCode:dic[@"authCode"]];
}
- (void)returnOAwithauthWithretStatus:(NSString *)retStatus errorCode:(NSString *)errorCode errorMsg:(NSString *)errorMsg authCode:(NSString *)authCode{
    NSString *tmp = [NSString stringWithFormat:@"TwalletAuth00000001://%@/a%@/b%@/c%@/d",retStatus,errorCode,authCode,errorMsg];
    NSString *urlStringUTF8 = [tmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStringUTF8]];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)setGesturecipherVc{
    if ([[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1] || [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].GestureCipherStr) {
        
        CGFloat tmp = 5.0*60;
        if ([[PortalHelper sharedInstance]get_userInfo] && [[PortalHelper sharedInstance]get_setupdatePre] && [[NSDate date]secondsLaterThan:[[PortalHelper sharedInstance]get_setupdatePre].datePre] >=tmp) {
            if ( [[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1]) {
                
                SignInVc *losgin = [[SignInVc alloc]init];
                losgin.isUnlock = YES;
                [self.navigationController pushViewController:losgin animated:NO];
                kWeakSelf(self);
                [[PortalHelper sharedInstance] evaluateAuthenticateWith:^{
                    [weakself.navigationController popToViewController:weakself animated:YES];
                } With:^{
                    [MBProgressHUD showPrompt:@"请使用手机号登录"];
                }];
            }else if ( [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].GestureCipherStr) {
                GesturecipherVc *vc = self.navigationController.topViewController;
                if (![vc isKindOfClass:[GesturecipherVc class]] || vc.state != GestureResultPassword) {
                    GesturecipherVc *vc = [GesturecipherVc new];
                    vc.state = GestureResultPassword;
                    [self.navigationController pushViewController:vc animated:NO];
                }
            } else {
                if ([[PortalHelper sharedInstance] get_userInfo]) {
                    [[PortalHelper sharedInstance]set_userInfo:nil];
                    [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
                }
                SignInVc *losgin = [[SignInVc alloc]init];
                losgin.isUnlock = YES;
                [self.navigationController pushViewController:losgin animated:NO];
            }
        }
    }
}
@end
