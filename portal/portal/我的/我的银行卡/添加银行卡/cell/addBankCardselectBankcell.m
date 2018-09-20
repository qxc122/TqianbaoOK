//
//  addBankCard_selectBankcell.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "addBankCardselectBankcell.h"


@interface addBankCardselectBankcell ()
@property (nonatomic,weak) UIView *bank;

@property (nonatomic,weak) UIImageView *bankdirtion;
@property (nonatomic,weak) UILabel *bankName;
@property (nonatomic,weak) UIImageView *bankLogo;
@property (nonatomic,weak) UIButton *bankBtn;
@end

@implementation addBankCardselectBankcell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bank = [UIView new];
        self.bank = bank;
        [self.contentView addSubview:bank];
        
        UIImageView *bankdirtion = [UIImageView new];
        self.bankdirtion = bankdirtion;
        [self.bank addSubview:bankdirtion];
        
        UILabel *bankName = [UILabel new];
        self.bankName = bankName;
        [self.bank addSubview:bankName];
        
        UIImageView *bankLogo = [UIImageView new];
        self.bankLogo = bankLogo;
        [self.bank addSubview:bankLogo];
        
        UIButton *bankBtn = [UIButton new];
        self.bankBtn = bankBtn;
        [self.bank addSubview:bankBtn];
        
        [bank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bankLogo);
            make.right.equalTo(self.bankdirtion);
            make.bottom.equalTo(self.bankLogo);
            make.top.equalTo(self.bankLogo);
        }];
        [bankdirtion mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.line);
            make.centerY.equalTo(self.title);
            make.width.equalTo(@(8));
            make.height.equalTo(@(4));
        }];
        [bankName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bankdirtion.mas_left).offset(-10);
            make.centerY.equalTo(self.title);
        }];
        [bankLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bankName.mas_left).offset(-10);
            make.centerY.equalTo(self.title);
            make.width.equalTo(@(25));
            make.height.equalTo(@(25));
        }];
        [bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bankLogo);
            make.right.equalTo(self.bankdirtion);
            make.centerY.equalTo(self.bankLogo);
            make.height.equalTo(@(44));
        }];

        [bankBtn addTarget:self action:@selector(bankBtnClick) forControlEvents:UIControlEventTouchUpInside];
        bankdirtion.contentMode = UIViewContentModeScaleAspectFill;
        bankLogo.contentMode = UIViewContentModeScaleAspectFill;
        [bankLogo zy_cornerRadiusRoundingRect];
//        [bankName setWithColor:NORMOL_BLACK Alpha:1.0 Font:15 ROrM:@"r"];
        bankdirtion.image = [UIImage imageNamed:PIC_MORE_BANKS];
        self.input.hidden = YES;
        [self resetBankName];
    }
    return self;
}
- (void)bankBtnClick{
    NSLog(@"%s",__FUNCTION__);
    if (self.selectBank) {
        self.selectBank();
    }
}
- (void)setBankCarddata:(bankCard *)bankCarddata{
    _bankCarddata = bankCarddata;
    if (bankCarddata) {
        [self.bankLogo sd_setImageWithURL:bankCarddata.bankIcon];
//        [self.bankLogo sd_setImageWithURL:bankCarddata.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
        self.bankName.text = bankCarddata.bankName;
        [self.bankName setWithColor:NORMOL_BLACK Alpha:1.0 Font:15 ROrM:@"r"];
    }else{
        [self resetBankName];
    }
}
- (void)resetBankName{
    self.bankLogo.image = nil;
    self.bankName.text = @"请选择银行";
    [self.bankName setWithColor:0x9DA4AE Alpha:1.0 Font:15 ROrM:@"r"];
}
@end
