//
//  ScansuccessVc.m
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScansuccessVc.h"
#import "ScanpaymentsuccessVc.h"
#import "RechargeVc.h"
#import "ScansuccessCell.h"
#import "ScansuccessChangeTypeCell.h"
#import "addBankCarkFoot.h"
#import "payTypeSele.h"
@interface ScansuccessVc ()
@property (nonatomic,weak) addBankCarkFoot *foot;
@property (nonatomic,strong) scanQRCodeOk *scanQRCodeOkdata;

@property (nonatomic,assign) BOOL isBank; //是银行卡还是余额  YES 表示是银行卡
@property (nonatomic,strong) scanQRCodeBankOne *one;

@property (nonatomic,strong) scanQRCodeDone *dataDone; //付款成功的信息

@property (nonatomic,strong) NSString *money;

@property (nonatomic,assign) BOOL isOpenChognzhi;
@end

@implementation ScansuccessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"向个人转帐", @"");
    self.registerClasss = @[[ScansuccessCell class],[ScansuccessChangeTypeCell class]];
    
    UILabel *desBottom = [UILabel new];
    [self.view addSubview:desBottom];
    [desBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom).offset(-32);
    }];
    desBottom.textAlignment = NSTextAlignmentCenter;
    [desBottom setWithColor:0x858E9B Alpha:1.0 Font:12 ROrM:@"r"];
    desBottom.numberOfLines = 0;
    desBottom.text = @"钱将实时转入对方账户，无法退款";
    
//    self.empty_type = succes_empty_num;
//    self.header.hidden = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 12+20, 0);

}
- (void)setFoot{
    addBankCarkFoot *foot = [[addBankCarkFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+60)];
    self.foot = foot;
    [foot.btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"确认转账" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [foot.btn setBackgroundImage:[ColorWithHex(0x5E7FFF, 1.0) imageWithColor] forState:UIControlStateNormal];
    
    if (self.money) {
        foot.btn.enabled = YES;
    } else {
        foot.btn.enabled = NO;
    }
    kWeakSelf(self);
    foot.doneBtn = ^{
        if (weakself.isBank) {
            [weakself sendSmsCodebindId:[weakself.one.bindId integerValue] Money:[weakself.money doubleValue] codeId:weakself.data.codeId];
        } else {
            if ([weakself.money doubleValue] <= [[[PortalHelper sharedInstance]get_userInfoDeatil].cashAcctBal doubleValue]) {
                [weakself sendSmsCodebindId:[weakself.one.bindId integerValue] Money:[weakself.money doubleValue] codeId:weakself.data.codeId];
//                [weakself OpenPasswordpaymentbox];
            } else {
                [weakself Frontalinsufficienc];
            }
        }
        NSLog(@"%s",__func__);
    };
    self.tableView.tableFooterView = foot;
}

- (void)Frontalinsufficienc{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"零钱不足,请先充值" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RechargeVc *tmp = [RechargeVc new];
        [weakself OPenVc:tmp];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"修改金额" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        weakself.money = nil;
        [weakself.tableView reloadData];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_qrCodescanQRCodeWithcodeId:self.data.codeId success:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.scanQRCodeOkdata = [scanQRCodeOk mj_objectWithKeyValues:dataDict];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself setFoot];
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        if (errorCode == 43) {
            [MBProgressHUD showPrompt:msg];
            [weakself popSelf];
        } else {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }
    }];
}

