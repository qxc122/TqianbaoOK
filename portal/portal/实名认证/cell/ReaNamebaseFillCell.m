//
//  ReaNamebaseFillCell.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ReaNamebaseFillCell.h"

@implementation ReaNamebaseFillCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ReaNamebaseFillCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.right.equalTo(self.contentView).offset(-30);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(60);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

@end
