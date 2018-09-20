//
//  RechargeandcashwithdrawalMoneyCell.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RechargeandcashwithdrawalMoneyCell.h"



@interface RechargeandcashwithdrawalMoneyCell ()<UITextFieldDelegate>

@end

@implementation RechargeandcashwithdrawalMoneyCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    RechargeandcashwithdrawalMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = ColorWithHex(0xF7F8FA, 1.0);
        UIView *back = [UIView new];
        self.back = back;
        [self.contentView addSubview:back];
        
        UILabel *title = [UILabel new];
        self.title = title;
        [self.contentView addSubview:title];
        
        UILabel *money = [UILabel new];
        self.money = money;
        [self.contentView addSubview:money];
        
        UITextFieldAdd *input = [UITextFieldAdd new];
        self.input = input;
        [self.contentView addSubview:input];
        
        UIView *line = [UIView new];
        self.line = line;
        [self.contentView addSubview:line];
        
        UILabel *des = [UILabel new];
        self.des = des;
        [self.contentView addSubview:des];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.top.equalTo(self.back).offset(24);
        }];
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.width.equalTo(@21);
//            make.height.equalTo(@27);
            make.top.equalTo(self.title.mas_bottom).offset(22.9);
        }];
        [input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.money.mas_right).offset(24.5);
            make.right.equalTo(self.line);
//            make.top.equalTo(self.money);
//            make.height.equalTo(@27);
            make.bottom.equalTo(self.money);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.right.equalTo(self.back).offset(-20);
            make.top.equalTo(self.money.mas_bottom).offset(10);
            make.height.equalTo(@(0.5));
        }];
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.right.equalTo(self.line);
            make.top.equalTo(self.line.mas_bottom).offset(19);
            make.bottom.equalTo(self.back.mas_bottom).offset(-19);
        }];
        
        des.numberOfLines = 0;
        back.backgroundColor = [UIColor whiteColor];
        line.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
        [title setWithColor:0x475468 Alpha:1.0 Font:16 ROrM:@"r"];
        [money setWithColor:0x475468 Alpha:1.0 Font:38 ROrM:@"r"];
        [input setWithColor:NORMOL_BLACK Alpha:1.0 Font:15 ROrM:@"r"];
        [input setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [input setWithColor:0x475468 Alpha:1.0 Font:15 ROrM:@"r"];
        self.money.text = @"¥";
        self.input.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.input.keyboardType = UIKeyboardTypeDecimalPad;
        self.input.delegate = self;
        [input addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        input.placeholder = @"sdfsf";
//        title.text = @"充值金额";
//        money.text = @"¥";
//        des.text = @"sad 发生的发生地方";
        
    }
    return self;
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        self.input.placeholder = @"请输入充值金额";
        self.title.text = @"充值金额";

        NSMutableAttributedString *str1 = [@"零钱余额" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        NSMutableAttributedString *str2 = [[NSString stringWithFormat:@"%.2f元",[userData.acctBal   doubleValue]] CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        [str1 appendAttributedString:str2];
        self.des.attributedText = str1;
    } else if (self.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
        self.input.placeholder = @"请输入取现金额";
        self.title.text = @"提现金额";
        
        NSMutableAttributedString *str1 = [@"本次最多可提现" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        NSMutableAttributedString *str2 = [[NSString stringWithFormat:@"%.2f元",[userData.cashAcctBal doubleValue]] CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        [str1 appendAttributedString:str2];
        self.des.attributedText = str1;
    }
}

- (void)setThreeOkData:(ThreeOk *)ThreeOkData{
    _ThreeOkData = ThreeOkData;
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        self.input.placeholder = @"请输入充值金额";
        self.title.text = @"充值金额";
        
        NSMutableAttributedString *str1 = [@"零钱余额" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        NSMutableAttributedString *str2 = [[NSString stringWithFormat:@"%.2f元",[ThreeOkData.acctBal   doubleValue]] CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        [str1 appendAttributedString:str2];
        self.des.attributedText = str1;
    } else if (self.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
        self.input.placeholder = @"请输入取现金额";
        self.title.text = @"提现金额";
        
        NSMutableAttributedString *str1 = [@"本次最多可提现" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        NSMutableAttributedString *str2 = [[NSString stringWithFormat:@"%.2f元",[ThreeOkData.cashAcctBal doubleValue]] CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        [str1 appendAttributedString:str2];
        self.des.attributedText = str1;
    }
}
- (void)setConductfinancialtransactionsData:(Conductfinancialtransactions *)ConductfinancialtransactionsData{
    _ConductfinancialtransactionsData = ConductfinancialtransactionsData;
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        self.input.placeholder = @"请输入充值金额";
        self.title.text = @"充值金额";
        
        NSMutableAttributedString *str1 = [@"账户当前余额" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        NSMutableAttributedString *str2 = [[NSString stringWithFormat:@"%.2f元",[ConductfinancialtransactionsData.acctBal   doubleValue]] CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        [str1 appendAttributedString:str2];
        self.des.attributedText = str1;
//        self.des.hidden = NO;
    } else if (self.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
        self.input.placeholder = @"请输入取现金额";
        self.title.text = @"提现金额";
        
        NSMutableAttributedString *str1 = [@"本次最多可提现" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        NSMutableAttributedString *str2 = [[NSString stringWithFormat:@"%.2f元",[ConductfinancialtransactionsData.acctBal doubleValue]] CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0.0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0.0 headIndent:0.0 paragraphSpacing:0.0 WordSpace:0.0];
        [str1 appendAttributedString:str2];
        self.des.attributedText = str1;
    }
}

#pragma  -mark<输入框改变了>
-(void)textFieldDidChange :(UITextField *)textField{
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(textField.text);
    }
    [self setTextIN];
}
- (void)setTextIN{
    if (self.input.text.length) {
        [self.input setWithColor:0x475468 Alpha:1.0 Font:38 ROrM:@"r"];
    }else{
//        if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
//            self.input.placeholder = @"请输入充值金额";
//        } else if (self.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
//            self.input.placeholder = @"请输入取现金额";
//        }
        [self.input setWithColor:0x475468 Alpha:1.0 Font:15 ROrM:@"r"];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length >1 && [[textField.text substringFromIndex:textField.text.length-1] isEqualToString:@"."]) {
        textField.text = [textField.text substringToIndex:textField.text.length-1];
    }
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(textField.text);
    }
}



- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    BOOL tmp = NO;
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""]) {
        if ([textField.text isEqualToString:@"0."]) {
            textField.text = nil;
            [self setTextIN];
        }
        tmp = YES;
    } else {
        
        tmp =  [string ThejudgmentisaletterXx];
        if (tmp) {
            if ((!textField.text || !textField.text.length) && ([string isEqualToString:@"0"] || [string isEqualToString:@"."])) {
                textField.text = @"0.";
                [self setTextIN];
                tmp = NO;
            }
        }
        if (tmp) {
            if ([textField.text rangeOfString:@"."].location != NSNotFound && [string isEqualToString:@"."]) {
                tmp = NO;
            }
        }
        if (tmp) {
            NSRange rang = [textField.text rangeOfString:@"."];
            if (rang.location != NSNotFound) {
                if (textField.text.length - rang.location -1 >=2) {
                    tmp = NO;
                }
            }
        }
    }
    return tmp;
}

- (void)setType:(NSString *)type{
    _type = type;
//    if ([type isEqualToString:@"BANK"]) {
//        self.des.hidden = NO;
//    } else {
//        self.des.hidden = YES;
//    }
}

@end
