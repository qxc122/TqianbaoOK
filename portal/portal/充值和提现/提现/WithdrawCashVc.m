//
//  WithdrawCashVc.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "WithdrawCashVc.h"
#import "WithdrawCashFoot.h"
#import "RechargeVc.h"
#import "Cryptor.h"
#import "RechargeandcashwithdrawalSuccessVc.h"
#import "RechargeandcashwithdrawalVc.h"
#import "RechargeSuccessVc.h"
#import "cashwithdrawalSuccessVc.h"
#import "EachWkVc.h"
#import "payTypeSele.h"
#import "headRechargeandCell.h"
#import "RechargeandcashwithdrawalBankCellTwo.h"
#define guanbi


#define guanbiSMS
@interface WithdrawCashVc ()
@property (nonatomic,strong) ThreeOk *ThreeOkData;
@property (nonatomic,strong) Conductfinancialtransactions *ConductfinancialtransactionsData;

@property (nonatomic,weak) WithdrawCashFoot *foot;
@property (nonatomic,strong) NSString *money;


@property (nonatomic,strong) NSString *type;
@end

@implementation WithdrawCashVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.load_type = WithdrawCashVc_load_type_NONE;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.type = @"BANK";
    self.registerClasss = @[[RechargeandcashwithdrawalBankCell class],[RechargeandcashwithdrawalMoneyCell class],[headRechargeandCell class],[RechargeandcashwithdrawalBankCellTwo class]];
