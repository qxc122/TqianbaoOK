//
//  payTypeSeleMoneyCell.m
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "payTypeSeleMoneyCell.h"


@interface payTypeSeleMoneyCell ()

@end


@implementation payTypeSeleMoneyCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    payTypeSeleMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        UILabel *des = [[UILabel alloc]initWithColor:0x858E9B Alpha:1.0 Font:12 ROrM:@"r"];
        self.des = des;
        [self.contentView addSubview:des];
        self.icon.highlightedImage = [UIImage imageNamed:@"零钱图标-不可点击"];
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(15);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(-4);
        }];
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.top.equalTo(self.contentView.mas_centerY).offset(4);
        }];
        //set
//        des.text = @"sasdfasdfasdfdf";
    }
    return self;
}
- (void)setScanQRCodeokdata:(scanQRCodeOk *)scanQRCodeokdata{
    _scanQRCodeokdata = scanQRCodeokdata;
    self.icon.image = [UIImage imageNamed:@"理财余额"];
    self.title.text = @"零钱";
    self.des.text = [NSString stringWithFormat:@"%@ %@元",@"可用金额",scanQRCodeokdata.acctBal];
}
- (void)setThreeOkdata:(ThreeOk *)ThreeOkdata{
    _ThreeOkdata = ThreeOkdata;
    self.icon.image = [UIImage imageNamed:@"理财余额"];
    self.title.text = @"零钱";
    self.des.text = [NSString stringWithFormat:@"%@ %.2f元",@"可用金额",[ThreeOkdata.acctBal doubleValue]];
}
- (void)setConductfinancialtransactionsData:(Conductfinancialtransactions *)ConductfinancialtransactionsData{
    self.icon.image = [UIImage imageNamed:@"理财余额"];
    self.title.text = @"零钱";
    self.des.text = [NSString stringWithFormat:@"%@ %.2f元",@"可用金额",[ConductfinancialtransactionsData.tpurseAcctBal doubleValue]];
}

@end
