//
//  EmployeeLoanVc.m
//  portal
//
//  Created by Store on 2018/1/29.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "EmployeeLoanVc.h"
#import "RepaymentSuccess.h"
#import "ApplySuccessVc.h"
#import "Confirmationofrepayment.h"
#import "payTypeSeleLoad.h"

@interface EmployeeLoanVc ()
@property (strong, nonatomic) NSDictionary *ApplyDic;
@property (strong, nonatomic) NSDictionary *RepaymentDic;
@property (strong, nonatomic) NSString *type;

@property (nonatomic,strong) ThreeOk *ThreeOkdata;
@property (nonatomic,weak) Confirmationofrepayment *ConfirmationofrepaymentView;
@end

@implementation EmployeeLoanVc
#ifdef DEBUG
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self employeeLoanRepaymentFunc:@"100"];
}
#endif
/////////
- (void)employeeLoanApplyFunc:(NSDictionary *)dic{
    NSLog(@"借款%@",dic);
    self.verifyCodetype = @"15";
    self.ApplyDic = [self ProcessingJSdata:dic];
    if (self.ApplyDic[@"loanAmt"] && self.ApplyDic[@"loanPeriod"]) {
        NSNumber *loanAmt = nil;
        if ([self.ApplyDic[@"loanAmt"] isKindOfClass:[NSNumber class]]) {
            loanAmt = self.ApplyDic[@"loanAmt"];
        } else if ([self.ApplyDic[@"loanAmt"] isKindOfClass:[NSString class]]) {
            loanAmt = [NSNumber numberWithDouble:[self.ApplyDic[@"loanAmt"] doubleValue]] ;
        }
        if ([loanAmt doubleValue] >= 1000.0) {
            [self sendSmsCodebindId:0 Money:[loanAmt doubleValue]  codeId:nil];
        } else {
            [self OpenPasswordpaymentbox];
        }
    } else {
        [MBProgressHUD showPrompt:@"缺少参数" toView:self.view];
    }
}
/////////////////

/////////////////
- (void)retryPay{
    if (self.boxview) {
        [self.boxview firstINput];
    } else {
        [self OpenPasswordpaymentbox];
    }
}

