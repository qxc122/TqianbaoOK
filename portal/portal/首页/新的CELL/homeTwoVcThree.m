//
//  homeTwoVcThree.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcThree.h"


@interface homeTwoVcThree ()

@end

@implementation homeTwoVcThree

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    homeTwoVcThree *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[homeTwoVcThree alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            UIView *imageView = [[UIView alloc] init];
            imageView.backgroundColor = ColorWithHex(0xF7F8FA, 1.0);
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView);
                make.top.equalTo(self.contentView);
                make.height.equalTo(@10);
            }];
        }
        
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"新手体验金.png"];
            [self.contentView addSubview:imageView];
            self.dian = imageView;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
                    make.top.equalTo(self.contentView).offset(34);
                }else{
                    make.top.equalTo(self.contentView).offset(24);
                }
                make.left.equalTo(self.contentView).offset(20);
                make.width.equalTo(@8);
                make.height.equalTo(@9);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"新手体验金";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.title = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.dian);
                make.left.equalTo(self.dian.mas_right).offset(10);
            }];
        }
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"已领取图标.png"];
            [self.contentView addSubview:imageView];
            self.stare = imageView;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(10);
                make.right.equalTo(self.contentView);
                make.width.equalTo(@51);
                make.height.equalTo(@62);
            }];
        }
        {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
            [self.contentView addSubview:view];
            self.line = view;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.title.mas_bottom).offset(20);
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView);
                make.height.equalTo(@0.5);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"888";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
            label.textColor = [UIColor colorWithRed:254/255.0 green:109/255.0 blue:77/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.money = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line.mas_bottom).offset(20);
                make.left.equalTo(self.dian);
                make.height.equalTo(@22);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"元";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.5];
            [self.contentView addSubview:label];
            self.moneyYuan = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.money);
                make.left.equalTo(self.money.mas_right).offset(5);
                make.height.equalTo(@12);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"免费持有7天";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.time = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.moneyYuan);
                make.right.equalTo(self.contentView).offset(-20);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"年化收益高达10%";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.5];
            [self.contentView addSubview:label];
            self.shouyi = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.money.mas_bottom).offset(10);
                make.left.equalTo(self.dian);
                make.bottom.equalTo(self.contentView).offset(-20);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"平台提供资金，收益归你";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.5];
            [self.contentView addSubview:label];
            self.des = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.shouyi);
                make.right.equalTo(self.contentView).offset(-20);
            }];
        }
    }
    return self;
}

@end
