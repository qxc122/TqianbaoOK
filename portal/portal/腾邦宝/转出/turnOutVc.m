//
//  turnOutVc.m
//  portal
//
//  Created by Store on 2018/1/25.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "turnOutVc.h"


@interface turnOutVc ()

@end

@implementation turnOutVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Outtype = @"1";  //默认是快速    0 普通到账
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"1";
    self.title = @"转出";
    self.noticeType  =@"02";
    // Do any additional setup after loading the view.
}


- (void)doneBtnoutOrIn{
    if ([self.money doubleValue] > 0) {
        if ([self.type isEqualToString:@"0"] || self.Outtype.length) {
            [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
            [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
            if ([self.type isEqualToString:@"1"] && [self.money doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
                [MBProgressHUD showPrompt:@"您的腾邦宝余额不足" toView:self.view];
                return;
            }
            NSNumber *bindId = nil;
            for (ThreeOkBankOne *one in self.PayMethodData.bankCards) {
                bindId = one.bindId;
                break;
            }
            if ([self.money doubleValue] >= 1000.0) {
                [self sendSmsCodebindId:[bindId integerValue]  Money:[self.money doubleValue] codeId:nil];
            } else {
                [self OpenPasswordpaymentbox];
            }
        }else{
            [MBProgressHUD showPrompt:@"请选择转出方式" toView:self.view];
        }
    }else{
        [MBProgressHUD showPrompt:@"请输入有效金额" toView:self.view];
    }
}



- (void)setFoot{
    WithdrawCashFoot *foot = [[WithdrawCashFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+20+20)];
    kWeakSelf(self);
    self.foot = foot;
    self.foot.btn.enabled = NO;
    [self.foot.btn setTitle:@"确认转出" forState:UIControlStateNormal];
    foot.doneBtn = ^{
        [weakself doneBtnoutOrIn];
    };
    self.tableView.tableFooterView = foot;
}

#pragma --mark< 配置headRechargeandCell 的数据>
- (void)configureheadRechargeandCell:(headRechargeandCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.right.text = @"银行卡";
    cell.left.text = @"腾邦宝";
}

#pragma --mark< 配置BaoturnIn 的数据>
- (void)configureBaoturnIn:(BaoturnIn *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.input.placeholder = @"请输入转出金额";
    cell.PayMethodData = self.PayMethodData;
    cell.title.text = @"转出金额";
    cell.btnALL.hidden = NO;
    cell.Outtype = self.Outtype;
    kWeakSelf(self);
    
    cell.Fill_in_the_text = ^(NSString *inText) {
        weakself.money = inText;
        if (inText.length) {
            if ([weakself.money doubleValue] > [weakself.PayMethodData.acctBal doubleValue]) {
                weakself.foot.btn.enabled = NO;
            }else if ([weakself.Outtype isEqualToString:@"1"] && [weakself.money doubleValue] > [weakself.PayMethodData.todayFastOuLimit doubleValue]){
                weakself.foot.btn.enabled = NO;
            }else{
                weakself.foot.btn.enabled = YES;
            }
        } else {
            weakself.foot.btn.enabled = NO;
        }
    };
//    if ([self.money doubleValue] == 0) {
//        cell.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
//        cell.des.text = [NSString stringWithFormat:@"本次最多可转出 %.2f",[self.PayMethodData.acctBal doubleValue]];
//    } else if ([self.money doubleValue] > 0 && [self.money doubleValue] <= [self.PayMethodData.acctBal doubleValue]) {
//        cell.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
//        ThreeOkBankOne *one;
//        for (ThreeOkBankOne *oneBank in self.PayMethodData.bankCards) {
//            one = oneBank;
//            break;
//        }
//        if ([one.singleLimit doubleValue] != -1) {
//            if ([one.singleLimit doubleValue] >= [self.money doubleValue]) {
//                if ([self.Outtype isEqualToString:@"0"]) {
//                    cell.des.text = [NSString stringWithFormat:@"快速到帐今日还可转出 %.2f元",([one.singleLimit doubleValue] - [self.money doubleValue])];
//                } else if ([self.Outtype isEqualToString:@"1"]) {
//                    cell.des.text = [NSString stringWithFormat:@"普通到帐今日还可转出 %.2f元",([one.singleLimit doubleValue] - [self.money doubleValue])];
//                }
//            } else {
//                cell.des.text = @"输入金额超出银行卡限额";
//            }
//        }else{
//            cell.des.text = [NSString stringWithFormat:@"您还可转出 %.2f",([self.PayMethodData.acctBal doubleValue] - [self.money doubleValue])];
//        }
//    } else if ([self.money doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
//        cell.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
//        cell.des.text = @"输入金额超出账户余额";
//    }

    if ([self.money doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
        cell.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
        cell.des.text = @"输入金额超出账户余额";
        self.foot.btn.enabled = NO;
    }else if ([self.Outtype isEqualToString:@"1"] && [self.money doubleValue] > [self.PayMethodData.todayFastOuLimit doubleValue]){
        cell.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
        cell.des.text = [NSString stringWithFormat:@"快速到账今日还可提现 %.2f元",[self.PayMethodData.todayFastOuLimit doubleValue]];
        self.foot.btn.enabled = NO;
    }else{
        cell.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
        cell.des.text = [NSString stringWithFormat:@"本次最多可转出 %.2f",[self.PayMethodData.acctBal doubleValue]];
        if (self.money.length) {
            self.foot.btn.enabled = YES;
        } else {
            self.foot.btn.enabled = NO;
        }
    }
}

- (void)cannelPay{
//    kWeakSelf(self);
//    NSString *title = @"温馨提示";
//    NSString *btnStr = @"继续转出";
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:btnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
////        [weakself popSelf];
//        [weakself.boxview closeClisck];
//        weakself.boxview = nil;
//        //        [weakself.Verificationbox closeClisck];
//
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

#pragma --mark< 配置returnOutType 的数据>
- (void)configureturnOutType:(turnOutType *)cell atIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf(self);
    cell.typeClicks = ^(NSString *inText) {
        weakself.Outtype = inText;
        [weakself.tableView reloadData];
        NSLog(@"%@",inText);
    };
    cell.PayMethodData = self.PayMethodData;
    cell.Outtype = self.Outtype;
}
@end
