//
//  homeTwoVcFourHead.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcFourHead.h"
#import "MAsonry.h"

@interface homeTwoVcFourHead ()
@property (nonatomic, weak) UIImageView *logo;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *des;
@property (nonatomic, weak) UIImageView *moreIcon;

@property (nonatomic, weak) UIButton *more;
@end

@implementation homeTwoVcFourHead
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"精选定期理财.png"];
            [self addSubview:imageView];
            self.logo = imageView;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(20);
                make.width.equalTo(@8);
                make.height.equalTo(@9);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"精选定期理财";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1.0];
            [self addSubview:label];
            self.title = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self.logo.mas_right).offset(10);
            }];

        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"上市公司背景，收益高";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.5];
            [self addSubview:label];
            self.des = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-37);
            }];
        }
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"更多.png"];
            [self addSubview:imageView];
            self.moreIcon = imageView;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self.des.mas_right).offset(10);
                make.width.equalTo(@6);
                make.height.equalTo(@11);
            }];
        }
        UIButton *imageView = [[UIButton alloc] init];
        [self addSubview:imageView];
        self.more = imageView;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
        [imageView addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)moreClick{
    if (self.moreViewClick) {
        self.moreViewClick();
    }
}
@end
