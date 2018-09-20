//
//  RealNameVc.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RealNameVc.h"
#import "RealNameFoot.h"

@interface RealNameVc ()

@end

@implementation RealNameVc
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
    self.fd_prefersNavigationBarHidden = YES;

}

- (void)addHeadAndFoot{
    CGFloat tmp = 112;
    if (IPoneX) {
        tmp += 20;
    }
    RealNameHead *head = [[RealNameHead alloc]initWithFrame:CGRectMake(0, 0, 0, tmp)];
    head.title.text = NSLocalizedString(@"请绑定本人银行卡完成认证", @"");
    self.head = head;
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    self.tableView.tableHeaderView = head;

    if ([self.filterFlag isEqualToString:@"1"]) {
        RealNameFoot *foot = [[RealNameFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+42*2)];
        foot.openWkWebVc = ^(id url) {
            [weakself openFourAgreement];
        };
        self.foot = foot;
        self.foot.btn.enabled = NO;
        self.foot.doneBtn = ^{
            [weakself bingBank];
            NSLog(@"%s",__func__);
        };
        self.tableView.tableFooterView = self.foot;
    }else{
        [super addFoot];
    }
}

- (void)openFourAgreement{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    kWeakSelf(self);
//    [alert addAction:[UIAlertAction actionWithTitle:@"《T钱包快捷支付协议》" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].tpursePayAgreementUrl];
//    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"《平安大华快取协议》" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].tpurseServiceRechargeAgreementUrl];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"《平安大华客户协议》" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].tpurseServiceCustomerAgreementUrl];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"《平安付科技电子支付账户协议》" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].fundAcctPayAgreementUrl];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    return;
}

//- (void)Openprotocollist{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    kWeakSelf(self);
//    [alert addAction:[UIAlertAction actionWithTitle:@"T钱包快捷支付协议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [weakself openbaseWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].tpursePayAgreementUrl];
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
//    [self presentViewController:alert animated:YES completion:nil];
//    return;
//}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *one = self.Arry_data[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"持卡银行", @"")]) {
        ReaNameaddBankCardselectBankcell *cell = [ReaNameaddBankCardselectBankcell returnCellWith:tableView];
        [self configureaddBankCardselectBankcell:cell atIndexPath:indexPath];
        return  cell;
    }else if ([one.title isEqualToString:NSLocalizedString(@"验证码", @"")]) {
        ReaNameaddBankCardsmscell *cell = [ReaNameaddBankCardsmscell returnCellWith:tableView];
        [self configureaddBankCardsmscell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        ReaNamebaseFillCell *cell = [ReaNamebaseFillCell returnCellWith:tableView];
        [self configurebaseFillCell:cell atIndexPath:indexPath];
        if ([one.title isEqualToString:NSLocalizedString(@"姓名", @"")]) {
            if (self.bankListdata.userRealName.length) {
                cell.input.userInteractionEnabled = NO;
                cell.input.textColor = ColorWithHex(NORMOL_GRAY, 1.0);
            }else{
                cell.input.userInteractionEnabled = YES;
                cell.input.textColor = ColorWithHex(NORMOL_BLACK, 1.0);
            }
        } else if ([one.title isEqualToString:NSLocalizedString(@"身份证", @"")]) {
            if (self.bankListdata.userRealName.length) {
                cell.input.userInteractionEnabled = NO;
                cell.input.textColor = ColorWithHex(NORMOL_GRAY, 1.0);
            }else{
                cell.input.userInteractionEnabled = YES;
                cell.input.textColor = ColorWithHex(NORMOL_BLACK, 1.0);
            }
        }
        return  cell;
    }
}
@end
