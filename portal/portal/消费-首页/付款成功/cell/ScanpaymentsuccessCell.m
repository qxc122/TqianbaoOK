//
//  ScanpaymentsuccessCell.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScanpaymentsuccessCell.h"

@interface ScanpaymentsuccessCell ()

@end

@implementation ScanpaymentsuccessCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ScanpaymentsuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        
        UILabel *title = [UILabel new];
        self.title = title;
        [self.contentView addSubview:title];

        
        UILabel *des = [UILabel new];
        self.des = des;
        [self.contentView addSubview:des];
        
        UIView *line = [UIView new];
        self.line = line;
        [self.contentView addSubview:line];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@64);
        }];
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(20);
            make.centerY.equalTo(self.contentView);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(60);
            make.height.equalTo(@0.5);
        }];
        line.backgroundColor = COLOUR_LINE_NORMALTWO;
        [title setWithColor:0x9DA4AE Alpha:1.0 Font:14 ROrM:@"r"];
    }
    return self;
}
- (void)setDataScan:(setUpData *)dataScan{
    _dataScan = dataScan;
    self.title.text = dataScan.title;
}
@end
