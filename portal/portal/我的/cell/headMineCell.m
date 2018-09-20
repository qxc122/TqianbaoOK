//
//  headMineCell.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "headMineCell.h"
#import "UIImage+Add.h"
#import "NSString+Add.h"
@interface headMineCell ()
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UIView *staueBack;

@property (nonatomic,weak) UIImageView *staueBackPng;

@property (nonatomic,weak) UIButton *staue;
@property (nonatomic,weak) UIImageView *more;
@end

@implementation headMineCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
        
//        UIView *view = [[UIView alloc] init];
//        view.frame = CGRectMake(0, 0, 375, 66);
//        view.backgroundColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];

        
        UIImageView *icon = [UIImageView new];
        self.icon = icon;
        [self.contentView addSubview:icon];
        
        UILabel *name = [UILabel new];
        self.name = name;
        [self.contentView addSubview:name];
        
        UIView *staueBack = [UIView new];
        self.staueBack = staueBack;
        [self.contentView addSubview:staueBack];
        
        UIButton *staue = [UIButton new];
        self.staue = staue;
        [self.staueBack addSubview:staue];
        
        UIImageView *staueBackPng = [UIImageView new];
        self.staueBackPng = staueBackPng;
        [self.contentView addSubview:staueBackPng];
        
        
        UIImageView *more = [UIImageView new];
        self.more = more;
        [self.contentView addSubview:more];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(28);
            make.bottom.equalTo(self.contentView).offset(-30);
            make.width.equalTo(@(50));
            make.height.equalTo(icon.mas_width);
        }];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(15);
            make.top.equalTo(self.icon).offset(7);
            make.right.equalTo(self.more.mas_left).offset(-15);
        }];
        
        [self.staueBackPng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name);
            make.top.equalTo(self.name.mas_bottom).offset(8);
            make.width.equalTo(@(40));
            make.height.equalTo(@18);
        }];
        
        
        [self.staueBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name);
            make.right.equalTo(self.staue).offset(5);
            make.bottom.equalTo(self.icon);
            make.height.equalTo(@18);
        }];
        
        [self.staue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name).offset(5);
            make.centerY.equalTo(self.staueBack);
            make.height.equalTo(@44);
//            make.width.equalTo(@100);
        }];

        [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-20);
            make.width.equalTo(@6);
            make.height.equalTo(@11);
        }];
        [more SetContentModeScaleAspectFill];
        [icon SetContentModeScaleAspectFill];
        icon.layer.cornerRadius = 50*PROPORTION_WIDTH*0.5;
        icon.layer.masksToBounds = YES;
        [staueBack SetFilletWith:18];
        
        more.image = [UIImage imageNamed:PIC_CELL_MORE];
        

        [name setWithColor:0xE3BF7C Alpha:1.0 Font:16 ROrM:@"m"];
        [staue setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"未实名", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:NSLocalizedString(@"已实名", @"") SelectedImage:nil SelectedBackImage:nil Font:10 NormalROrM:@"r" backColor:0x0 backAlpha:0.0];
        staueBack.backgroundColor = ColorWithHex(0xF8D492, 1.0); 
        [staue addTarget:self action:@selector(staueClick) forControlEvents:UIControlEventTouchUpInside];
//        staueBack.hidden = YES;
//        staue.hidden = YES;
        
        self.staueBack.hidden = YES;
        self.staue.hidden = YES;
        self.staueBackPng.hidden = YES;
    }
    return self;
}
- (void)staueClick{
    NSLog(@"%s",__func__);
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    if (userData) {
        self.staue.selected = [userData.realFlag isEqualToString:STRING_1];
        if ([userData.realFlag isEqualToString:STRING_1]) {
            self.staueBack.backgroundColor = ColorWithHex(0xF8D492, 1.0);
            self.staueBackPng.image = [UIImage imageNamed:@"已实名图标"];
        } else if ([userData.realFlag isEqualToString:STRING_0]) {
            self.staueBackPng.image = [UIImage imageNamed:@"未实名图标"];
            self.staueBack.backgroundColor = ColorWithHex(0x1E2E47, 1.0);
        }
        self.staueBackPng.hidden = NO;
//        self.staueBack.hidden = NO;
//        self.staue.hidden = NO;
        [self.icon sd_setImageWithURL:userData.headUrl placeholderImage:ImageNamed(@"头像")];
        self.name.text = (userData.nickname&&userData.nickname.length)?userData.nickname:userData.mobile;
    } else {
        self.staueBackPng.hidden = YES;
//        self.staueBack.hidden = YES;
        self.icon.image = [UIImage imageNamed:@"头像"];
        self.name.text = NSLocalizedString(@"未登录", @"");
    }
}
@end
