//
//  cashwithdrawalSuccessHead.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "cashwithdrawalSuccessHead.h"


@interface cashwithdrawalSuccessHead ()

@end


@implementation cashwithdrawalSuccessHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * back = [[UIImageView alloc]init];
        self.back = back;
        [self addSubview:back];
        
        UIView * LineTop = [[UIView alloc]init];
        self.LineTop = LineTop;
        [self addSubview:LineTop];
        
        UIImageView * iconTop = [[UIImageView alloc]init];
        self.iconTop = iconTop;
        [self addSubview:iconTop];
        
        UILabel * titleTop = [[UILabel alloc]init];
        self.titleTop = titleTop;
        [self addSubview:titleTop];
        UILabel * DateTop = [[UILabel alloc]init];
        self.DateTop = DateTop;
        [self addSubview:DateTop];
        
        
        UIView * LineBottom = [[UIView alloc]init];
        self.LineBottom = LineBottom;
        [self addSubview:LineBottom];
        
        UIImageView * iconBottom = [[UIImageView alloc]init];
        self.iconBottom = iconBottom;
        [self addSubview:iconBottom];
        
        UILabel * titleBottom = [[UILabel alloc]init];
        self.titleBottom = titleBottom;
        [self addSubview:titleBottom];
        UILabel * DateBottom = [[UILabel alloc]init];
        self.DateBottom = DateBottom;
        [self addSubview:DateBottom];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        [iconTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self).offset(30);
            make.height.equalTo(@(30));
            make.width.equalTo(@(30));
        }];
        
        [LineTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(iconTop);
            make.top.equalTo(iconTop);
            make.height.equalTo(@(30+25));
            make.width.equalTo(@(4));
        }];
        
        [titleTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconTop.mas_right).offset(10);
            make.top.equalTo(iconTop);
        }];
        [DateTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleTop);
            make.top.equalTo(titleTop.mas_bottom).offset(10);
        }];
        
        [iconBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.bottom.equalTo(LineBottom);
            make.height.equalTo(@(30));
            make.width.equalTo(@(30));
        }];
        
        [LineBottom  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(LineTop);
            make.top.equalTo(LineTop.mas_bottom);
            make.height.equalTo(@(30+25));
            make.width.equalTo(@(4));
        }];
        
        [titleBottom  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconBottom.mas_right).offset(10);
            make.top.equalTo(iconBottom);
        }];
        [DateBottom  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBottom);
            make.top.equalTo(titleBottom.mas_bottom).offset(10);
        }];
        LineTop.backgroundColor = ColorWithHex(0x5E7FFF, 1.0);
        LineBottom.backgroundColor = ColorWithHex(0xB1B6CB, 1.0);
        
        [iconTop SetContentModeScaleAspectFill];
        [iconBottom SetContentModeScaleAspectFill];

        [titleTop setWithColor:0x5E7FFF Alpha:1.0 Font:17 ROrM:@"r"];
        [titleBottom setWithColor:0x38416A Alpha:1.0 Font:17 ROrM:@"r"];
        
        [DateTop setWithColor:0x5C6896 Alpha:1.0 Font:12 ROrM:@"r"];
        [DateBottom setWithColor:0x5C6896 Alpha:1.0 Font:12 ROrM:@"r"];
        
        iconTop.image = [UIImage imageNamed:@"成功提现和充值"];
        LineTop.backgroundColor = ColorWithHex(0x05E7FFF, 1.0);
        
        iconBottom.image = [UIImage imageNamed:@"预计到账时间"];
        LineBottom.backgroundColor = ColorWithHex(0xB1B6CB , 1.0);
        
        iconTop.backgroundColor = [UIColor whiteColor];
        iconBottom.backgroundColor = [UIColor whiteColor];
        
        titleTop.text = @"提现申请已提交";
        titleBottom.text = @"预计到账时间";
        
        self.back.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = ColorWithHex(0xD8D8D8, 1.0);

        
//        DateTop.text = @"sdfsdfsdf";
//        DateBottom.text = @"sdf";
    }
    return self;
}
- (void)setData:(Successincashwithdrawal *)data{
    _data = data;
    self.DateTop.text = [NSString stringWithFormat:@"%@",data.applyDatetime];
    self.DateBottom.text = data.estimateArrDatetime;
}
@end
