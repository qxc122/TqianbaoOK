//
//  RechargeandcashwithdrawalSuccessVc.m
//  portal
//
//  Created by Store on 2017/10/19.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RechargeandcashwithdrawalSuccessVc.h"

@interface RechargeandcashwithdrawalSuccessVc ()
@property (nonatomic,weak) UIImageView *okImg;
@property (nonatomic,weak) UILabel *desLabel;
@property (nonatomic,weak) UILabel *moneyLabel;
@property (nonatomic,weak) UIButton *back;
@end

@implementation RechargeandcashwithdrawalSuccessVc
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUI];
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        self.title = @"充值";
        self.desLabel.text = @"成功充值";
    } else if (self.stateMoney == RechargeandcashwithdrawalVcState_WithdrawCash) {
        self.title = @"提现";
        self.desLabel.text = @"成功提现";
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"%@%@",self.Money,@"元"];
}
- (void)customBackButton
{
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)SetUI{
    UIImageView *okImg = [UIImageView new];
    self.okImg  =okImg;
    [self.view addSubview:okImg];
    
    UILabel *desLabel = [UILabel new];
    self.desLabel  =desLabel;
    [self.view addSubview:desLabel];
    UILabel *moneyLabel = [UILabel new];
    self.moneyLabel  =moneyLabel;
    [self.view addSubview:moneyLabel];
    
    UIButton *back = [UIButton new];
    self.back  =back;
    [self.view addSubview:back];
    
    [okImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40*PROPORTION_HEIGHT);
        make.width.equalTo(@(60*PROPORTION_WIDTH));
        make.height.equalTo(okImg.mas_width);
    }];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.okImg.mas_bottom).offset(20*PROPORTION_HEIGHT);
    }];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.desLabel.mas_bottom).offset(20*PROPORTION_HEIGHT);
    }];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(87*PROPORTION_HEIGHT);
        make.height.equalTo(@50);
    }];
    okImg.image = [UIImage imageNamed:PIC_SUCCESSFUL_CASH_RETRIEVAL_AND_RECHARGE];
    [okImg SetFilletWith:60*PROPORTION_WIDTH];
    [okImg SetContentModeScaleAspectFill];
    [moneyLabel setWithColor:0x1E2E47 Alpha:1.0 Font:30 ROrM:@"m"];
    [desLabel setWithColor:0x5E7FFF Alpha:1.0 Font:10 ROrM:@"r"];

    [back setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"返回" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [back setBackgroundImage:[ColorWithHex(0x5E7FFF, 1.0) imageWithColor] forState:UIControlStateNormal];
    
    [back addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
}
@end
