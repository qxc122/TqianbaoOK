//
//  oneHome.m
//  portal
//
//  Created by Store on 2018/1/24.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "oneHome.h"

@interface oneHome ()
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIImageView *backPng;
@end

@implementation oneHome
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"定期.png"];
            self.icon = imageView;
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(20);
                make.centerX.equalTo(self);
                make.width.equalTo(@23);
                make.height.equalTo(@23);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(30, 228, 24, 12);
            label.text = @"定期";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            self.title = label;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.icon.mas_bottom).offset(10);
                make.centerX.equalTo(self);
            }];
        }
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            self.backPng = imageView;
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(19);
                make.left.equalTo(self.icon.mas_right).offset(2);
                make.height.equalTo(@16);
            }];
        }
        UIButton *imageView = [[UIButton alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.icon);
            make.bottom.equalTo(self.title);
            make.left.equalTo(self.title);
            make.right.equalTo(self.title);
        }];
        [imageView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)btnClick{
    if (self.doneClick) {
        self.doneClick(self.one);
    }
}
- (void)setOne:(oneHomeData *)one{
    _one = one;
    self.icon.image = [UIImage imageNamed:one.icon];
    self.title.text = one.title;
    self.backPng.image = [UIImage imageNamed:one.redPoint];
}
@end