- (void)cannelPay{
//    kWeakSelf(self);
//    NSString *title = @"温馨提示,您要放弃吗？";
//    NSString *btnStr = @"继续";
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:btnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        //        [weakself popSelf];
//        [weakself.boxview closeClisck];
//        weakself.boxview = nil;
//        //        [weakself.Verificationbox closeClisck];
//        weakself.Verificationbox.hidden = YES;
//        if (weakself.Verificationbox.codeInput.isFirstResponder) {
//            [weakself.Verificationbox.codeInput resignFirstResponder];
//        }
//    }]];
//    [self presentViewController:alert animated:YES completion:nil];
    
    [self.boxview closeClisck];
    self.boxview = nil;
    //        [weakself.Verificationbox closeClisck];
    
    self.Verificationbox.hidden = YES;
    if (self.Verificationbox.codeInput.isFirstResponder) {
        [self.Verificationbox.codeInput resignFirstResponder];
    }
}
- (void)Passwordinputsuccessful:(NSString *)inText{
    if (self.ApplyDic) {
//        kWeakSelf(self);
//        [MBProgressHUD showLoadingMessage:@"申请借款中..." toView:self.view];
//        NSInteger loanPeriod = 0;
//        NSNumber *loanAmt = nil;
//        if ([self.ApplyDic[@"loanAmt"] isKindOfClass:[NSNumber class]]) {
//            loanAmt = self.ApplyDic[@"loanAmt"];
//        } else if ([self.ApplyDic[@"loanAmt"] isKindOfClass:[NSString class]]) {
//            loanAmt = [NSNumber numberWithDouble:[self.ApplyDic[@"loanAmt"] doubleValue]] ;
//        }
//        if ([self.ApplyDic[@"loanPeriod"] isKindOfClass:[NSNumber class]]) {
//            NSNumber *tmp = self.ApplyDic[@"loanPeriod"];
//            loanPeriod = [tmp integerValue];
//        } else if ([self.ApplyDic[@"loanPeriod"] isKindOfClass:[NSString class]]) {
//            NSString *tmp = self.ApplyDic[@"loanPeriod"];
//            loanPeriod = [tmp integerValue];
//        }
//        [[ToolRequest sharedInstance]URLBASIC_loanloanApplyWithloanAmt:loanAmt loanPeriod:loanPeriod payPassword:inText success:^(id dataDict, NSString *msg, NSInteger code) {
//            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
//            ApplySuccessOKdata *ApplySuccessokdata = [ApplySuccessOKdata mj_objectWithKeyValues:dataDict];
//            ApplySuccessVc *vc =[ApplySuccessVc new];
//            vc.ApplySuccessokdata = ApplySuccessokdata;
////            vc.CTrollersToR = @[[weakself class]];
//            [weakself OPenVc:vc];
//#ifdef DEBUG
//            NSString *strTmp = [dataDict DicToJsonstr];
//            NSLog(@"strTmp=%@",strTmp);
//#endif
//        } failure:^(NSInteger errorCode, NSString *msg) {
//            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
//            [weakself payFailWith:errorCode :msg];
//        }];
        
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:@"申请借款中..." toView:self.view];
//        NSMutableDictionary *params = [NSMutableDictionary new];
//        NSArray *key = self.ApplyDic.allKeys;
//        NSInteger index = 0;
//        for (id Values in self.ApplyDic.allValues) {
//            if ([Values isKindOfClass:[NSNumber class]]) {
//                NSNumber *tmp = Values;
//                NSNumber *ValuesNew;
//                if (<#condition#>) {
//                    <#statements#>
//                } else {
//                    <#statements#>
//                }
//                if (tmp) {
//                    [params setValue:Values forKey:key[index]];
//                }
//            }else{
//                [params setValue:Values forKey:key[index]];
//            }
//        }
        [[ToolRequest sharedInstance]URLBASIC_loanloanApplyWithparams:[self.ApplyDic mutableCopy]  payPassword:inText success:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            ApplySuccessOKdata *ApplySuccessokdata = [ApplySuccessOKdata mj_objectWithKeyValues:dataDict];
            ApplySuccessVc *vc =[ApplySuccessVc new];
            vc.ApplySuccessokdata = ApplySuccessokdata;
            //            vc.CTrollersToR = @[[weakself class]];
            [weakself OPenVc:vc];
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
            [weakself.boxview closeClisck];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [weakself payFailWith:errorCode :msg];
            [weakself.boxview.input clearUpPassword];
        }];
    } else if (self.RepaymentDic) {
        NSNumber * bindId;
        for (ThreeOkBankOne *one in self.ThreeOkdata.bankCardsArray) {
            bindId = one.bindId;
            break;
        }
        NSNumber *amt = self.RepaymentDic[@"amt"];
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:@"还款中..." toView:self.view];
        if ([weakself.Advance isEqualToString:@"1"]) {
            [[ToolRequest sharedInstance]URLBASIC_loanloanRepayWithamt:amt bindId:bindId acctId:self.RepaymentDic[@"acctId"] payPassword:inText payMethod:self.type success:^(id dataDict, NSString *msg, NSInteger code) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                reApplySuccessOKdata *ApplySuccessokdata = [reApplySuccessOKdata mj_objectWithKeyValues:dataDict];
                if ([weakself.webView canGoBack]) {
                    [weakself.webView goBack];
                }
                RepaymentSuccess *vc =[RepaymentSuccess new];
                vc.ThreeOkdata = weakself.ThreeOkdata;
                vc.reApplySuccessokdata = ApplySuccessokdata;
                [weakself OPenVc:vc];
#ifdef DEBUG
                NSString *strTmp = [dataDict DicToJsonstr];
                NSLog(@"strTmp=%@",strTmp);
#endif
                [weakself.boxview closeClisck];
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:msg toView:weakself.view];
                [weakself.boxview.input clearUpPassword];
//                reApplySuccessOKdata *ApplySuccessokdata = [reApplySuccessOKdata new];
//                ApplySuccessokdata.amt = [NSNumber numberWithDouble:100.12];
//                ApplySuccessokdata.bankIcon = [NSURL URLWithString:@"http://cdn.www.sojson.com/ui/images/json.index.png"];
//                ApplySuccessokdata.bankName = @"我";
//                ApplySuccessokdata.bankNo = @"6666";
//                ApplySuccessokdata.payMethod = @"BANK";
//
//                RepaymentSuccess *vc =[RepaymentSuccess new];
//                vc.reApplySuccessokdata = ApplySuccessokdata;
//                vc.ThreeOkdata = weakself.ThreeOkdata;
//                [weakself OPenVc:vc];
            }];
        } else {
            [[ToolRequest sharedInstance]URLBASIC_loanloanRepayWithamt:amt bindId:bindId payPassword:inText payMethod:self.type success:^(id dataDict, NSString *msg, NSInteger code) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                reApplySuccessOKdata *ApplySuccessokdata = [reApplySuccessOKdata mj_objectWithKeyValues:dataDict];
                RepaymentSuccess *vc =[RepaymentSuccess new];
                vc.reApplySuccessokdata = ApplySuccessokdata;
                vc.ThreeOkdata = weakself.ThreeOkdata;
                [weakself OPenVc:vc];
#ifdef DEBUG
                NSString *strTmp = [dataDict DicToJsonstr];
                NSLog(@"strTmp=%@",strTmp);
#endif
                [weakself.boxview closeClisck];
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:msg toView:weakself.view];
                [weakself.boxview.input clearUpPassword];
//                reApplySuccessOKdata *ApplySuccessokdata = [reApplySuccessOKdata new];
//                ApplySuccessokdata.amt = [NSNumber numberWithDouble:100.12];
//                ApplySuccessokdata.bankIcon = [NSURL URLWithString:@"http://cdn.www.sojson.com/ui/images/json.index.png"];
//                ApplySuccessokdata.bankName = @"我";
//                ApplySuccessokdata.bankNo = @"6666";
//                ApplySuccessokdata.payMethod = @"BANK";
//
//                RepaymentSuccess *vc =[RepaymentSuccess new];
//                vc.reApplySuccessokdata = ApplySuccessokdata;
//                vc.ThreeOkdata = weakself.ThreeOkdata;
//                [weakself OPenVc:vc];
            }];
        }
    }
