//
//  BankCardCell.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "BankCardCell.h"
#import "UIImageView+CornerRadius.h"

@interface BankCardCell ()
@property (nonatomic,weak) UIImageView *back;
//@property (nonatomic,weak) UIImageView *logoBack;
//@property (nonatomic,weak) UIImageView *logo;
//@property (nonatomic,weak) UILabel *BanKname;
@property (nonatomic,weak) UILabel *BanKId;


@property (nonatomic,weak) UIImageView *backBottom;
@property (nonatomic,weak) UIImageView *BottomIcon;
@property (nonatomic,weak) UILabel *BottomDes;
@end

@implementation BankCardCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *back = [UIImageView new];
        self.back = back;
        [self.contentView addSubview:back];
        
        UIImageView *backBottom = [UIImageView new];
        self.backBottom = backBottom;
        [self.contentView addSubview:backBottom];
        
        UIImageView *BottomIcon = [UIImageView new];
        self.BottomIcon = BottomIcon;
        [self.contentView addSubview:BottomIcon];
        
        UILabel *BottomDes = [UILabel new];
        self.BottomDes = BottomDes;
        [self.contentView addSubview:BottomDes];
        
        
//        UIImageView *logoBack = [UIImageView new];
//        self.logoBack = logoBack;
//        [self.contentView addSubview:logoBack];
//
//        UIImageView *logo = [UIImageView new];
//        self.logo = logo;
//        [self.contentView addSubview:logo];
//
//        UILabel *BanKname = [UILabel new];
//        self.BanKname = BanKname;
//        [self.contentView addSubview:BanKname];
        
        UILabel *BanKId = [UILabel new];
        self.BanKId = BanKId;
        [self.contentView addSubview:BanKId];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.height.equalTo(back.mas_width).multipliedBy(144/335.0);
        }];
//        self.logoBack.hidden= YES;
//        [self.logoBack mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.back).offset(20);
//            make.top.equalTo(self.back).offset(20);
//            make.height.equalTo(@36);
//            make.width.equalTo(logoBack.mas_height);
//        }];
//        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.back).offset(20);
//            make.right.equalTo(self.back).offset(-20);
//            make.top.equalTo(self.back).offset(20);
//            make.height.equalTo(@(30));
//        }];
        
//        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.logoBack).offset(3);
//            make.top.equalTo(self.logoBack).offset(3);
//            make.right.equalTo(self.logoBack).offset(-3);
//            make.bottom.equalTo(self.logoBack).offset(-3);
//        }];
//        [self.BanKname mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.logo);
//            make.left.equalTo(self.logoBack.mas_right).offset(10);
//            make.right.equalTo(self.back).offset(-20);
//        }];
//        [self.BanKId mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.logo.mas_bottom).offset(24);
//            make.bottom.equalTo(self.back).offset(-20);
//            make.left.equalTo(self.BanKname);
//            make.right.equalTo(self.BanKname);
//        }];
        
        [self.BanKId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.bottom.equalTo(self.backBottom.mas_top).offset(-10);
        }];
        [self.backBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.back);
            make.bottom.equalTo(self.back);
            make.height.equalTo(@30);
        }];
        [self.BottomIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backBottom).offset(20);
            make.centerY.equalTo(self.backBottom);
            make.height.equalTo(@10);
            make.width.equalTo(@10);
        }];
        [self.BottomDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.BottomIcon.mas_right).offset(2);
            make.right.equalTo(self.backBottom).offset(-20);
            make.centerY.equalTo(self.backBottom);
        }];
        self.BottomIcon.image = [UIImage imageNamed:@"支持图标 copy 2"];
        self.backBottom.image = [UIImage imageNamed:@"背景色02"];
        [self.BottomDes setWithColor:0xFDE8C2 Alpha:1.0 Font:10 ROrM:@"r"];
//        [logo zy_cornerRadiusRoundingRect]; 
//        [logoBack zy_cornerRadiusRoundingRect];
//        [back SetContentModeScaleAspectFill];
//        [back SetFilletWith:PICTURE_FILLET_SIZE];
//        back.image = ImageNamed(PIC_BANK_CARD_DEVELOPMENT);
//        [BanKname setWithColor:0x475468 Alpha:1.0 Font:17 ROrM:@"m"];
        [BanKId setWithColor:0xFFFFFF Alpha:1.0 Font:20 ROrM:@"r"];
//        BanKname.hidden = YES;
        self.BanKId.textAlignment = NSTextAlignmentRight;
        //tset
//        logo.image = [UIImage imageNamed:@"背景"];
//        BanKname.text = @"123123";
//        BanKId.text = @"123121231233";
    }
    return self;
}
- (void)setBankCarddata:(bankCard *)bankCarddata{
    _bankCarddata = bankCarddata;
    [self.back sd_setImageWithURL:bankCarddata.bigBankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
//    self.BanKname.text = bankCarddata.bankName;
    self.BanKId.text = bankCarddata.cardNo;
    self.BottomDes.text = bankCarddata.bindRemark;
}
@end
