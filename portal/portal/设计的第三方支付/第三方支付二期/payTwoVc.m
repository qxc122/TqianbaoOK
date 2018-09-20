//
//  payTwoVc.m
//  portal
//
//  Created by MiNi on 2018/5/10.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "payTwoVc.h"
#import "ConfirmThePayment.h"
#import "payTypeSeleTicon.h"
#import "paySussessTicon.h"
@interface payTwoVc ()
@property (nonatomic,assign) BOOL shoWtype;
@property (nonatomic,weak) UIImageView *head;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) ConfirmThePayment *ConfirmThePaymentview;

@property (nonatomic,strong) NSString *payMethod;

@property (nonatomic,strong) UIAlertController *alert;
@end

@implementation payTwoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = YES;
    self.payMethod = @"BAL";//@"BANK":     @"BAL"
//    [self paySucces:nil];
}
- (void)boxviewcannelPay{
    [self.boxview closeClisck];
    self.boxview = nil;
    self.Verificationbox.hidden = YES;
}
- (void)loadNewDatafail{
    self.head.hidden = YES;
    self.name.hidden = YES;
}
- (void)loadNewDataOK{
    if (self.head && self.name) {
        self.head.hidden = NO;
        self.name.hidden = NO;
    } else {
        self.view.backgroundColor = ColorWithHex(0x1E2E46, 1.0);
        UIImageView *head = [UIImageView new];
        self.head = head;
        head.layer.cornerRadius = 40.0;
        head.layer.masksToBounds = YES;
        head.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:head];
        [head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(114);
            make.height.equalTo(@80);
            make.width.equalTo(@80);
            make.centerX.equalTo(self.view);
        }];
        
        UILabel *name = [UILabel new];
        self.name = name;
        name.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        name.textColor = ColorWithHex(0xEEC783, 1.0);
        [self.view addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(head.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
        }];
    }

    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [self.head sd_setImageWithURL:[PortalHelper sharedInstance].get_userInfo.headUrl placeholderImage:[UIImage imageNamed:@"头像"]];
        self.name.text = [PortalHelper sharedInstance].get_userInfo.nickname;
        self.shoWtype = YES;
        if (!self.ConfirmThePaymentview) {
            [self setType];
        }
        
        if ((self.isOA && ([self.pasteboarddata[@"money"] doubleValue] <= [self.ThreeOkdata.cashAcctBal doubleValue])) || ([self.pasteboarddata[@"money"] doubleValue] <= [self.ThreeOkdata.acctBal doubleValue] && !self.isOA)) {
            self.payMethod = @"BAL";
            self.one = nil;
        } else {
            self.payMethod = @"BANK";
            self.one = self.ThreeOkdata.bankCardsArray.firstObject;
        }
        self.ConfirmThePaymentview.pasteboarddata = self.pasteboarddata;
        self.ConfirmThePaymentview.payMethod = self.payMethod;
    }
}
- (void)paySucces:(id)dataDict{
    if (self.isOA) {
        [super paySucces:dataDict];
    } else {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
        self.alert = alert;
        paySussessTicon *items  = [paySussessTicon new];
        items.WhoCalls = self.pasteboarddata[@"WhoCalls"];

        items.leaveBtnBlock = ^{
            [weakself.alert dismissViewControllerAnimated:NO completion:^{
                if (weakself.pasteboarddata) {
                    [weakself performSelector:@selector(returenCustomaryAPPPro:) withObject:dataDict afterDelay:1.0];
                }
            }];
        };
        items.StayTBtnBlock = ^{
            [weakself.alert dismissViewControllerAnimated:NO completion:^{
                [weakself.navigationController popToRootViewControllerAnimated:YES];
            }];
        };
        [alert.view addSubview:items];
        [items mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(alert.view);
            make.right.equalTo(alert.view);
            make.top.equalTo(alert.view);
            make.bottom.equalTo(alert.view);
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)setType{
    ConfirmThePayment *ConfirmThePaymentview = [ConfirmThePayment new];
    self.ConfirmThePaymentview = ConfirmThePaymentview;
//    ConfirmThePaymentview.tcoinFlag = self.tcoinFlag;
    ConfirmThePaymentview.isOA = self.isOA;
    ConfirmThePaymentview.pasteboarddata = self.pasteboarddata;
    ConfirmThePaymentview.ThreeOkdata = self.ThreeOkdata;
    ConfirmThePaymentview.payMethod = self.payMethod;
    
    kWeakSelf(self);
    ConfirmThePaymentview.guanbi = ^() {
        [weakself popSelfCanl];
    };
    ConfirmThePaymentview.type = ^() {
        [weakself selectType];
    };
    ConfirmThePaymentview.doneOk = ^() {
        if ([PortalHelper sharedInstance].isReachable) {
            [weakself FootpayPre];
        } else {
            [MBProgressHUD showPrompt:@"网络连接异常，请检查网络" toView:weakself.view];
        }
    };
    ConfirmThePaymentview.Tmoneytype = ^(NSString *tcoinFlag) {
        weakself.tcoinFlag = tcoinFlag;
        if ([tcoinFlag isEqualToString:@"0"] && [weakself.payMethod isEqualToString:@"BAL"]) {
            if ((weakself.isOA && ([weakself.pasteboarddata[@"money"] doubleValue] <= [weakself.ThreeOkdata.cashAcctBal doubleValue])) || ((([weakself.pasteboarddata[@"money"] doubleValue] <= [weakself.ThreeOkdata.acctBal doubleValue])|| ([weakself.pasteboarddata[@"money"] doubleValue] <= ([weakself.ThreeOkdata.acctBal doubleValue]+[weakself.ThreeOkdata.integral doubleValue]) && [weakself.tcoinFlag isEqualToString:@"1"])) && !weakself.isOA)) {
            } else {
                weakself.one = self.ThreeOkdata.bankCardsArray.firstObject;
                weakself.payMethod = @"BANK";
                weakself.ConfirmThePaymentview.payMethod = weakself.payMethod;
            }
            
        }
    };
    [self.ConfirmThePaymentview windosViewshowSub:self.view];
}
- (void)selectType{
    if (self.ThreeOkdata.bankCardsArray.count) {
        payTypeSeleTicon *view = [payTypeSeleTicon new];
        view.ThreeOkdata = self.ThreeOkdata;
        view.payMethod = self.payMethod;

        if ((self.isOA && ([self.pasteboarddata[@"money"] doubleValue] <= [self.ThreeOkdata.cashAcctBal doubleValue])) || ((([self.pasteboarddata[@"money"] doubleValue] <= [self.ThreeOkdata.acctBal doubleValue])|| ([self.pasteboarddata[@"money"] doubleValue] <= ([self.ThreeOkdata.acctBal doubleValue]+[self.ThreeOkdata.integral doubleValue]) && [self.tcoinFlag isEqualToString:@"1"])) && !self.isOA)) {
            view.isSuportBAL = YES;
        } else {
            view.isSuportBAL = NO;
        }
        kWeakSelf(self);
        view.ThreeselecetType = ^(ThreeOkBankOne *one) {
            if (!one) {
                weakself.one = self.ThreeOkdata.bankCardsArray.firstObject;
                weakself.payMethod = @"BANK";
            } else {
                weakself.one = nil;
                weakself.payMethod = @"BAL";
            }
            weakself.ConfirmThePaymentview.payMethod = self.payMethod;
        };
        [view windosViewshow];
    } else {
        [MBProgressHUD showPrompt:@"没有更多的支付方式" toView:self.view];
    }
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    if (self.empty_type == In_loading_empty_num || self.empty_type == succes_empty_num){
        return NO;
    }
    return YES;
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (void)setmyUI{
    
}
- (void)setHeadAndFoot{
    
}
@end
