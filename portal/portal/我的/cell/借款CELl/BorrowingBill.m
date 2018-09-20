//
//  BorrowingBill.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BorrowingBill.h"

@interface BorrowingBill ()

@end

@implementation BorrowingBill

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    BorrowingBill *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[BorrowingBill alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"我的借款"];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(20);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
        self.icon = imageView;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"我的借款";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(16);
            make.centerY.equalTo(self.icon);
        }];
        self.title = label;
        
        {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = ColorWithHex(0xEEEEEE, 1.0);
            [self.contentView addSubview:view];
            self.line = view;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView);
                make.top.equalTo(self.title.mas_bottom).offset(21);
                make.bottom.equalTo(self.contentView).offset(-21);
                make.height.equalTo(@0.5);
            }];
        }
    }
    return self;
}

@end
