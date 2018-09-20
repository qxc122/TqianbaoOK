//
//  AuthenticationSmsVc.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AuthenticationSmsVc.h"
#import "ReaNameaddBankCardsmscell.h"
#import "ReaNamebaseFillCell.h"
#import "RealNameHead.h"
#import "GesturecipherVc.h"
#import "addBankCarkFoot.h"
#import "AuthenticationVc.h"
#import "GesturecipherVc.h"
@interface AuthenticationSmsVc ()

@property (nonatomic,weak) RealNameHead *head;
@property (nonatomic,weak) addBankCarkFoot *foot;

@property (nonatomic,strong) NSString *sms;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *phonePre;
@property (nonatomic,strong) NSString *smsCode;
@end

@implementation AuthenticationSmsVc
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
    self.phone = [[PortalHelper sharedInstance]get_userInfo].fullMobile;
    self.fd_prefersNavigationBarHidden = YES;
    self.registerClasss = @[[ReaNameaddBankCardsmscell class],[ReaNamebaseFillCell class]];
    [self setsource];
}

- (void)addHeadAndFoot{
    CGFloat tmp = 130;
    if (IPoneX) {
        tmp += 20;
    }
    RealNameHead *head = [[RealNameHead alloc]initWithFrame:CGRectMake(0, 0, 0, tmp)];
    head.pading= 27;
//    self.head.title.text = NSLocalizedString(@"", @"");
//    
    self.head = head;
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    self.tableView.tableHeaderView = head;

    addBankCarkFoot *foot = [[addBankCarkFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 250)];
    self.foot = foot;
    self.foot.btn.enabled = NO;
    [foot.btn setTitle:@"下一步" forState:UIControlStateNormal];
    foot.doneBtn = ^{
        [weakself URLBASIC_usercheckVerifyCodeWithverifyCodeFucn];
        NSLog(@"%s",__func__);
    };
    self.tableView.tableFooterView = foot;
}

- (void)URLBASIC_usercheckVerifyCodeWithverifyCodeFucn{
    if (!self.phone || !self.phone.length || ![self.phone IsTelNumber]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的手机号", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    if (!self.smsCode || !self.smsCode.length || self.smsCode.length != 6) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入六位验证码", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"验证中", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_usercheckVerifyCodeWithverifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:@"验证成功" toView:weakself.view afterDelay:2.0f];
        [weakself performSelector:@selector(resetGesStr) withObject:nil afterDelay:2.0f];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
    }];
}

- (void)sendVerifyCodeWithmobile:(NSString *)phone{
    self.sms = @"eeee";
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"发送中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]systemsendVerifyCodeWithmobile:self.phone type:SYSTEMSENDVERIFYCODEWITHMOBILETYPE_LOGIN success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        weakself.phonePre = phone;
        weakself.head.title.text = NSLocalizedString(@"手机验证码发送成功", @"");
        [MBProgressHUD showPrompt:NSLocalizedString(@"发送成功", @"") toView:weakself.view afterDelay:weakself.sesPro];
        weakself.sms = @"YES";
        [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSInteger errorCode, NSString *msg) {
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
    vc.Resetafterverification = YES;
    [self OPenVc:vc]; 
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *one = self.Arry_data[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"验证码", @"")]) {
        ReaNameaddBankCardsmscell *cell = [ReaNameaddBankCardsmscell returnCellWith:tableView];
        [self configureaddBankCardsmscell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        ReaNamebaseFillCell *cell = [ReaNamebaseFillCell returnCellWith:tableView];
        [self configurebaseFillCell:cell atIndexPath:indexPath];
        return  cell;
    }
}

#pragma --mark< 配置SignInaddBankCardsmscell 的数据>
- (void)configureaddBankCardsmscell:(addBankCardsmscell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.smsOK = self.sms;
    [self configurebaseFillCell:(baseFillCell *)cell atIndexPath:indexPath];
    kWeakSelf(self);
    cell.doneClick = ^(baseCell_Click_type type) {
        if ([weakself.phone IsTelNumber]) {
            [weakself sendVerifyCodeWithmobile:weakself.phone];
        }else{
            [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的手机号", @"") toView:weakself.view afterDelay:weakself.sesPro];
        }
    };
}

#pragma --mark< 配置SignINbaseFillCell 的数据>
- (void)configurebaseFillCell:(baseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
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
        }
        [weakself setselffootbtnenabled];
    };
    if ([one.describe isEqualToString:NSLocalizedString(@"请输入手机号码", @"")]) {
        cell.input.text = self.phone;
        cell.input.enabled = NO;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请输入验证码", @"")]) {
        cell.input.text = self.smsCode;
        cell.input.enabled = YES;
    }
}
- (void)setselffootbtnenabled{
    if (self.phone && self.smsCode  && self.phone.length && self.smsCode.length) {
        self.foot.btn.enabled = YES;
    }else{
        self.foot.btn.enabled = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self sendVerifyCodeWithmobile:self.phone];
}
- (void)setsource{
    [self.Arry_data removeAllObjects];
    setUpData *tmp1 = [setUpData new];
    tmp1.title = NSLocalizedString(@"手机号", @"");
    tmp1.describe = NSLocalizedString(@"请输入手机号码", @"");
    tmp1.clearButtonMode = UITextFieldViewModeWhileEditing;
    tmp1.keyboardType = UIKeyboardTypeNumberPad;
    tmp1.contentType = UIKeyboardTypeNumberPad;
    tmp1.existedLength = 11;
    [self.Arry_data addObject:tmp1];
    
    
    setUpData *tmp2 = [setUpData new];
    tmp2.title = NSLocalizedString(@"验证码", @"");
    tmp2.describe = NSLocalizedString(@"请输入验证码", @"");
    tmp2.clearButtonMode = UITextFieldViewModeWhileEditing;
    tmp2.keyboardType = UIKeyboardTypeNumberPad;
    tmp2.contentType = UIKeyboardTypeNumberPad;
    tmp2.existedLength = 6;
    [self.Arry_data addObject:tmp2];
}

//
@end
