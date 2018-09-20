//
//  topCell.m
//  portal
//
//  Created by MiNi on 2018/7/18.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "topCell.h"

@interface topCell ()
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIImageView *more;
@end

@implementation topCell

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    topCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[topCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:254/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
            self.title = label;
            [self.contentView addSubview:label];
//            label.text = @"sdf";
        }
        {
            UIImageView *icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"通知图标"];
            self.icon = icon;
            [self.contentView addSubview:icon];
        }
        {
            UIImageView *more = [[UIImageView alloc] init];
            more.image = [UIImage imageNamed:@"前往图标01"];
            self.more = more;
            [self.contentView addSubview:more];
        }
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@13);
            make.height.equalTo(@12);
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(7);
            make.right.equalTo(self.more.mas_left).offset(-7);
            make.top.equalTo(self.contentView).offset(9);
            make.bottom.equalTo(self.contentView).offset(-9);
            make.centerY.equalTo(self.contentView);
        }];
        [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@6);
            make.height.equalTo(@11);
        }];
    }
    return self;
}

- (void)setMynoticeData:(noticeData *)MynoticeData{
    _MynoticeData = MynoticeData;
    self.title.text = MynoticeData.title;
}

@end