//    if (self.load_type == WithdrawCashVc_load_type_NONE) {
//
////        UserInfoDeatil *tttmmpp = [[PortalHelper sharedInstance]get_userInfoDeatil];
//
//        BOOL tmpLoad = NO;
//        for (bankCard *tmp in [[PortalHelper sharedInstance]get_userInfoDeatil].Arry_list) {
//            if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
//                tmpLoad = YES;
//            }
//        }
//#ifdef DEBUG
////        tmpLoad = NO;
//#endif
//        if (tmpLoad) {
//            [self setFoot];
//            self.empty_type = succes_empty_num;
//            self.header.hidden = YES;
//        } else {
//           [self.header beginRefreshing];
//        }
//    } else {
//        [self.header beginRefreshing];
//    }
    [self.header beginRefreshing];
}
- (void)setFoot{
    WithdrawCashFoot *foot = [[WithdrawCashFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+15+16+30)];
    kWeakSelf(self);
    foot.url = [[PortalHelper sharedInstance]get_Globaldata].tpursePayAgreementUrl;
    foot.openWkWebVc = ^(id url) {
        [weakself openbaseWkVcWithId:url];
    };
    self.foot = foot;
    self.foot.btn.enabled = NO;
    foot.doneBtn = ^{
        if (weakself.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
            if (self.load_type == WithdrawCashVc_load_type_NONE) {
                if ([weakself.money doubleValue] > [[[PortalHelper sharedInstance]get_userInfoDeatil].cashAcctBal doubleValue]) { 
                    [MBProgressHUD showPrompt:@"提现金额大于可取现金额!" toView:weakself.view];
                } else {
                    if ([weakself.money doubleValue] >= 1000.0) {
                        [weakself OPenSmsCode];
                    } else {
                        [weakself OpenPasswordpaymentbox];
                    }
//#ifdef  guanbiSMS
//                    [weakself OPenSmsCode];
//#else
//                    [weakself OpenPasswordpaymentbox];
//#endif
                }
            } else if (self.load_type == WithdrawCashVc_load_type_H5) {
                if ([weakself.money doubleValue] > [weakself.ConductfinancialtransactionsData.acctBal doubleValue]) {
                    [MBProgressHUD showPrompt:@"提现金额大于可取现金额!" toView:weakself.view];
                } else {
                    [weakself OpenPasswordpaymentbox];
                }
            }
        } else {
            if (self.load_type == WithdrawCashVc_load_type_NONE) {
                [weakself OpenPasswordpaymentbox];
                
                
//#ifdef  guanbiSMS
//                [weakself OPenSmsCode];
//#else
//                [weakself OpenPasswordpaymentbox];
//#endif
            } else if (self.load_type == WithdrawCashVc_load_type_H5) {
                [weakself OpenPasswordpaymentbox];
            }
        }
        NSLog(@"%s",__func__);
    };
    self.tableView.tableFooterView = foot;
}
- (void)OPenSmsCode{
    NSUInteger bindId = 0;
//    for (bankCard *one in [[PortalHelper sharedInstance]get_userInfoDeatil].Arry_list) {
//        if ([one.type isEqualToString:HOME_TYPE_BANK]) {
//            bindId = [one.bindId integerValue];
//        }
//    }
    if (self.load_type == WithdrawCashVc_load_type_NONE) {
        if(self.ThreeOkData.bankCardsArray.count){
            ThreeOkBankOne *tmp = self.ThreeOkData.bankCardsArray.firstObject;
            bindId = [tmp.bindId integerValue];
        }
    } else {
        bindId = [self.ConductfinancialtransactionsData.bindId integerValue];
    }
    
    if (bindId) {
        [self sendSmsCodebindId:bindId Money:[self.money doubleValue] codeId:nil];
        
//        kWeakSelf(self);
        
//        [MBProgressHUD showLoadingMessage:@"发送短信验证吗中..." toView:self.view];
//        [[ToolRequest sharedInstance]moneySystemsendVerifyCodeWithmobile:[[PortalHelper sharedInstance] get_userInfoDeatil].bankMobile type:(weakself.stateMoney == RechargeandcashwithdrawalVcState_Recharge)?@"03":@"04" bindId:bindId money:[self.money doubleValue] codeId:nil success:^(id dataDict, NSString *msg, NSInteger code) {
//            [MBProgressHUD hideHUDForView:weakself.view];
//            [MBProgressHUD showPrompt:@"发送成功" toView:weakself.view];
//            if (!weakself.Verificationbox) {
//                [weakself OpenVerificationCodeBox];
//            }
//            [weakself.Verificationbox creatTimer];
//            weakself.Verificationbox.resendSmsCode = ^{
//                [weakself OPenSmsCode];
//            };
//        } failure:^(NSInteger errorCode, NSString *msg) {
//            [MBProgressHUD hideHUDForView:weakself.view];
//            [MBProgressHUD showPrompt:@"请重试" toView:weakself.view];
//        }];
    }else{
        [MBProgressHUD showPrompt:@"没有查询到银行卡" toView:self.view];;
    }
}
- (void)loadNewData{
    if (self.load_type == WithdrawCashVc_load_type_NONE) {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_tpurseuserqueryPayMethodsuccess:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.ThreeOkData = [ThreeOk mj_objectWithKeyValues:dataDict];
            
//            NSMutableArray *UserInfoDeatilArry = [NSMutableArray array];
//            for (ThreeOkBankOne *one in tmp.bankCardsArray) {
//                bankCard *tmp = [bankCard new];
//                tmp.bigBankIcon = one.bigBankIcon;
//                tmp.bankIcon = one.bankIcon;
//                tmp.bankName = one.bankName;
//                tmp.bindId = one.bindId;
//                tmp.cardNo = one.cardNo;
//                tmp.type = HOME_TYPE_BANK;
//
//                [UserInfoDeatilArry addObject:tmp];
//            }
//
//
//            UserInfoDeatil *tttmmpp = [[PortalHelper sharedInstance]get_userInfoDeatil];
//            tttmmpp.Arry_list = UserInfoDeatilArry;
//            [[PortalHelper sharedInstance] set_userInfoDeatil:tttmmpp];
//
//            BOOL tmpLoad = NO;
//            for (bankCard *tmp in tttmmpp.Arry_list) {
//                if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
//                    tmpLoad = YES;
//                }
//            }
//            if (!tmpLoad) {
//                [MBProgressHUD showPrompt:@"没有查询到银行卡"];
//                [weakself popSelf];
//            }
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
            [weakself setFoot];
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }];
        
