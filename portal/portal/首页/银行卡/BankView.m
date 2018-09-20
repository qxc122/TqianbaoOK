//
//  BankView.m
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "BankView.h"


@interface BankView ()

@end

@implementation BankView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *back = [[UIImageView alloc]init];
        self.back = back;
        [self addSubview:back];

        UIImageView *logo = [[UIImageView alloc]init];
        self.logo = logo;
        [self addSubview:logo];
        
        UILabel *cardNumber = [[UILabel alloc]init];
        self.cardNumber = cardNumber;
        [self addSubview:cardNumber];

        UIButton *btn = [[UIButton alloc]init];
        [self addSubview:btn];
        
        [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.top.equalTo(self);
        }];
        
        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20+20);
            make.right.equalTo(self.back).offset(-20-20);
            make.top.equalTo(self.back).offset(20);
            make.height.equalTo(@(30));
        }];

        [self.cardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.top.equalTo(self.logo.mas_bottom);
            make.bottom.equalTo(self).offset(-4);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.top.equalTo(self);
        }];
        [btn addTarget:self action:@selector(btnClickTagg) forControlEvents:UIControlEventTouchUpInside];
        self.back.contentMode = UIViewContentModeTop;
        self.back.clipsToBounds = YES;
        
        [back SetContentModeScaleAspectFill];
        cardNumber.textAlignment = NSTextAlignmentCenter;
        [cardNumber setWithColor:0x899097 Alpha:1.0 Font:24 ROrM:@"r"];
//        self.logo.contentMode = UIViewContentModeTopLeft;
        self.logo.clipsToBounds = YES;
        
        self.back.image = [UIImage imageNamed:PIC_HOME_HOME_BANK_CARD];
    }
    return self;
}
- (void)btnClickTagg{
    if (self.UIViewClick) {
        self.UIViewClick(self.bankCardOne,self.tagg);
    }
}
- (void)setBankCardOne:(bankCard *)bankCardOne{
    _bankCardOne = bankCardOne;
    self.cardNumber.text  =bankCardOne.cardNo;
    [self.logo sd_setImageWithURL:bankCardOne.bigBankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
}
@end
