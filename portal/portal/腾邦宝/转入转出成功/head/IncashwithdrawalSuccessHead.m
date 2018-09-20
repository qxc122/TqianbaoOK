//
//  IncashwithdrawalSuccessHead.m
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "IncashwithdrawalSuccessHead.h"


@interface IncashwithdrawalSuccessHead ()
@property (nonatomic, weak) UIImageView *iconMidle;

@property (nonatomic, weak) UILabel *titleMidle;
@property (nonatomic, weak) UILabel *DateMidle;
@end


@implementation IncashwithdrawalSuccessHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * iconTop = [[UIImageView alloc]init];
        self.iconMidle = iconTop;
        [self addSubview:iconTop];
        
        UILabel * titleTop = [[UILabel alloc]init];
        self.titleMidle = titleTop;
        [self addSubview:titleTop];
        
        UILabel * DateTop = [[UILabel alloc]init];
        self.DateMidle = DateTop;
        [self addSubview:DateTop];

        [self.LineBottom  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.LineTop);
            make.top.equalTo(self.LineTop.mas_bottom);
            make.height.equalTo(@(30+25+26+25+26));
            make.width.equalTo(@(4));
        }];
        
        [self.iconMidle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self.LineTop.mas_bottom).offset(25);
            make.height.equalTo(@(30));
            make.width.equalTo(@(30));
        }];

        [self.titleMidle  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconTop.mas_right).offset(10);
            make.top.equalTo(iconTop);
        }];
        [self.DateMidle  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleTop);
            make.top.equalTo(titleTop.mas_bottom).offset(10);
        }];

        [iconTop SetContentModeScaleAspectFill];
        [titleTop setWithColor:0x5E7FFF Alpha:1.0 Font:17 ROrM:@"r"];
        [DateTop setWithColor:0x5C6896 Alpha:1.0 Font:12 ROrM:@"r"];
        iconTop.image = [UIImage imageNamed:@"成功提现和充值"];
        self.iconMidle.backgroundColor = [UIColor whiteColor];

        titleTop.text = @"开始计算收益时间";
//        DateTop.text = @"提现申请已提交";
        self.titleTop.text = @"开始计算收益时间";
        
        {
            UIImageView *tmp = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"充值成功图标"]];
            [self addSubview:tmp];
            [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.iconTop);
                make.top.equalTo(self.iconTop);
                make.right.equalTo(self.iconBottom);
                make.bottom.equalTo(self.iconBottom);
            }];
        }
        self.iconTop.hidden = YES;
        self.iconMidle.hidden = YES;
        self.iconBottom.hidden = YES;
    }
    return self;
}

- (void)setOutORINSuccessdata:(outORINSuccess *)outORINSuccessdata{
    _outORINSuccessdata = outORINSuccessdata;
    self.titleTop.text = [NSString stringWithFormat:@"成功转入 %@元",self.outORINSuccessdata.price];
    self.DateTop.text = @"今天";
    
    self.titleMidle.text = @"开始计算收益时间";
    self.DateMidle.text = outORINSuccessdata.calDate;
    
    self.titleBottom.text = @"收益到账时间";
    self.DateBottom.text = outORINSuccessdata.arrDate;
}
@end
