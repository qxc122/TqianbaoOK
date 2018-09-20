//
//  BaoturnIn.m
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BaoturnIn.h"


@interface BaoturnIn ()<UITextFieldDelegate>

@end

@implementation BaoturnIn
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    BaoturnIn *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.top.equalTo(self.back).offset(20);
        }];
        [self.money mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.width.equalTo(@21);
//            make.height.equalTo(@27);
            make.top.equalTo(self.title.mas_bottom).offset(20);
        }];
        [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.money.mas_right).offset(25);
            make.right.equalTo(self.contentView).offset(-84);
//            make.height.equalTo(@27);
            make.bottom.equalTo(self.money);
        }];
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.right.equalTo(self.back).offset(-20);
            make.top.equalTo(self.money.mas_bottom).offset(10);
            make.height.equalTo(@(0.5));
        }];
        [self.des mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.right.equalTo(self.line);
            make.top.equalTo(self.line.mas_bottom).offset(20);
            make.bottom.equalTo(self.back.mas_bottom).offset(-20);
        }];
        self.des.font = PingFangSC_Regular(12);
        {
            UIButton *btn = [UIButton new];
            self.btnALL = btn;
            [self.contentView addSubview:btn];
            [self.btnALL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.input.mas_right);
                make.right.equalTo(self.contentView);
                make.centerY.equalTo(self.money);
                make.height.equalTo(@44);
            }];
            [self.btnALL setWithNormalColor:0x5E81FF NormalAlpha:1.0 NormalTitle:@"全部转出" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0.0];
            [self.btnALL addTarget:self action:@selector(btnALLClick) forControlEvents:UIControlEventTouchUpInside];

        }
    }
    return self;
}
- (void)btnALLClick{
    if ([self.PayMethodData.acctBal doubleValue] > 0) {
        [self.input setWithColor:0x475468 Alpha:1.0 Font:38 ROrM:@"r"];
        self.input.text = [NSString stringWithFormat:@"%.2f",[self.PayMethodData.acctBal doubleValue]];
        [self setTextIN];
        if (self.Fill_in_the_text) {
            self.Fill_in_the_text(self.input.text);
        }
//        if ([self.input.text doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
//            self.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
//            self.des.text = @"输入金额超出账户余额";
//        }else{
//            self.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
//            self.des.text = [NSString stringWithFormat:@"本次最多可转出 %.2f",[self.PayMethodData.acctBal doubleValue]];
//        }
    }else{
        [MBProgressHUD showPrompt:@"没有可转出的金额"];
    }
}

- (void)setTextIN{
    [super setTextIN];
    if (self.Outtype.length) {
//        if ([self.input.text doubleValue] == 0) {
//            self.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
//            self.des.text = [NSString stringWithFormat:@"本次最多可转出 %.2f",[self.PayMethodData.acctBal doubleValue]];
//        } else if ([self.input.text doubleValue] > 0 && [self.input.text doubleValue] <= [self.PayMethodData.acctBal doubleValue]) {
//            self.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
//            ThreeOkBankOne *one;
//            for (ThreeOkBankOne *oneBank in self.PayMethodData.bankCards) {
//                one = oneBank;
//                break;
//            }
//            if ([one.singleLimit doubleValue] != -1) {
//                if ([one.singleLimit doubleValue] >= [self.input.text doubleValue]) {
//                    if ([self.Outtype isEqualToString:@"0"]) {
//                        self.des.text = [NSString stringWithFormat:@"快速到帐今日还可转出 %.2f元",([one.singleLimit doubleValue] - [self.input.text doubleValue])];
//                    } else if ([self.Outtype isEqualToString:@"1"]) {
//                        self.des.text = [NSString stringWithFormat:@"普通到帐今日还可转出 %.2f元",([one.singleLimit doubleValue] - [self.input.text doubleValue])];
//
//                    }
//                } else {
//                    self.des.text = @"输入金额超出银行卡限额";
//                }
//            }else{
//                self.des.text = [NSString stringWithFormat:@"您还可以转出 %.2f",([self.PayMethodData.acctBal doubleValue] - [self.input.text doubleValue])];
//            }
//
//        } else if ([self.input.text doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
//            self.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
//            self.des.text = @"输入金额超出账户余额";
//        }
        
        if ([self.input.text doubleValue] > [self.PayMethodData.acctBal doubleValue]) {
            self.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
            self.des.text = @"输入金额超出账户余额";
        }else if ([self.Outtype isEqualToString:@"1"] && [self.input.text doubleValue] > [self.PayMethodData.todayFastOuLimit doubleValue]){
            self.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
            self.des.text = [NSString stringWithFormat:@"快速到账今日还可提现 %.2f元",[self.PayMethodData.todayFastOuLimit doubleValue]];
        }else{
            self.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
            self.des.text = [NSString stringWithFormat:@"本次最多可转出 %.2f",[self.PayMethodData.acctBal doubleValue]];
        }
    }else{
        ThreeOkBankOne *one;
        for (ThreeOkBankOne *oneBank in self.PayMethodData.bankCards) {
            one = oneBank;
            break;
        }
        if ([self.input.text doubleValue] > [one.singleLimit doubleValue] && [one.singleLimit doubleValue] > 0) {
            self.des.textColor = [UIColor colorWithRed:244/255.0 green:51/255.0 blue:60/255.0 alpha:1/1.0];
            self.des.text = @"输入金额超限";
        }else{
            NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
            NSAttributedString *title = [@"预计收益到账时间" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x3A4554, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
            [all appendAttributedString:title];
            
            if (self.PayMethodData.incomeArrDate.length) {
                NSAttributedString *title = [self.PayMethodData.incomeArrDate CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
                [all appendAttributedString:title];
            }
            self.des.attributedText = all;
        }
    }
}
- (void)setPayMethodData:(tpTreasurequeryPayMethod *)PayMethodData{
    _PayMethodData  = PayMethodData;
    [self PayMethodData];
}
@end
