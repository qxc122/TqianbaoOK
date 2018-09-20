//
//  AuthenticationCell.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AuthenticationCell.h"

@implementation AuthenticationCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    AuthenticationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            //            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(22);
            make.bottom.equalTo(self.contentView).offset(-22);
        }];

        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(30);
            make.right.equalTo(self.contentView).offset(-30);
            make.height.equalTo(@0.5f);
        }];
        
        [self.more mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.line);
            make.width.equalTo(@6);
            make.height.equalTo(@11);
        }];
    }
    return self;
}

@end
