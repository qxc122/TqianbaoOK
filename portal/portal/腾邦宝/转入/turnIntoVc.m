//
//  turnIntoVc.m
//  portal
//
//  Created by Store on 2018/1/25.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "turnIntoVc.h"
#import "RechargeandcashwithdrawalBankCellTwo.h"
#import "RechargeandcashwithdrawalBankCell.h"
#import "turnIntoSuccessVc.h"
#import "turnOutSuccessVc.h"
#import "NoticeView.h"
@interface turnIntoVc ()

@end

@implementation turnIntoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"0";
    self.title = @"转入";
    self.noticeType  =@"01";
    self.registerClasss = @[[headRechargeandCell class],[RechargeandcashwithdrawalBankCellTwo class],[BaoturnIn class],[turnOutType class],[RechargeandcashwithdrawalBankCell class],[topCell class]];
    [self.header beginRefreshing];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tmpIndex = indexPath.row;
    if (self.MynoticeData.idd) {
        if (indexPath.row == 0) {
            topCell *cell = [topCell returnCellWith:tableView];
            [self configuretopCell:cell atIndexPath:indexPath];
            return  cell;
        }else{
            tmpIndex--;
        }
    }
    if (tmpIndex == 0) {
        headRechargeandCell *cell = [headRechargeandCell returnCellWith:tableView];
        [self configureheadRechargeandCell:cell atIndexPath:indexPath];
        return  cell;
    }else if (tmpIndex == 1) {
        for (ThreeOkBankOne *oneBank in self.PayMethodData.bankCards) {
            if ([oneBank.singleLimit doubleValue]>0 && [self.type isEqualToString:@"0"]) {
                RechargeandcashwithdrawalBankCell *cell = [RechargeandcashwithdrawalBankCell returnCellWith:tableView];
                [self configureRechargeandcashwithdrawalBankCell:cell atIndexPath:indexPath];
                return  cell;
            } else {
                RechargeandcashwithdrawalBankCellTwo *cell = [RechargeandcashwithdrawalBankCellTwo returnCellWith:tableView];
                [self configureRechargeandcashwithdrawalBankCell:cell atIndexPath:indexPath];
                return  cell;
            }
        }
    } else if (tmpIndex == 2) {
        BaoturnIn *cell = [BaoturnIn returnCellWith:tableView];
        [self configureBaoturnIn:cell atIndexPath:indexPath];
        return  cell;
    } else {
        turnOutType *cell = [turnOutType returnCellWith:tableView];
        [self configureturnOutType:cell atIndexPath:indexPath];
        return  cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0 && self.MynoticeData.idd) {
        NoticeView *view = [NoticeView new];
        view.MynoticeData = self.MynoticeData;
        [view windosViewshow];
    }
}
#pragma --mark< 配置topCell 的数据>
- (void)configuretopCell:(topCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.MynoticeData = self.MynoticeData;
}

#pragma --mark< 配置headRechargeandCell 的数据>
- (void)configureheadRechargeandCell:(headRechargeandCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.left.text = @"银行卡";
    cell.right.text = @"腾邦宝";
}

