//
//  BankCardDisplay.m
//  portal
//
//  Created by Store on 2017/10/10.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "BankCardDisplay.h"
#import "BankViewShow.h"

@interface BankCardDisplay ()
@property (nonatomic,weak) BankViewShow *bank;
@end

@implementation BankCardDisplay
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        BankViewShow *bank = [[BankViewShow alloc]init];
        bank.back.image = [UIImage imageNamed:@"银行卡展开"];
        self.bank = bank;
        [self.contentView addSubview:bank];
        [self.bank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView).offset(130*PROPORTION_HEIGHT);
            make.height.mas_equalTo(self.bank.mas_width).multipliedBy(190/335.0);
        }];
    }
    return self;
}
- (void)setBankCardOne:(bankCard *)bankCardOne{
    _bankCardOne= bankCardOne;
    self.bank.bankCardOne = bankCardOne;
}
@end