//        kWeakSelf(self);
//        [[ToolRequest sharedInstance]URLBASIC_tpurseusermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
//
//            UserInfoDeatil *tttmmpp = [UserInfoDeatil mj_objectWithKeyValues:dataDict];
//            [[PortalHelper sharedInstance] set_userInfoDeatil:tttmmpp];
//
//            BOOL tmpLoad = NO;
//            for (bankCard *tmp in tttmmpp.Arry_list) {
//                if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
//                    tmpLoad = YES;
//                }
//            }
//            if (!tmpLoad) {
//                [MBProgressHUD showPrompt:@"没有查询到银行卡"];
//                [weakself popSelf];
//            }
//#ifdef DEBUG
//            NSString *strTmp = [dataDict DicToJsonstr];
//            NSLog(@"strTmp=%@",strTmp);
//#endif
//            [weakself setFoot];
//            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
//        } failure:^(NSInteger errorCode, NSString *msg) {
//            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
//        }];
        
    } else {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_regularFinmyRegularFinsuccess:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.ConductfinancialtransactionsData = [Conductfinancialtransactions mj_objectWithKeyValues:dataDict];
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
#ifndef guanbi
            if (weakself.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
                if ([weakself.ConductfinancialtransactionsData.tpurseAcctBal floatValue] > 0) {
                    weakself.type = @"TPURSE";
                }
            }
#endif
            [weakself setFoot];
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }];
    }
}
//
- (void)Pay:(NSString *)passWord{
    NSUInteger bindId = 0;

    if (self.load_type == WithdrawCashVc_load_type_NONE) {
        if(self.ThreeOkData.bankCardsArray.count){
            ThreeOkBankOne *tmp = self.ThreeOkData.bankCardsArray.firstObject;
            bindId = [tmp.bindId integerValue];
        }
    } else {
        bindId = [self.ConductfinancialtransactionsData.bindId integerValue];
    }
    if (bindId) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:passWord key:key iv:iv];
        
        if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
            
