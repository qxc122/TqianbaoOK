//
//  homeHead.m
//  portal
//
//  Created by Store on 2018/1/24.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeHead.h"

@interface homeHead ()

@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) UIButton *btn;
@end

@implementation homeHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
        {
            UIImageView *label = [[UIImageView alloc] init];
            [self addSubview:label];
            self.backPng = label;
            [label SetContentModeScaleAspectFill];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"腾邦集团";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
            label.textColor = [UIColor colorWithRed:213/255.0 green:175/255.0 blue:114/255.0 alpha:1/1.0];
            [self addSubview:label];
            self.label = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(60);
            }];
            label.hidden = YES;
        }
        {
            UIButton *label = [[UIButton alloc] init];
            [self addSubview:label];
            self.btn = label;
            [label SetFilletWith:34];
            [label setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"新人注册送福利" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"m" backColor:0x5E7FFF backAlpha:1.0];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self.label.mas_bottom).offset(15);
                make.width.equalTo(@135);
                make.height.equalTo(@34);
            }];
            label.hidden = YES;
        }
        {
            UIButton *label = [[UIButton alloc] init];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
            }];
            [label addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        }
//        [self.btn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)moreClick{
    NSLog(@"%s",__FUNCTION__);
    if (self.moreViewClick) {
        self.moreViewClick();
    }
}
- (void)setDataNew:(HomeDataNew *)dataNew{
    _dataNew = dataNew;
    if([dataNew.topPicture isKindOfClass:[NSURL class]]){
        [self.backPng sd_setImageWithURL:dataNew.topPicture];
    }
}
@end