- (void)Passwordinputsuccessful:(NSString *)inText{
//    [self payWithpassWord:inText];
//}
//
//- (void)payWithpassWord:(NSString *)password{
//    if (self.isBank) {
//        [self sendSmsCodebindId:[self.one.bindId integerValue] Money:[self.money doubleValue] codeId:nil];
//    } else {
//        if ([self.money doubleValue] <= [[[PortalHelper sharedInstance]get_userInfoDeatil].cashAcctBal doubleValue]) {
//            [self paywithType:password];
//        } else {
//            [MBProgressHUD showPrompt:@"零钱不足,请先充值"];
//            RechargeVc *tmp = [RechargeVc new];
//            self.isOpenChognzhi = YES;
//            [self OPenVc:tmp];
//        }
//    }
//}
//
//- (void)paywithType:(NSString *)password{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"付款中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_qrCodeunifiedPayWithcodeId:self.data.codeId money:[NSNumber numberWithDouble:[self.money doubleValue]]  bindId:self.one.bindId payMethod:self.isBank?@"BANK":@"BAL" payPassword:inText verifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
        
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        scanQRCodeDone *tmp = [scanQRCodeDone mj_objectWithKeyValues:dataDict];
        weakself.dataDone = tmp;
        [weakself OpenScanpaymentsuccessVcWith:tmp];
        
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        //                [weakself doneSucces];
        [weakself.boxview closeClisck];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [weakself payFailWith:errorCode :msg];
        [weakself.boxview.input clearUpPassword];
    }];
}
- (void)retryPay{
    if (self.boxview) {
        [self.boxview firstINput];
    } else {
        [self OpenPasswordpaymentbox];
    }
}

- (void)OpenScanpaymentsuccessVcWith:(scanQRCodeDone *)data{
    NSLog(@"%s",__func__);
    ScanpaymentsuccessVc *vc = [ScanpaymentsuccessVc new];
    vc.dataDone= data;
    vc.one = self.one;
    vc.CTrollersToR = @[[self class]];
    [self OPenVc:vc];
}

#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        if (self.scanQRCodeOkdata.bankCardArray.count) {
            payTypeSele *view = [payTypeSele new];
            kWeakSelf(self);
            view.selecetType = ^(scanQRCodeBankOne *one) {
                if (![one isEqual:weakself.one]) {
                    if (one) {
                        weakself.isBank = YES;
                        weakself.one = one;
                    } else {
                        weakself.one = nil;
                        weakself.isBank = NO;
                    }
                    [weakself.tableView reloadData];
                }
            };
            view.scanQRCodeOkdata = self.scanQRCodeOkdata;
            [view windosViewshow];
        } else {
            [MBProgressHUD showPrompt:@"没有更多的支付方式" toView:self.view];
        }
    }
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ScansuccessCell *cell = [ScansuccessCell returnCellWith:tableView];
        [self configureScansuccessCell:cell atIndexPath:indexPath];
        
        return  cell;
    }else{
        ScansuccessChangeTypeCell *cell = [ScansuccessChangeTypeCell returnCellWith:tableView];
        [self configureScansuccessChangeTypeCell:cell atIndexPath:indexPath];
        return  cell;
    }
}

#pragma --mark< 配置ScansuccessCell 的数据>
- (void)configureScansuccessCell:(ScansuccessCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.scanQRCodeOkdata = self.scanQRCodeOkdata;
    cell.moneyInput.text = self.money;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *inText) {
        weakself.money = inText;
    };
}
#pragma --mark< 配置ScansuccessChangeTypeCell 的数据>
- (void)configureScansuccessChangeTypeCell:(ScansuccessChangeTypeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.isBank = self.isBank;
    cell.scanQRCodeOkdata = self.scanQRCodeOkdata;
    if (!self.scanQRCodeOkdata.bankCardArray.count) {
        cell.more.hidden = YES;
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (void)setMoney:(NSString *)money{
    _money = money;
    if (money && money.length && [money doubleValue] > 0) {
        self.foot.btn.enabled = YES;
    } else {
        self.foot.btn.enabled = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isOpenChognzhi = NO;
    self.header.hidden = NO;
    [self.header beginRefreshing];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self Notificationfailure];
}
- (void)Notificationfailure{
    if (!self.dataDone && !self.isOpenChognzhi) {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_qrCodecancelUnifiedPayWithcodeId:self.data.codeId verifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself performSelector:@selector(Notificationfailure) withObject:nil afterDelay:0.3];
        }];
    }
}
@end
