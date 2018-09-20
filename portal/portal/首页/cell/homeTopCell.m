//
//  homeTopCell.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "homeTopCell.h"
#import "HeaderAll.h"


@interface homeTopCell ()
@property (nonatomic,weak) UIImageView *backTop;
@property (nonatomic,weak) UIView *backBottom;

@property (nonatomic,weak) UIButton *Recharge;
@property (nonatomic,weak) UIButton *WithdrawCash;
@property (nonatomic,weak) UIButton *consumption;

@property (nonatomic,weak) UIView *login;
@property (nonatomic,weak) UILabel *moneydes;
@property (nonatomic,weak) UILabel *money;
@property (nonatomic,weak) UIButton *chagestaue;

@property (nonatomic,weak) UIView *logOut;
@property (nonatomic,weak) UILabel *logOutdes;
@property (nonatomic,weak) UIButton *logOutBtn;

@property (nonatomic,weak) UIImageView *LeftMore;
@property (nonatomic,weak) UILabel *LeftLabelTop;
@property (nonatomic,weak) UILabel *LeftLabelBottom;
@property (nonatomic,weak) UIButton *LeftBtn;

@property (nonatomic,weak) UIView *suLine;

@property (nonatomic,weak) UIImageView *RightMore;
@property (nonatomic,weak) UILabel *RightLabelTop;
@property (nonatomic,weak) UILabel *RightLabelBottom;
@property (nonatomic,weak) UIButton *RightBtn;
@end

