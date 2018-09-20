//
//  ScanpaymentsuccessHead.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScanpaymentsuccessHead.h"

@interface ScanpaymentsuccessHead ()
@property (nonatomic, weak) UIImageView *back;

@end


@implementation ScanpaymentsuccessHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * back = [[UIImageView alloc]init];
        self.back = back;
        [self addSubview:back];
        
        UIImageView * icon = [[UIImageView alloc]init];
        self.icon = icon;
        [self addSubview:icon];
        
        UILabel * titlee = [[UILabel alloc]init];
        self.titlee = titlee;
        [self addSubview:titlee];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(40);
            make.height.equalTo(@(60*PROPORTION_WIDTH));
            make.width.equalTo(@(60*PROPORTION_WIDTH));
        }];

        [titlee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.icon);
            make.top.equalTo(self.icon.mas_bottom).offset(19*PROPORTION_HEIGHT);
        }];
        icon.image = [UIImage imageNamed:@"成功提现和充值"];
        titlee.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor  =ColorWithHex(0xD8D8D8,0.22);
        [icon SetContentModeScaleAspectFill];
        back.backgroundColor = [UIColor whiteColor];
        [titlee setWithColor:0x5E7FFF Alpha:1.0 Font:17 ROrM:@"r"];
        
    }
    return self;
}

@end