//            - (void)URLBASIC_regularFinrechargeWithmoney:(double )money
//        bindId:(double )bindId
//        payPassword:(NSString *)payPassword
//        success:(RequestSuccess)successBlock
//        failure:(RequestFailure)failureBlock;
//            
//            - (void)URLBASIC_regularFinwithdrawWithmoney:(double )money
//        bindId:(double )bindId
//        payPassword:(NSString *)payPassword
//        success:(RequestSuccess)successBlock
//        failure:(RequestFailure)failureBlock;
            
            if (self.load_type == WithdrawCashVc_load_type_NONE) {
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"充值中...", @"") toView:self.view];
                kWeakSelf(self);
                [[ToolRequest sharedInstance]URLBASIC_userrechargeWithmoney:[self.money doubleValue]  bindId:bindId payPassword:passDes verifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    RechargeSuccess *data = [RechargeSuccess mj_objectWithKeyValues:dataDict];
                    [weakself OpenRechargeSuccessVcWith:data];
                    //                [weakself doneSucces];
                    NSNotification *notification2 =[NSNotification notificationWithName:@"loadNewData" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification2];
                    [weakself.boxview closeClisck];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    [weakself payFailWith:errorCode :msg];
                    [weakself.boxview.input clearUpPassword];
                }];
            } else if (self.load_type == WithdrawCashVc_load_type_H5) {
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"充值中...", @"") toView:self.view];
                kWeakSelf(self);
                [[ToolRequest sharedInstance]URLBASIC_regularFinrechargeWithmoney:[self.money doubleValue]  bindId:bindId rechargeType:self.type success:^(id dataDict, NSString *msg, NSInteger code) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    ximengOK *data = [ximengOK mj_objectWithKeyValues:dataDict];
                    [weakself openEachWkVcWithId:data.redirectUrl];
                    [weakself.boxview closeClisck];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    [weakself payFailWith:errorCode :msg];
                    [weakself.boxview.input clearUpPassword];
                }];
            }
        } else if (self.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
            if (self.load_type == WithdrawCashVc_load_type_H5) {
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"提现中...", @"") toView:self.view];
                kWeakSelf(self);
                [[ToolRequest sharedInstance]URLBASIC_regularFinwithdrawWithmoney:[self.money doubleValue]  bindId:bindId  success:^(id dataDict, NSString *msg, NSInteger code) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    ximengOK *data = [ximengOK mj_objectWithKeyValues:dataDict];
                    [weakself openEachWkVcWithId:data.redirectUrl];
#ifdef DEBUG
                    NSString *strTmp = [dataDict DicToJsonstr];
                    NSLog(@"strTmp=%@",strTmp);
#endif
                    [weakself.boxview closeClisck];
                    //                [weakself doneSucces];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    [weakself payFailWith:errorCode :msg];
                    [weakself.boxview.input clearUpPassword];
                }];
            } else if (self.load_type == WithdrawCashVc_load_type_NONE) {
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"提现中...", @"") toView:self.view];
                kWeakSelf(self);
                [[ToolRequest sharedInstance]URLBASIC_userwithdrawWithmoney:[self.money doubleValue]  bindId:bindId payPassword:passDes  verifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    Successincashwithdrawal *data = [Successincashwithdrawal mj_objectWithKeyValues:dataDict];
                    [weakself OpencashwithdrawalSuccessVcWith:data];
                    NSNotification *notification2 =[NSNotification notificationWithName:@"loadNewData" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification2];
#ifdef DEBUG
                    NSString *strTmp = [dataDict DicToJsonstr];
                    NSLog(@"strTmp=%@",strTmp);
#endif
                    [weakself.boxview closeClisck];
                    //                [weakself doneSucces];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    [weakself payFailWith:errorCode :msg];
                    [weakself.boxview.input clearUpPassword];
                }];
            }
        }
        
    } else {
        [MBProgressHUD showPrompt:NSLocalizedString(@"无有效银行卡", @"") toView:self.view afterDelay:3.0f];
    }
}
- (void)OpenPasswordpaymentbox{
    if (self.load_type == WithdrawCashVc_load_type_H5) {
        if (self.ConductfinancialtransactionsData.bindId) {
            if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
                if ([self.type isEqualToString:@"TPURSE"] && [self.ConductfinancialtransactionsData.tpurseAcctBal floatValue] < [self.money floatValue]) {
                    [MBProgressHUD showPrompt:@"您的T钱包零钱不足,请选用银行卡充值" afterDelay:2.0];
                } else {
                    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"充值中...", @"") toView:self.view];
                    kWeakSelf(self);
                    [[ToolRequest sharedInstance]URLBASIC_regularFinrechargeWithmoney:[self.money doubleValue]  bindId:[self.ConductfinancialtransactionsData.bindId integerValue] rechargeType:self.type success:^(id dataDict, NSString *msg, NSInteger code) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        ximengOK *data = [ximengOK mj_objectWithKeyValues:dataDict];
                        [weakself openEachWkVcWithId:data.redirectUrl];
                        
                    } failure:^(NSInteger errorCode, NSString *msg) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [weakself payFailWith:errorCode :msg];
                    }];
                }
            }else if (self.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"提现中...", @"") toView:self.view];
                kWeakSelf(self);
                [[ToolRequest sharedInstance]URLBASIC_regularFinwithdrawWithmoney:[self.money doubleValue]  bindId:[self.ConductfinancialtransactionsData.bindId integerValue] success:^(id dataDict, NSString *msg, NSInteger code) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    ximengOK *data = [ximengOK mj_objectWithKeyValues:dataDict];
                    [weakself openEachWkVcWithId:data.redirectUrl];
#ifdef DEBUG
                    NSString *strTmp = [dataDict DicToJsonstr];
                    NSLog(@"strTmp=%@",strTmp);
#endif
                    //                [weakself doneSucces];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    [weakself payFailWith:errorCode :msg];
                }];
            }
        }
    }else if (self.load_type == WithdrawCashVc_load_type_NONE) {
        [super OpenPasswordpaymentbox];
    }
}

