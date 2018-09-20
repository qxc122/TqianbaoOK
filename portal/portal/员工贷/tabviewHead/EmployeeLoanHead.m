//
//  EmployeeLoanHead.m
//  portal
//
//  Created by Store on 2018/1/29.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "EmployeeLoanHead.h"


@interface EmployeeLoanHead ()
@property (nonatomic,weak) UIImageView *head;

@end

@implementation EmployeeLoanHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            UIImageView *label = [[UIImageView alloc] init];
            label.image = [UIImage imageNamed:@"选中状态"];
            [self addSubview:label];
            self.head = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(20);
                make.centerX.equalTo(self);
                make.width.equalTo(@60);
                make.height.equalTo(@60);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"还款成功";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
            label.textColor = [UIColor colorWithRed:94/255.0 green:127/255.0 blue:255/255.0 alpha:1/1.0];
            [self addSubview:label];
            self.title = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.head.mas_bottom).offset(20);
                make.centerX.equalTo(self);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.hidden = YES;
            label.numberOfLines = 0;
            label.text = @"我们将会在2-5个工作日内处理\n您的申请，请您耐心等待！";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0];
            [self addSubview:label];
            self.des = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.title.mas_bottom).offset(20);
                make.centerX.equalTo(self);
            }];
        }
        {
            UIView *label = [[UIView alloc] init];
            label.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1/1.0];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self);
                make.height.equalTo(@10);
            }];
        }
    }
    return self;
}

@end
