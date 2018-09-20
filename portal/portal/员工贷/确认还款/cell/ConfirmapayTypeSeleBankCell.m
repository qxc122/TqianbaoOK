//
//  ConfirmapayTypeSeleBankCell.m
//  portal
//
//  Created by Store on 2018/1/31.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "ConfirmapayTypeSeleBankCell.h"

@implementation ConfirmapayTypeSeleBankCell

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ConfirmapayTypeSeleBankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 422, 65, 15);
        label.text = @"还款账户";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        label.textColor = [UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(20);
        }];
            
        [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(20);
            make.width.equalTo(@(25*PROPORTION_WIDTH));
            make.height.equalTo(self.icon.mas_width);
            make.top.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
    }
    return self;
}

@end