- (void)openEachWkVcWithId:(id)url{
    EachWkVc *wkweb = [[EachWkVc alloc]init];
    wkweb.isCloseBack = NO;
    wkweb.url = url;
    wkweb.CTrollersToR = @[[self class]];
    [self OPenVc:wkweb];
}

- (void)retryPay{
    if (self.boxview) {
        [self.boxview firstINput];
    } else {
        [self OpenPasswordpaymentbox];
    }
}



- (void)OpenRechargeSuccessVcWith:(RechargeSuccess *)data{
    RechargeSuccessVc *vc = [RechargeSuccessVc new];
    vc.data = data;
    vc.CTrollersToR = @[[RechargeandcashwithdrawalVc class],[RechargeVc class]];
    [self OPenVc:vc];
}
- (void)OpencashwithdrawalSuccessVcWith:(Successincashwithdrawal *)data{
    cashwithdrawalSuccessVc *vc = [cashwithdrawalSuccessVc new];
    vc.data = data;
    vc.CTrollersToR = @[[RechargeandcashwithdrawalVc class],[self class]];
    [self OPenVc:vc];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#ifndef guanbi
    if(self.load_type == WithdrawCashVc_load_type_H5 && self.stateMoney == SeleVC_Recharge && indexPath.row == 1){
        [self.tableView endEditing:YES];
        payTypeSele *view = [payTypeSele new];
        view.money = self.money;
        kWeakSelf(self);
        view.ThreeselecetTypeForH5 = ^(NSString *type) {
            if(![weakself.type isEqualToString:type]){
                weakself.type = type;
                [weakself.tableView reloadData];
            }
        };
        view.ConductfinancialtransactionsData = self.ConductfinancialtransactionsData;
        [view windosViewshow];
    }
#endif

}

//- (void)doneSucces{
//    RechargeandcashwithdrawalSuccessVc *vc = [RechargeandcashwithdrawalSuccessVc new];
//    vc.stateMoney = self.stateMoney;
//    vc.Money = self.money;
//    vc.CTrollersToR = @[[RechargeandcashwithdrawalVc class]];
//    [self OPenVc:vc]; 
//}
- (void)Passwordinputsuccessful:(NSString *)inText{
    [self Pay:inText];
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        if (indexPath.row == 0) {
            headRechargeandCell *cell = [headRechargeandCell returnCellWith:tableView];
            [self configureheadRechargeandCell:cell atIndexPath:indexPath];
            return  cell;
        }else if (indexPath.row == 1) {
            if ([self.type isEqualToString:@"BANK"]) {
                RechargeandcashwithdrawalBankCellTwo *cell = [RechargeandcashwithdrawalBankCellTwo returnCellWith:tableView];
                [self configureRechargeandcashwithdrawalBankCell:cell atIndexPath:indexPath];
                return  cell;
            } else {
                RechargeandcashwithdrawalBankCell *cell = [RechargeandcashwithdrawalBankCell returnCellWith:tableView];
                [self configureRechargeandcashwithdrawalBankCell:cell atIndexPath:indexPath];
                return  cell;
            }
        } else {
            RechargeandcashwithdrawalMoneyCell *cell = [RechargeandcashwithdrawalMoneyCell returnCellWith:tableView];
            [self configureRechargeandcashwithdrawalMoneyCell:cell atIndexPath:indexPath];
            return  cell;
        }
    } else {
        if (indexPath.row == 0) {
            headRechargeandCell *cell = [headRechargeandCell returnCellWith:tableView];
            [self configureheadRechargeandCell:cell atIndexPath:indexPath];
            return  cell;
        }else if (indexPath.row == 1) {
            RechargeandcashwithdrawalBankCellTwo *cell = [RechargeandcashwithdrawalBankCellTwo returnCellWith:tableView];
            [self configureRechargeandcashwithdrawalBankCell:cell atIndexPath:indexPath];
            return  cell;
            
//            RechargeandcashwithdrawalBankCell *cell = [RechargeandcashwithdrawalBankCell returnCellWith:tableView];
//            [self configureRechargeandcashwithdrawalBankCell:cell atIndexPath:indexPath];
//            return  cell;
        } else {
            RechargeandcashwithdrawalMoneyCell *cell = [RechargeandcashwithdrawalMoneyCell returnCellWith:tableView];
            [self configureRechargeandcashwithdrawalMoneyCell:cell atIndexPath:indexPath];
            return  cell;
        }
    }
}