//#import "RepaymentSuccess.h"
//#import "ApplySuccessVc.h"
}
- (void)payFailWith:(NSInteger)errorCode :(NSString *)msg{
    if (errorCode == kRespondCodePassworderror) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself PasswordRetrieval];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself retryPay];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (errorCode == kRespondCodePasswordinputmultipleerrors) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"找回密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself PasswordRetrieval];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
/////////////////


/////////////////   
- (void)employeeLoanRepaymentFunc:(NSDictionary *)dic{
    NSLog(@"还款%@",dic);
    self.RepaymentDic = [self ProcessingJSdata:dic];
    if (![self.Advance isEqualToString:@"1"]) {
        if ([dic isKindOfClass:[NSString class]]) {
            NSString *tmp = (NSString *)dic;
            self.RepaymentDic = @{
                                  @"amt":[NSNumber numberWithDouble:[tmp doubleValue]],
                                  };
        } else if ([dic isKindOfClass:[NSNumber class]]){
            NSNumber *tmp = (NSNumber *)dic;
            self.RepaymentDic = @{
                                  @"amt":tmp,
                                  };
        }
    }
    if ((self.RepaymentDic[@"amt"] && ![self.Advance isEqualToString:@"1"]) || ([self.Advance isEqualToString:@"1"] && self.RepaymentDic[@"acctId"] && self.RepaymentDic[@"amt"])) {
        NSNumber *loanAmt = nil;
        if ([self.RepaymentDic[@"amt"] isKindOfClass:[NSNumber class]]) {
            loanAmt = self.RepaymentDic[@"amt"];
        } else if ([self.RepaymentDic[@"amt"] isKindOfClass:[NSString class]]) {
            loanAmt = [NSNumber numberWithDouble:[self.RepaymentDic[@"amt"] doubleValue]] ;
        }
        if ([loanAmt doubleValue] > 0) {
            [self loadThreeOkdataData];
        } else {
            [MBProgressHUD showPrompt:@"还款金额有误" toView:self.view];
        }
    } else {
        [MBProgressHUD showPrompt:@"缺少参数" toView:self.view];
    }
}

- (void)loadThreeOkdataData{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:@"加载中..." toView:self.view];
    [[ToolRequest sharedInstance]URLBASIC_tpurseuserqueryPayMethodsuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        weakself.ThreeOkdata = [ThreeOk mj_objectWithKeyValues:dataDict];
        
        Confirmationofrepayment *view = [Confirmationofrepayment new];
        weakself.ConfirmationofrepaymentView = view;
        view.ThreeselecetTypeForH5 = ^(NSString *type) {
            weakself.type = type;
            [weakself.ConfirmationofrepaymentView closeClisck];
            [weakself OpenPasswordpaymentbox];
        };
        view.huanMoney = self.RepaymentDic[@"amt"];
        view.ThreeOkdata = weakself.ThreeOkdata;
        [view windosViewshow];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}
/////////////////
@end
