//
//  headRechargeandCell.m
//  portal
//
//  Created by Store on 2017/12/8.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "headRechargeandCell.h"



@interface headRechargeandCell ()
@property (nonatomic,weak) UIImageView *Png;

@end

@implementation headRechargeandCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    headRechargeandCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = ColorWithHex(0xF7F8FA, 1.0);
        UIImageView *Png = [UIImageView new];
        self.Png = Png;
        [self.contentView addSubview:Png];
        
        UILabel *left = [UILabel new];
        self.left = left;
        [self.contentView addSubview:left];
        
        UILabel *right = [UILabel new];
        self.right = right;
        [self.contentView addSubview:right];
        

        [Png mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@(25));
            make.height.equalTo(@(25));
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.right.equalTo(self.Png.mas_left).offset(-30);
        }];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.Png.mas_right).offset(30);
        }];
        
        Png.image = [UIImage imageNamed:@"转出"];
        [Png SetContentModeScaleAspectFill];
        left.textAlignment = NSTextAlignmentCenter;
        right.textAlignment = NSTextAlignmentCenter;
        [left setWithColor:0x3A4554 Alpha:1.0 Font:15 ROrM:@"r"];
        [right setWithColor:0x3A4554 Alpha:1.0 Font:15 ROrM:@"r"];
        
    }
    return self;
}
@end
