//
//  AirListVcCell.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "AirListVcCell.h"


@interface AirListVcCell ()
@property (nonatomic,strong) UIImageView *head;
@property (nonatomic,strong) UIImageView *logo;
@property (nonatomic,strong) UILabel *airName;
@property (nonatomic,strong) UILabel *time;
@property (nonatomic,strong) UIView *bottom;

@property (nonatomic,strong) UILabel *star11;
@property (nonatomic,strong) UILabel *star1;
@property (nonatomic,strong) UILabel *starTime1;

@property (nonatomic,strong) UIImageView *air;

@property (nonatomic,strong) UILabel *star22;
@property (nonatomic,strong) UILabel *star2;
@property (nonatomic,strong) UILabel *starTime2;
@end

@implementation AirListVcCell

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    AirListVcCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[AirListVcCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            UIImageView *view = [[UIImageView alloc] init];
//            view.backgroundColor = [UIColor redColor];
            view.image = [UIImage imageNamed:@"航空公司背景"];
            [view SetContentModeScaleAspectFill];
//            view.contentMode = UIViewContentModeTop;
            [self.contentView addSubview:view];
            self.head = view;
            [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20);
                make.right.equalTo(self.contentView).offset(-20);
                make.top.equalTo(self.contentView);
                make.height.equalTo(@50);
            }];
        }
        {
            UIImageView *view = [[UIImageView alloc] init];
            view.image = [UIImage imageNamed:@"航空公司默认样式"];
            view.contentMode = UIViewContentModeScaleAspectFill;
            [self.contentView addSubview:view];
            self.logo = view;
            [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.head).offset(20);
                make.centerY.equalTo(self.head);
                make.width.equalTo(@31);
                make.height.equalTo(@31);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
//            label.text = @"中国联合航空公司";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
            label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
            self.airName = label;
            [self.contentView addSubview:label];
            [self.airName mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.logo.mas_right).offset(10);
                make.centerY.equalTo(self.head);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
//            label.text = @"2018-01-18";
            label.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
            label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
            self.time = label;
            [self.contentView addSubview:label];
            [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.airName.mas_right).offset(10);
                make.right.equalTo(self.head).offset(-20);
                make.centerY.equalTo(self.head);
            }];
        }
        {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
            self.bottom = view;
            [self.contentView addSubview:view];
            [self.bottom mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.head);
                make.right.equalTo(self.head);
                make.top.equalTo(self.head.mas_bottom);
                make.bottom.equalTo(self.contentView).offset(-20);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"始发站";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.star11 = label;
            [self.contentView addSubview:label];
            [self.star11 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.logo);
                make.top.equalTo(self.bottom).offset(15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
//            label.text = @"深圳宝安";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.star1 = label;
            [self.contentView addSubview:label];
            [self.star1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.logo);
                make.top.equalTo(self.star11.mas_bottom).offset(15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
//            label.text = @"09:30PM";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.starTime1 = label;
            [self.contentView addSubview:label];
            [self.starTime1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.logo);
                make.top.equalTo(self.star1.mas_bottom).offset(15);
                make.bottom.equalTo(self.bottom).offset(-15);
            }];
        }
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"到达站";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.star22 = label;
            [self.contentView addSubview:label];
            [self.star22 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.time);
                make.top.equalTo(self.bottom).offset(15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
//            label.text = @"三亚凤凰";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.star2 = label;
            [self.contentView addSubview:label];
            [self.star2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.time);
                make.top.equalTo(self.star22.mas_bottom).offset(15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
//            label.text = @"19:30PM";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.starTime2 = label;
            [self.contentView addSubview:label];
            [self.starTime2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.time);
                make.top.equalTo(self.star2.mas_bottom).offset(15);
                make.bottom.equalTo(self.bottom).offset(-15);
            }];
        }
        {
            UIImageView *view = [[UIImageView alloc] init];
//            view.image = [UIImage imageNamed:@"飞机图案"];
            [view SetContentModeScaleAspectFill];
            [self.contentView addSubview:view];
            self.air = view;
            [self.air mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20);
                make.right.equalTo(self.contentView).offset(-20);
                make.top.equalTo(self.star2);
                make.bottom.equalTo(self.starTime1.mas_top).offset(-5);
            }];
        }
    }
    return self;
}

- (void)setOne:(bankCard *)one{
    _one = one;
    self.airName.text = one.airName;
    self.time.text = one.depDate;
    self.starTime1.text = one.depTime;
    self.star1.text = one.depCityName;
    
    self.starTime2.text = one.arrTime;
    self.star2.text = one.arrCityName;

    [self.logo sd_setImageWithURL:one.airLogo placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
}
@end