#pragma --mark< 配置headRechargeandCell 的数据>
- (void)configureheadRechargeandCell:(headRechargeandCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        if (self.load_type == WithdrawCashVc_load_type_NONE) {
            cell.left.text = @"银行卡";
            cell.right.text = @"零钱";
        } else {
            if ([self.type isEqualToString:@"BANK"]) {
                cell.left.text = @"银行卡";
                cell.right.text = @"理财余额";
            } else {
                cell.left.text = @"零钱";
                cell.right.text = @"理财余额";
            }
        }
    } else {
        if (self.load_type == WithdrawCashVc_load_type_NONE) {
            cell.right.text = @"银行卡";
            cell.left.text = @"零钱";
        } else {
            if ([self.type isEqualToString:@"BANK"]) {
                cell.right.text = @"银行卡";
                cell.left.text = @"理财余额";
            } else {
                cell.right.text = @"零钱";
                cell.left.text = @"理财余额";
            }
        }
    }
}

#pragma --mark< 配置RechargeandcashwithdrawalBankCell 的数据>
- (void)configureRechargeandcashwithdrawalBankCell:(RechargeandcashwithdrawalBankCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.type = self.type;
    if (self.load_type == WithdrawCashVc_load_type_NONE) {
        cell.ThreeOkData = self.ThreeOkData;
//        cell.userData = [[PortalHelper sharedInstance]get_userInfoDeatil];
    } else if (self.load_type == WithdrawCashVc_load_type_H5) {
        cell.ConductfinancialtransactionsData = self.ConductfinancialtransactionsData;
    }
#ifndef guanbi
    if(self.load_type == WithdrawCashVc_load_type_H5 && self.stateMoney == SeleVC_Recharge){
        cell.more.hidden= NO;
    }else{
        cell.more.hidden= YES;
    }
#endif
}

#pragma --mark< 配置RechargeandcashwithdrawalMoneyCell 的数据>
- (void)configureRechargeandcashwithdrawalMoneyCell:(RechargeandcashwithdrawalMoneyCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.stateMoney = self.stateMoney;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *inText) {
        weakself.money = inText;
    };
    cell.type = self.type;
    if (self.load_type == WithdrawCashVc_load_type_NONE) {
//        cell.userData = [[PortalHelper sharedInstance]get_userInfoDeatil];
        cell.ThreeOkData = self.ThreeOkData;
    } else if (self.load_type == WithdrawCashVc_load_type_H5) {
        cell.ConductfinancialtransactionsData = self.ConductfinancialtransactionsData;
    }
}
- (void)setMoney:(NSString *)money{
    _money = money;
    if (money && money.length && [money doubleValue] > 0) {
        self.foot.btn.enabled = YES;
    } else {
        self.foot.btn.enabled = NO;
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        return 3;
    } else {
        return 3;
    }
}
@end
