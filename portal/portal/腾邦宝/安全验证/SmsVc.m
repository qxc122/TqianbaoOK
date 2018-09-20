//
//  SmsVc.m
//  portal
//
//  Created by Store on 2018/1/25.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "SmsVc.h"
#import "RiskManagementVc.h"
#import "UITextFieldAdd.h"
#import "YYText.h"
@interface SmsVc ()<UITextFieldDelegate>
@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) UILabel *titlee;
@property (nonatomic,weak) UITextFieldAdd *smsIn;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UIButton *btnSms;

//@property (nonatomic,weak) UILabel *des;
@property (nonatomic,weak) YYLabel *des;
@property (nonatomic,weak) UIButton *next;

@property (nonatomic,strong) NSTimer *scrollTimer;
@property (nonatomic,assign) NSInteger num; 
@end


@implementation SmsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1/1.0];
    self.title = @"安全验证";
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
        [self.view addSubview:view];
        self.back = view;
        [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(20);
            make.height.equalTo(@61);
        }];
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"短信验证码";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
        [self.view addSubview:label];
        self.titlee = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.centerY.equalTo(self.back);
            make.width.equalTo(@75);
        }];

    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ColorWithHex(0x979797, 1.0);
        [self.view addSubview:view];
        self.line = view;
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0.5);
            make.right.equalTo(self.view).offset(-99);
            make.top.equalTo(self.back).offset(3);
            make.bottom.equalTo(self.back).offset(-3);
        }];
    }
    {
        UIButton *view = [[UIButton alloc] init];
        [view setWithNormalColor:0x4484FA NormalAlpha:1.0 NormalTitle:@"" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [view setTitle:@"60s" forState:UIControlStateDisabled];
        [view setTitleColor:ColorWithHex(0x1E2E47, 1.0) forState:UIControlStateDisabled];
        [self.view addSubview:view];
        self.btnSms = view;
        [self.btnSms mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.back);
            make.bottom.equalTo(self.back);
            make.left.equalTo(self.line);
            make.right.equalTo(self.back);
        }];
        [self.btnSms addTarget:self action:@selector(sendSmsCodebindId) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UITextFieldAdd *input = [UITextFieldAdd new];
        input.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.smsIn = input;
        self.smsIn.delegate = self;
        [self.view addSubview:input];
        [self.smsIn setWithColor:NORMOL_BLACK Alpha:1.0 Font:15 ROrM:@"r"];
        [self.smsIn setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        input.placeholder = @"请输入验证码";
        [self.smsIn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlee.mas_right).offset(20);
            make.right.equalTo(self.line).offset(-20);
            make.top.equalTo(self.back);
            make.bottom.equalTo(self.back);
        }];
    }
    {
        YYLabel *label = [[YYLabel alloc] init];
//        label.numberOfLines = 0;
//        label.text = [NSString stringWithFormat:@"为了确保账户安全，我们已将验证码发至您的手机号%@，请注意查收！",[[PortalHelper sharedInstance] get_userInfo].bankMobile];
//        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
//        label.textColor = [UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0];
        [self.view addSubview:label];
        self.des = label;
        self.des.hidden = YES;
        [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titlee);
            make.right.equalTo(self.view).offset(-20);
            make.top.equalTo(self.back.mas_bottom).offset(15);
        }];
        
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"正在开通腾邦宝服务，为确保账户安全，已将验证码发至您的手机号%@，请注意查收。点击“下一步”即表示同意",[[PortalHelper sharedInstance] get_userInfo].bankMobile]];
        one.yy_font = PingFangSC_Regular(12);
        one.yy_color = [UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0];;
        one.yy_lineSpacing = 5;
        [text appendAttributedString:one];
        kWeakSelf(self);

        {
            NSMutableAttributedString *Three = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《平安大华快取协议》", @"")];
            Three.yy_font = PingFangSC_Regular(12);
                    Three.yy_lineSpacing = 5;
            Three.yy_underlineStyle = NSUnderlineStyleSingle;
            [Three yy_setTextHighlightRange:Three.yy_rangeOfAll
                                      color:[UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0]
                            backgroundColor:[UIColor clearColor]
                                  tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                          [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].tpurseServiceRechargeAgreementUrl];
                                      NSLog(@"%s",__func__);
                                  }];
            [text appendAttributedString:Three];
        }
        {
            NSMutableAttributedString *Three = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《平安大华客户协议》", @"")];
            Three.yy_font = PingFangSC_Regular(12);
                        Three.yy_lineSpacing = 5;
            Three.yy_underlineStyle = NSUnderlineStyleSingle;
            [Three yy_setTextHighlightRange:Three.yy_rangeOfAll
                                      color:[UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0]
                            backgroundColor:[UIColor clearColor]
                                  tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                          [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].tpurseServiceCustomerAgreementUrl];
                                      NSLog(@"%s",__func__);
                                  }];
            [text appendAttributedString:Three];
        }
        {
            NSMutableAttributedString *Three = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《平安付科技电子支付账户协议》", @"")];
            Three.yy_font = PingFangSC_Regular(12);
                        Three.yy_lineSpacing = 5;
            Three.yy_underlineStyle = NSUnderlineStyleSingle;
            [Three yy_setTextHighlightRange:Three.yy_rangeOfAll
                                      color:[UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0]
                            backgroundColor:[UIColor clearColor]
                                  tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                      [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].fundAcctPayAgreementUrl];
                                      NSLog(@"%s",__func__);
                                  }];
            [text appendAttributedString:Three];
        }
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"。"];
            one.yy_font = PingFangSC_Regular(12);
            one.yy_color = [UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0];;
                    one.yy_lineSpacing = 5;
            [text appendAttributedString:one];
        }
        //        text.yy_lineSpacing = 10;
        label.numberOfLines = 0;  //设置多行显示
        label.preferredMaxLayoutWidth = SCREENWIDTH - 40; //设置最大的宽度
        label.attributedText = text;
    }
    {
        UIButton *view = [[UIButton alloc] init];
        [view setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"下一步" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x4484FA backAlpha:0.0];
//        [view setTitleColor:ColorWithHex(0x1E2E47, 1.0) forState:UIControlStateDisabled];
        [view setImage:[ColorWithHex(0x1E2E47, 1.0) imageWithColor]  forState:UIControlStateNormal];
        [view setBackgroundImage:[ColorWithHex(0x4484FA, 1.0) imageWithColor] forState:UIControlStateNormal];
        [self.view addSubview:view];
        self.next = view;
        [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.bottom.equalTo(self.view).offset(-228);
            make.left.equalTo(self.des);
            make.right.equalTo(self.view).offset(-20);
        }];
        self.next.enabled = NO;
        [self.next addTarget:self action:@selector(checkVerifyCodeWithtype) forControlEvents:UIControlEventTouchUpInside];
    }
    [self sendSmsCodebindId];
}