#pragma --mark< 配置RechargeandcashwithdrawalBankCell 的数据>
- (void)configureRechargeandcashwithdrawalBankCell:(RechargeandcashwithdrawalBankCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    for (ThreeOkBankOne *oneBank in self.PayMethodData.bankCards) {
        if ([self.type isEqualToString:@"0"]) {
            cell.oneBank = oneBank;
        }else{
            cell.BankName.text = oneBank.bankName;
            cell.BankNumber.text = [NSString stringWithFormat:@"(%@)",[@"尾号" stringByAppendingString:oneBank.cardNo]];
            [cell.Banklogo sd_setImageWithURL:oneBank.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
        }
        break;
    }
}

#pragma --mark< 配置BaoturnIn 的数据>
- (void)configureBaoturnIn:(BaoturnIn *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.input.placeholder = @"请输入购买货币基金的金额";
    cell.title.text = @"转入金额";
    cell.btnALL.hidden = YES;
    cell.PayMethodData = self.PayMethodData;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *inText) {
        weakself.money = inText;
        ThreeOkBankOne *one;
        for (ThreeOkBankOne *oneBank in weakself.PayMethodData.bankCards) {
            one = oneBank;
            break;
        }
        if ([weakself.money doubleValue] > [one.singleLimit doubleValue] && [one.singleLimit doubleValue] > 0) {
            weakself.foot.btn.enabled = NO;
        }else{
            if (self.money.length) {
                weakself.foot.btn.enabled = YES;
            } else {
                weakself.foot.btn.enabled = NO;
            }
        }
    };
    
    ThreeOkBankOne *one;
    for (ThreeOkBankOne *oneBank in self.PayMethodData.bankCards) {
        one = oneBank;
        break;
    }

    if ([self.money doubleValue] > [one.singleLimit doubleValue] && [one.singleLimit doubleValue] > 0) {
        cell.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
        cell.des.text = @"输入金额超限";
        weakself.foot.btn.enabled = NO;
    }else{
        if (self.money.length) {
            weakself.foot.btn.enabled = YES;
        } else {
            weakself.foot.btn.enabled = NO;
        }
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [@"预计收益到账时间" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        
        if (self.PayMethodData.incomeArrDate.length) {
            NSAttributedString *title = [self.PayMethodData.incomeArrDate CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
            [all appendAttributedString:title];
        }
        cell.des.attributedText = all;
    }
//    NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
//    NSAttributedString *title = [@"预计收益到账时间" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
//    [all appendAttributedString:title];
//
//    if (self.PayMethodData.incomeArrDate.length) {
//        NSAttributedString *title = [self.PayMethodData.incomeArrDate CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
//        [all appendAttributedString:title];
//    }
//    cell.des.attributedText = all;
}
#pragma --mark< 配置returnOutType 的数据>
- (void)configureturnOutType:(turnOutType *)cell atIndexPath:(NSIndexPath *)indexPath {
            
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger indexAll = 0;
    if (self.empty_type == succes_empty_num) {
        if ([self.type isEqualToString:@"0"]) {
            indexAll = 3;
        } else {
            indexAll = 4;
        }
    }else{
        indexAll = 0;
    }
    if (self.MynoticeData.idd) {
        indexAll++;
    }
    return indexAll;
}



- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpTreasurequeryPayMethodWith:self.type success:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.PayMethodData = [tpTreasurequeryPayMethod mj_objectWithKeyValues:dataDict];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        if (weakself.PayMethodData && weakself.MynoticeData) {
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
            [weakself setFoot];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
    
    [[ToolRequest sharedInstance]URLBASIC_tpTreasurenoticeWith:self.noticeType success:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.MynoticeData = [noticeData mj_objectWithKeyValues:dataDict];
        if (weakself.PayMethodData && weakself.MynoticeData) {
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
            [weakself setFoot];
        }
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
    
}
- (void)setFoot{
    WithdrawCashFoot *foot = [[WithdrawCashFoot alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50+15+16+30)];
    kWeakSelf(self);
    self.foot = foot;
    [self.foot.btn setTitle:@"确认转入" forState:UIControlStateNormal];
    self.foot.btn.enabled = NO;
    foot.doneBtn = ^{
        [weakself doneBtnoutOrIn];
    };
    self.tableView.tableFooterView = foot;
}

- (void)Passwordinputsuccessful:(NSString *)inText{
    if ([self.money doubleValue] > 0) {
        kWeakSelf(self);
        NSNumber *bindId = nil;
        for (ThreeOkBankOne *one in self.PayMethodData.bankCards) {
            bindId = one.bindId;
            break;
        }
        if (bindId) {
            if ([self.type isEqualToString:@"0"]) {
                [MBProgressHUD showLoadingMessage:@"转入中..." toView:self.view];
                [[ToolRequest sharedInstance]URLBASIC_tpTreasurewithdrawWithmoney:[NSNumber numberWithDouble:[self.money doubleValue]] bindId:bindId payPassword:inText success:^(id dataDict, NSString *msg, NSInteger code) {
                    [MBProgressHUD hideHUDForView:weakself.view];
                    
                    outORINSuccess *outORINSuccessdata = [outORINSuccess mj_objectWithKeyValues:dataDict];
                    turnIntoSuccessVc *vc= [turnIntoSuccessVc new];
                    vc.outORINSuccessdata = outORINSuccessdata;
                    vc.CTrollersToR = @[[self class]];
                    [weakself OPenVc:vc];
                    [weakself.boxview closeClisck];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                    [weakself payFailWith:errorCode :msg];
                    [weakself.boxview.input clearUpPassword];
                }];
            } else {
                if ([self.money doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
                    [MBProgressHUD showLoadingMessage:@"您的账户余额不足" toView:self.view];
                }else{
                    [MBProgressHUD showLoadingMessage:@"转出中..." toView:self.view];
                    [[ToolRequest sharedInstance]URLBASIC_tpTreasurerechargeWithmoney:[NSNumber numberWithDouble:[self.money doubleValue]] bindId:bindId type:self.Outtype payPassword:inText success:^(id dataDict, NSString *msg, NSInteger code) {
                        [MBProgressHUD hideHUDForView:weakself.view];
                        
                        outORINSuccess *outORINSuccessdata = [outORINSuccess mj_objectWithKeyValues:dataDict];
                        //TODO
                        turnOutSuccessVc *vc= [turnOutSuccessVc new];
                        vc.outORINSuccessdata = outORINSuccessdata;
                        vc.CTrollersToR = @[[self class]];
                        [weakself OPenVc:vc];
                        [weakself.boxview closeClisck];
                    } failure:^(NSInteger errorCode, NSString *msg) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [weakself payFailWith:errorCode :msg];
                        [weakself.boxview.input clearUpPassword];
                    }];
                }
            }
        } else {
            [MBProgressHUD showPrompt:@"没有查询到bindId" toView:self.view];
        }
    } else {
        [MBProgressHUD showPrompt:@"请输入有效金额" toView:self.view];
    }
}

- (void)retryPay{
//    [self OpenPasswordpaymentbox];
    if (self.boxview) {
        [self.boxview firstINput];
    } else {
        [self OpenPasswordpaymentbox];
    }
}

- (void)cannelPay{
//    kWeakSelf(self);
//    NSString *title = @"温馨提示";
//    NSString *btnStr = @"继续转入";
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:btnStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
////        [weakself popSelf];
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

- (void)doneBtnoutOrIn{
    if ([self.money doubleValue] > 0) {
        if ([self.type isEqualToString:@"0"] || self.Outtype.length) {
            [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
            [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
            if ([self.type isEqualToString:@"1"] && [self.money doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
                [MBProgressHUD showPrompt:@"您的腾邦宝余额不足" toView:self.view];
                return;
            }

            [self OpenPasswordpaymentbox];
        }else{
           [MBProgressHUD showPrompt:@"请选择转出方式" toView:self.view];
        }
    }else{
        [MBProgressHUD showPrompt:@"请输入有效金额" toView:self.view];
    }
}
@end
