//
//  homeTwoVcFour.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcFour.h"



@interface homeTwoVcFour ()
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UILabel *shouyi;
@property (nonatomic,weak) UILabel *shouyiJia;
@property (nonatomic,weak) UILabel *time;
@property (nonatomic,weak) UILabel *shouyiDes;
@property (nonatomic,weak) UILabel *timeDes;
@end

@implementation homeTwoVcFour

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    homeTwoVcFour *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[homeTwoVcFour alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
            [self.contentView addSubview:view];
            self.line = view;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView);
                make.height.equalTo(@0.5);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"9.20%";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:25];
            label.textColor = [UIColor colorWithRed:254/255.0 green:109/255.0 blue:77/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.shouyi = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line.mas_bottom).offset(20);
                make.left.equalTo(self.contentView).offset(20);
                make.height.equalTo(@22);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"+1.2%";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
            label.textColor = [UIColor colorWithRed:240/255.0 green:53/255.0 blue:55/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.shouyiJia = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shouyi.mas_right).offset(10);
                make.bottom.equalTo(self.shouyi);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"12个月";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1.0];
            [self.contentView addSubview:label];
            self.time = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-20);
                make.centerY.equalTo(self.shouyiJia);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"往期年化收益率";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.5];
            [self.contentView addSubview:label];
            self.shouyiDes = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.shouyi.mas_bottom).offset(10);
                make.bottom.equalTo(self.contentView).offset(-20);
                make.left.equalTo(self.shouyi);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"等额本息";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.5];
            [self.contentView addSubview:label];
            self.timeDes = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.shouyiDes);
                make.right.equalTo(self.time);
            }];
        }
    }
    return self;
}
- (void)setOne:(prgInfosOne *)one{
    _one = one;
    self.shouyi.text = one.prgRate;
    self.shouyiJia.text = one.increaseRate;
    self.time.text = one.period;
    self.timeDes.text = one.repayMod;
//    0-一次性还本付息 1-每月付息到期还本  2-等额本息 4-等额本金 5-等本等息
    
//    if ([one.repayMod isEqualToString:@"0"]) {
//        self.timeDes.text = @"一次性还本付息";
//    } else if ([one.repayMod isEqualToString:@"1"]) {
//        self.timeDes.text = @"每月付息到期还本";
//    } else if ([one.repayMod isEqualToString:@"2"]) {
//        self.timeDes.text = @"等额本息";
//    } else if ([one.repayMod isEqualToString:@"4"]) {
//        self.timeDes.text = @"等额本金";
//    } else if ([one.repayMod isEqualToString:@"5"]) {
//        self.timeDes.text = @"等本等息";
//    }
//    if ([one.period containsString:@"个月"]) {
//        self.time.text = one.period;
//    } else {
//        self.time.text = [NSString stringWithFormat:@"%@个月",one.period];
//    }
}
@end
