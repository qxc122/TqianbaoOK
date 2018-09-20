//
//  ScanpaymentsuccessHasIconCell.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScanpaymentsuccessHasIconCell.h"

@interface ScanpaymentsuccessHasIconCell ()

@end

@implementation ScanpaymentsuccessHasIconCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ScanpaymentsuccessHasIconCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.backgroundColor = [UIColor clearColor];
        UIImageView *desIcon = [UIImageView new];
        self.desIcon = desIcon;
        [self.contentView addSubview:desIcon];

        [desIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(20);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
        }];
        [self.des mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.desIcon.mas_right).offset(5);
            make.centerY.equalTo(self.contentView);
        }];
        [self.des setWithColor:0x1E2E47 Alpha:1.0 Font:15 ROrM:@"r"];
    }
    return self;
}
@end
