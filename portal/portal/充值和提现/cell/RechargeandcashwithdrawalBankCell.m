//
//  RechargeandcashwithdrawalBankCell.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RechargeandcashwithdrawalBankCell.h"



@interface RechargeandcashwithdrawalBankCell ()


@end

@implementation RechargeandcashwithdrawalBankCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    RechargeandcashwithdrawalBankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        
        UIImageView *Banklogo = [UIImageView new];
        self.Banklogo = Banklogo;
        [self.contentView addSubview:Banklogo];
        
        UILabel *BankName = [UILabel new];
        self.BankName = BankName;
        [self.contentView addSubview:BankName];
        
        UILabel *BankNumber = [UILabel new];
        self.BankNumber = BankNumber;
        [self.contentView addSubview:BankNumber];
        
        UIImageView *more = [UIImageView new];
        self.more = more;
        [self.contentView addSubview:more];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView);
        }];
        [Banklogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.top.equalTo(self.back).offset(25);
            make.centerY.equalTo(self.back);
            make.height.equalTo(@(30*PROPORTION_WIDTH));
            make.width.equalTo(@(30*PROPORTION_WIDTH));
        }];
        [BankName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Banklogo.mas_right).offset(20);
            make.top.equalTo(self.back).offset(19);
        }];
        [BankNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.BankName);
            make.bottom.equalTo(self.back).offset(-19);
        }];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.back).offset(-20);
            make.centerY.equalTo(self.back);
            make.width.equalTo(@(7));
            make.height.equalTo(@(12));
        }];
        back.backgroundColor = [UIColor whiteColor];
        [Banklogo SetFilletWith:30*PROPORTION_WIDTH];
        [more SetContentModeScaleAspectFill];
        [Banklogo SetContentModeScaleAspectFill];
        
        [BankName setWithColor:0x475468 Alpha:1.0 Font:16 ROrM:@"r"];
        [BankNumber setWithColor:0x9DA4AE Alpha:1.0 Font:12 ROrM:@"r"];
        self.more.hidden = YES;
        more.image = [UIImage imageNamed:@"更多"];

        
        //tes
//        Banklogo.image = [UIImage imageNamed:@"背景"];
//        BankName.text = @"sdf";
//        BankNumber.text = @"sdf";
    }
    return self;
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    for (bankCard *one in userData.Arry_list) {
        if ([one.type isEqualToString:HOME_TYPE_BANK]) {
            [self.Banklogo sd_setImageWithURL:one.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
            self.BankName.text = one.bankName;
            if (one.cardNo.length >=4) {
                self.BankNumber.text = [NSString stringWithFormat:@"(%@)",[@"尾号" stringByAppendingString:[one.cardNo substringFromIndex:one.cardNo.length-4]]];
            }
            break;
        }
    }
}

- (void)setThreeOkData:(ThreeOk *)ThreeOkData{
    _ThreeOkData = ThreeOkData;
    for (ThreeOkBankOne *one in ThreeOkData.bankCardsArray) {
        [self.Banklogo sd_setImageWithURL:one.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
        self.BankName.text = one.bankName;
        if (one.cardNo.length >=4) {
            self.BankNumber.text = [NSString stringWithFormat:@"(%@)",[@"尾号" stringByAppendingString:[one.cardNo substringFromIndex:one.cardNo.length-4]]];
        }
        break;
    }
}
- (void)setConductfinancialtransactionsData:(Conductfinancialtransactions *)ConductfinancialtransactionsData{
    _ConductfinancialtransactionsData = ConductfinancialtransactionsData;
    if([self.type isEqualToString:@"TPURSE"]){
        self.Banklogo.image = [UIImage imageNamed:@"理财余额"];
        self.BankName.text = @"零钱";
        self.BankNumber.text = [NSString stringWithFormat:@"%@ %.2f元",@"可用金额",[ConductfinancialtransactionsData.tpurseAcctBal doubleValue]];
    }else{
        [self.Banklogo sd_setImageWithURL:ConductfinancialtransactionsData.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
        self.BankName.text = ConductfinancialtransactionsData.bankName;
        if(![ConductfinancialtransactionsData.cardNo hasPrefix:@"尾号"]){
            self.BankNumber.text = [NSString stringWithFormat:@"(%@)",[@"尾号" stringByAppendingString:ConductfinancialtransactionsData.cardNo]];
        }else{
            self.BankNumber.text = ConductfinancialtransactionsData.cardNo;
        }
    }
}
- (void)setOneBank:(ThreeOkBankOne *)oneBank{
    _oneBank = oneBank;
    [self.Banklogo sd_setImageWithURL:oneBank.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
    if ([oneBank.singleLimit doubleValue]>0) {
        self.BankName.text = [NSString stringWithFormat:@"%@ %@",oneBank.bankName,[NSString stringWithFormat:@"(%@)",[@"尾号" stringByAppendingString:oneBank.cardNo]]];
        self.BankNumber.text = [NSString stringWithFormat:@"该卡单笔最多可转入%.2f元",[oneBank.singleLimit doubleValue]];
    } else {
        self.BankName.text = oneBank.bankName;
        self.BankNumber.text = [NSString stringWithFormat:@"(%@)",[@"尾号" stringByAppendingString:oneBank.cardNo]];
    }
}
@end