- (void)sendSmsCodebindId{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:@"发送短信验证吗中..." toView:self.view];
    [[ToolRequest sharedInstance]moneySystemsendVerifyCodeWithmobile:[[PortalHelper sharedInstance] get_userInfo].bankMobile type:@"11" bindId:0 money:0 codeId:nil success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:@"发送成功" toView:weakself.view];
        [weakself creatTimer];
        weakself.des.hidden = NO;
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
        [weakself removeTimer];
    }];
}

- (void)checkVerifyCodeWithtype{
    [MBProgressHUD showLoadingMessage:@"验证码校验中..." toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpTreasuresendVerifyCodeWithverifyCode:self.smsIn.text success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        weakself.isSuccess = YES;
        if (!weakself.isEvaluate) {
            RiskManagementVc *vc = [RiskManagementVc new];
            vc.CTrollersToR = @[[weakself class]];
            vc.url = weakself.url;
            [weakself OPenVc:vc];
        } else {
            [weakself popSelf];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}


#pragma mark----创建定时器
-(void)creatTimer
{
    self.num = 60;
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiRunning) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    self.btnSms.enabled = NO;
    [self.btnSms setTitle:@"60s" forState:UIControlStateDisabled];
}
#pragma mark----倒计时
-(void)daojishiRunning{
    self.num--;
    if (self.num == 0) {
        [self removeTimer];
    }else{
        [self.btnSms setTitle:[NSString stringWithFormat:@"%lds",(long)self.num] forState:UIControlStateDisabled];
    }
}
#pragma mark----移除定时器
-(void)removeTimer
{
    self.btnSms.enabled = YES;
    [self.btnSms setTitle:NSLocalizedString(@"重新获取", @"") forState:UIControlStateNormal];
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

- (void)dealloc{
    [self removeTimer];
}

#define NUMBERS @"0123456789"
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        BOOL tmp = NO;
        NSCharacterSet*cs = [NSCharacterSet decimalDigitCharacterSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        tmp =  ![string isEqualToString:filtered];
        if (tmp) {
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            if ((existedLength - selectedLength + replaceLength) <= 6) {
                tmp = YES;
            }else{
                tmp = NO;
            }
            self.next.enabled = ((existedLength - selectedLength + replaceLength) == 6);
        }
        return tmp;
    }
}
@end
