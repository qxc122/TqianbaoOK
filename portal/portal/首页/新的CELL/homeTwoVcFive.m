//
//  homeTwoVcFive.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcFive.h"



@interface homeTwoVcFive ()
@property (nonatomic, weak) UIImageView *logo;
@property (nonatomic, weak) UILabel *title;

@property (nonatomic,weak) UIView *line;

@property (nonatomic,weak) UILabel *time;
@property (nonatomic,weak) UILabel *shouyiDes;
@property (nonatomic,weak) UILabel *timeDes;
@end

@implementation homeTwoVcFive

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    homeTwoVcFive *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[homeTwoVcFive alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"货币基金.png"];
            [self.contentView addSubview:imageView];
            self.logo = imageView;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(23);
                make.left.equalTo(self.contentView).offset(20);
                make.width.equalTo(@8);
                make.height.equalTo(@9);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"货币基金";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.title = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.logo);
                make.left.equalTo(self.logo.mas_right).offset(10);
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
            label.text = @"--";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:25];
            label.textColor = [UIColor colorWithRed:255/255.0 green:129/255.0 blue:54/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.shouyi = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line.mas_bottom).offset(20);
                make.left.equalTo(self.logo);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"平安 大华基金";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            [self.contentView addSubview:label];
            self.time = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-20);
                make.centerY.equalTo(self.shouyi);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"预期年化收益率";
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
            label.text = @"随存随取，收益不停歇";
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

@end