@implementation homeTopCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *backTop = [UIImageView new];
        self.backTop = backTop;
        [self.contentView addSubview:backTop];

        UIView *backBottom = [UIView new];
        self.backBottom = backBottom;
        [self.contentView addSubview:backBottom];

        UIButton *Recharge = [UIButton new];
        self.Recharge = Recharge;
        [self.contentView addSubview:Recharge];

        UIButton *WithdrawCash = [UIButton new];
        self.WithdrawCash = WithdrawCash;
        [self.contentView addSubview:WithdrawCash];

        UIButton *consumption = [UIButton new];
        self.consumption = consumption;
        [self.contentView addSubview:consumption];

        UIView *login = [UIView new];
        self.login = login;
        [self.contentView addSubview:login];
        
        UILabel *moneydes = [UILabel new];
        self.moneydes = moneydes;
        [self.login addSubview:moneydes];
        
        UIButton *chagestaue = [UIButton new];
        self.chagestaue = chagestaue;
        [self.login addSubview:chagestaue];
        
        
        UILabel *money = [UILabel new];
        self.money = money;
        [self.login addSubview:money];

        UIView *logOut = [UIView new];
        self.logOut = logOut;
        [self.contentView addSubview:logOut];
        
        UILabel *logOutdes = [UILabel new];
        self.logOutdes = logOutdes;
        [self.logOut addSubview:logOutdes];
        
        UIButton *logOutBtn = [UIButton new];
        self.logOutBtn = logOutBtn;
        [self.logOut addSubview:logOutBtn];
        
        UIImageView *LeftMore = [UIImageView new];
        self.LeftMore = LeftMore;
        [self.contentView addSubview:LeftMore];
        
        UILabel *LeftLabelTop = [UILabel new];
        self.LeftLabelTop = LeftLabelTop;
        [self.contentView addSubview:LeftLabelTop];
        
        UILabel *LeftLabelBottom = [UILabel new];
        self.LeftLabelBottom = LeftLabelBottom;
        [self.contentView addSubview:LeftLabelBottom];
        
        UIButton *LeftBtn = [UIButton new];
        self.LeftBtn = LeftBtn;
        [self.contentView addSubview:LeftBtn];
        
        UIView *suLine = [UIView new];
        self.suLine = suLine;
        [self.contentView addSubview:suLine];
        
        UIImageView *RightMore = [UIImageView new];
        self.RightMore = RightMore;
        [self.contentView addSubview:RightMore];
        
        UILabel *RightLabelTop = [UILabel new];
        self.RightLabelTop = RightLabelTop;
        [self.contentView addSubview:RightLabelTop];
        
        UILabel *RightLabelBottom = [UILabel new];
        self.RightLabelBottom = RightLabelBottom;
        [self.contentView addSubview:RightLabelBottom];
        
        UIButton *RightBtn = [UIButton new];
        self.RightBtn = RightBtn;
        [self.contentView addSubview:RightBtn];

        [backTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentView).offset(-0);
            make.top.equalTo(self.contentView);
            make.height.equalTo(backTop.mas_width).multipliedBy(250/375.0);
        }];
        [backBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentView).offset(-0);
            make.top.equalTo(self.backTop.mas_bottom);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.height.equalTo(@80);
        }];
        CGFloat tmp = 20;
        if (IPoneX) {
            tmp += 20;
        }
        [self.Recharge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backTop).offset(20.5);
            make.top.equalTo(self.backTop).offset(tmp);
            make.height.equalTo(@44);
        }];
        [self.WithdrawCash mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Recharge.mas_right).offset(20.5);
            make.top.equalTo(self.Recharge);
            make.height.equalTo(self.Recharge);
        }];
        [self.consumption mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backTop).offset(-20.5);
            make.top.equalTo(self.Recharge);
            make.height.equalTo(self.Recharge);
        }];
        [self.moneydes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backTop);
            make.top.equalTo(self.Recharge.mas_bottom).offset(60.5*PROPORTION_HEIGHT);
        }];
        [self.chagestaue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneydes.mas_right).offset(-8);
            make.centerY.equalTo(self.moneydes);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
        }];
        
        [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backTop);
            make.top.equalTo(self.moneydes.mas_bottom).offset(3*PROPORTION_HEIGHT);
        }];
        [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.moneydes);
            make.bottom.equalTo(self.money);
        }];
        
        [self.logOutdes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backTop);
            make.top.equalTo(self.Recharge.mas_bottom).offset(60.5*PROPORTION_HEIGHT);
        }];
        [self.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backTop);
            make.top.equalTo(self.logOutdes.mas_bottom).offset(20);
            make.height.equalTo(@40);
            make.width.equalTo(@90);
        }];
        [self.logOut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.logOutdes);
            make.bottom.equalTo(self.logOutBtn);
        }];
        
        [self.suLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backBottom).offset(16);
            make.bottom.equalTo(self.backBottom).offset(-16);
            make.centerX.equalTo(self.backBottom);
            make.width.equalTo(@0.5);
        }];
        [self.LeftLabelTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backBottom).offset(20);
            make.left.equalTo(self.backBottom);
            make.right.equalTo(self.suLine.mas_left);
        }];
        [self.LeftLabelBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.LeftLabelTop.mas_bottom).offset(9);
            make.centerX.equalTo(self.LeftLabelTop);
            make.height.equalTo(@14);
        }];
        [self.LeftMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.LeftLabelBottom);
            make.left.equalTo(self.LeftLabelBottom.mas_right).offset(5);
            make.width.equalTo(@6);
            make.height.equalTo(@6);
        }];
        [self.LeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.LeftLabelTop);
            make.bottom.equalTo(self.LeftLabelBottom);
            make.right.equalTo(self.LeftLabelBottom);
            make.left.equalTo(self.LeftLabelBottom);
        }];
        
        [self.RightLabelTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backBottom).offset(20);
            make.right.equalTo(self.backBottom);
            make.left.equalTo(self.suLine.mas_right);
        }];
        [self.RightLabelBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.RightLabelTop.mas_bottom).offset(9);
            make.centerX.equalTo(self.RightLabelTop);
            make.height.equalTo(@14);
        }];
        [self.RightMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.RightLabelBottom);
            make.left.equalTo(self.RightLabelBottom.mas_right).offset(5);
            make.width.equalTo(@6);
            make.height.equalTo(@6);
        }];
        [self.RightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.RightLabelTop);
            make.bottom.equalTo(self.RightLabelBottom);
            make.right.equalTo(self.RightLabelBottom);
            make.left.equalTo(self.RightLabelBottom);
        }];
        suLine.backgroundColor = COLOUR_LINE_NORMAL;
        self.backBottom.backgroundColor = [UIColor whiteColor];
        self.LeftLabelTop.textAlignment = NSTextAlignmentCenter;
        self.RightLabelTop.textAlignment = NSTextAlignmentCenter;
        [self.backTop SetContentModeScaleAspectFill];
        [self.LeftMore SetContentModeScaleAspectFill];
        [self.RightMore SetContentModeScaleAspectFill];
        [self.moneydes setWithColor:0x776E5D Alpha:1.0 Font:12 ROrM:@"m"];
        [self.money setWithColor:0xE3BF7C Alpha:1.0 Font:40 ROrM:@"m"];

        [self.LeftLabelTop setWithColor:0x1E2E47 Alpha:1.0 Font:18 ROrM:@"m"];
        [self.LeftLabelBottom setWithColor:0x1E2E47 Alpha:1.0 Font:14 ROrM:@"r"];
        
        [self.RightLabelTop setWithColor:0x1E2E47 Alpha:1.0 Font:18 ROrM:@"m"];
        [self.RightLabelBottom setWithColor:0x1E2E47 Alpha:1.0 Font:14 ROrM:@"r"];
        [self.logOutdes setWithColor:0xE3BF7C Alpha:1.0 Font:14 ROrM:@"r"];
        self.logOutdes.text = @"优质债权,平均收益高达8.2%";
        [self.Recharge setWithNormalColor:0xE3BF7C NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"  充值", @"") NormalImage:PIC_HOME_RECHARGE NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];

        [self.WithdrawCash setWithNormalColor:0xE3BF7C NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"  提现", @"") NormalImage:PIC_HOME_WITHDRAWALS NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        
        [self.consumption setWithNormalColor:0xE3BF7C NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"  收付款", @"") NormalImage:PIC_HOME_CONSUMPTION NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [self.logOutBtn setWithNormalColor:0xE3BF7C NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"立即投资", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:16 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [self.logOutBtn SetBordersWith:0.5 Color:ColorWithHex(0xE3BF7C, 0.5)];
        [self.logOutBtn SetFilletWith:8.0];
        
        [self.chagestaue setWithNormalColor:0xE3BF7C NormalAlpha:0 NormalTitle:nil NormalImage:@"显示" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:@"隐藏" SelectedBackImage:nil Font:16 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [self.chagestaue addTarget:self action:@selector(chagestaueclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.Recharge addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.WithdrawCash addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.consumption addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.LeftBtn addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.RightBtn addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.logOutBtn addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
        self.Recharge.tag = homeTopCellType_Recharge;
        self.WithdrawCash.tag = homeTopCellType_WithdrawCash;
        self.consumption.tag = homeTopCellType_consumption;
        self.LeftBtn.tag = homeTopCellType_balance;
        self.RightBtn.tag = homeTopCellType_Financial_gold;
        self.logOutBtn.tag = homeTopCellType_Immediate_investment;
        backTop.image = [UIImage imageNamed:PIC_HOME_BACKGROUND_MAP];
        LeftMore.image = [UIImage imageNamed:PIC_HOME_LOWER_RIGHT_CORNER];
        RightMore.image = [UIImage imageNamed:PIC_HOME_LOWER_RIGHT_CORNER];
        LeftLabelBottom.text = @"零钱";
        RightLabelBottom.text = @"理财";
        moneydes.text = @"总资产(元)";
        //tset
        [self reset];
        self.login.hidden = YES;
        self.logOut.hidden = YES;
        self.consumption.hidden = YES;
        setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
        if ([setUp_dataBlock.staue isEqualToString:@"1"]) {
            chagestaue.selected = NO;
        } else {
            chagestaue.selected = YES;
        }
    }
    return self;
}
-(void)setlabel{
    if (self.chagestaue.selected) {
        self.money.text = @"****";
        self.LeftLabelTop.text = @"****";
        self.RightLabelTop.text = @"****";
    } else {
        self.money.text = [NSString stringWithFormat:@"%.2f",[self.userData.totalAsset doubleValue]];
        self.LeftLabelTop.text = [NSString stringWithFormat:@"%.2f",[self.userData.acctBal doubleValue]];
        self.RightLabelTop.text = [NSString stringWithFormat:@"%.2f",[self.userData.finaAsset doubleValue]];
    }
}
- (void)chagestaueclick:(UIButton *)btn{
    btn.selected = !btn.selected;
    setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
    setUp_dataBlock.staue = btn.selected?@"0":@"1";
    [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
    [self setlabel];
}
- (void)Btnclick:(UIButton *)btn{
    if (self.ClicBtnTag) {
        self.ClicBtnTag(btn.tag);
    }
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    if (userData) {
        self.login.hidden = NO;
        self.logOut.hidden = YES;
//        self.money.text = [NSString stringWithFormat:@"%.2f",[userData.totalAsset doubleValue]];
//        self.LeftLabelTop.text = [NSString stringWithFormat:@"%.2f",[userData.acctBal doubleValue]];
//        self.RightLabelTop.text = [NSString stringWithFormat:@"%.2f",[userData.finaAsset doubleValue]];
        [self setlabel];
    } else {
        [self reset];
        self.login.hidden = YES;
        self.logOut.hidden = NO;
    }
}
- (void)reset{
    self.money.text = @"--";
    self.LeftLabelTop.text = @"--";
    self.RightLabelTop.text = @"--";
}
@end
