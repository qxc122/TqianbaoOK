//
//  ScansuccessChangeTypeCell.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScansuccessChangeTypeCell.h"



@interface ScansuccessChangeTypeCell ()
@property (nonatomic, weak) UIView *back;


@end

@implementation ScansuccessChangeTypeCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ScansuccessChangeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.backgroundColor = ColorWithHex(0xD8D8D8, 0.25);
        UIView * back = [[UIView alloc]init];
        self.back = back;
        [self.contentView addSubview:back];
        
        UIImageView * icon = [[UIImageView alloc]init];
        self.icon = icon;
        [self.contentView addSubview:icon];
        
        UIImageView * more = [[UIImageView alloc]init];
        self.more = more;
        [self.contentView addSubview:more];
        
        UILabel * title = [[UILabel alloc]init];
        self.title = title;
        [self.contentView addSubview:title];
        UILabel * des = [[UILabel alloc]init];
        self.des = des;
        [self.contentView addSubview:des];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.width.equalTo(@25);
            make.height.equalTo(@25);
            make.top.equalTo(self.back).offset(26);
            make.bottom.equalTo(self.back).offset(-26);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(10);
            make.bottom.equalTo(self.mas_centerY).offset(-5);
        }];
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.top.equalTo(self.mas_centerY).offset(5);
        }];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-20);
            make.width.equalTo(@7);
            make.height.equalTo(@11);
            make.centerY.equalTo(self.contentView);
        }];
        back.backgroundColor = [UIColor whiteColor];
        [icon SetContentModeScaleAspectFill];
        
        [title setWithColor:0x3A4554 Alpha:1.0 Font:15 ROrM:@"r"];
        [des setWithColor:0x9DA4AE Alpha:1.0 Font:12 ROrM:@"r"];
        self.more.image = [UIImage imageNamed:@"更多"];
        title.text = @"零钱";
        des.text = @"付款金额";
    }
    return self;
}
- (void)setScanQRCodeOkdata:(scanQRCodeOk *)scanQRCodeOkdata{
    _scanQRCodeOkdata = scanQRCodeOkdata;
    if (self.isBank) {
        self.title.text = @"银行卡";
        for (scanQRCodeBankOne *one in scanQRCodeOkdata.bankCardArray) {
            [self.icon sd_setImageWithURL:one.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
            self.des.text = [NSString stringWithFormat:@"%@(%ld)",one.bankName,[one.bankNo integerValue]];
            break;
        }
    } else {
        self.icon.image = [UIImage imageNamed:@"理财余额"];
        self.title.text = @"零钱";
        self.des.text = [NSString stringWithFormat:@"%@ %@元",@"可用金额",scanQRCodeOkdata.acctBal];
    }
//    self.name.text = scanQRCodeOkdata.payeeName;
//    [self.icon sd_setImageWithURL:scanQRCodeOkdata.payeeLogo placeholderImage:ImageNamed(SD_HEAD_ALTERNATIVE_PICTURES)];
}
@end
