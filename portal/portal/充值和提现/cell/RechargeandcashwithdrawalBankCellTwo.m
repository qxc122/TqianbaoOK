//
//  RechargeandcashwithdrawalBankCellTwo.m
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "RechargeandcashwithdrawalBankCellTwo.h"


@interface RechargeandcashwithdrawalBankCellTwo ()


@end

@implementation RechargeandcashwithdrawalBankCellTwo
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    RechargeandcashwithdrawalBankCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        [self.BankName setWithColor:0x475468 Alpha:1.0 Font:16 ROrM:@"r"];
        [self.BankNumber setWithColor:0x475468 Alpha:1.0 Font:16 ROrM:@"r"];
        self.backgroundColor = ColorWithHex(0xF7F8FA, 1.0);
        [self.Banklogo mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.top.equalTo(self.back).offset(25);
            make.centerY.equalTo(self.back);
            make.height.equalTo(@(30*PROPORTION_WIDTH));
            make.width.equalTo(@(30*PROPORTION_WIDTH));
        }];
        [self.BankName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Banklogo.mas_right).offset(10);
            make.centerY.equalTo(self.Banklogo);
        }];
        [self.BankNumber mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.BankName.mas_right).offset(5);
            make.centerY.equalTo(self.BankName);
        }];
        [self.more mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.back).offset(-20);
            make.centerY.equalTo(self.Banklogo);
            make.width.equalTo(@(7));
            make.height.equalTo(@(12));
        }];
    }
    return self;
}

@end
