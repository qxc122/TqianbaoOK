//
//  payTypeSeleBankCell.m
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "payTypeSeleBankCell.h"


@interface payTypeSeleBankCell ()

@end


@implementation payTypeSeleBankCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    payTypeSeleBankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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

        UIImageView *icon = [UIImageView new];
        self.icon = icon;
        [self.contentView addSubview:icon];
        
        UILabel *title = [[UILabel alloc]initWithColor:0x161E2B Alpha:1.0 Font:16 ROrM:@"r"];
        self.title = title;
        [self.contentView addSubview:title];
        
        UIImageView *hook = [UIImageView new];
        self.hook = hook;
        [self.contentView addSubview:hook];
        
        UIView *line = [UIView new];
        self.line = line;
        [self.contentView addSubview:line];

        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.width.equalTo(@(25*PROPORTION_WIDTH));
            make.height.equalTo(icon.mas_width);
            make.top.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(15);
            make.centerY.equalTo(self.icon);
        }];
        
        [hook mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.icon);
            make.right.equalTo(self.line);
            make.width.equalTo(@18);
            make.height.equalTo(@12);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-20);
            make.left.equalTo(self.contentView).offset(20);
            make.height.equalTo(@0.5f);
        }];
        //set
        line.backgroundColor = COLOUR_LINE_NORMAL;
        [hook SetContentModeScaleAspectFill];
        [icon SetContentModeScaleAspectFill];
        [icon SetFilletWith:25*PROPORTION_WIDTH];
        hook.highlightedImage = [UIImage imageNamed:@"选择"];
        
//        icon.image = [UIImage imageNamed:PIC_CELL_MORE];
//        hook.highlightedImage = [UIImage imageNamed:PIC_CELL_MORE];
//        title.text = @"sdf";
    }
    return self;
}
- (void)setScanQRCodeBankOne:(scanQRCodeBankOne *)scanQRCodeBankOne{
    _scanQRCodeBankOne = scanQRCodeBankOne;
    [self.icon sd_setImageWithURL:scanQRCodeBankOne.bankIcon placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
    self.title.text = [NSString stringWithFormat:@"%@(%ld)",scanQRCodeBankOne.bankName,[scanQRCodeBankOne.bankNo integerValue]];
}
- (void)setThreeOkBankOne:(ThreeOkBankOne *)threeOkBankOne{
    _threeOkBankOne = threeOkBankOne;
    [self.icon sd_setImageWithURL:threeOkBankOne.bankIcon placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
    if (threeOkBankOne.cardNo.length >=4) {
        self.title.text = [NSString stringWithFormat:@"%@(%@)",threeOkBankOne.bankName,[threeOkBankOne.cardNo substringFromIndex:(threeOkBankOne.cardNo.length-4)]];
    }
}
- (void)setConductfinancialtransactionsData:(Conductfinancialtransactions *)ConductfinancialtransactionsData{
    _ConductfinancialtransactionsData = ConductfinancialtransactionsData;
    [self.icon sd_setImageWithURL:ConductfinancialtransactionsData.bankIcon placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
    if (ConductfinancialtransactionsData.cardNo.length >=4) {
        self.title.text = [NSString stringWithFormat:@"%@(%@)",ConductfinancialtransactionsData.bankName,[ConductfinancialtransactionsData.cardNo substringFromIndex:(ConductfinancialtransactionsData.cardNo.length-4)]];
    }
}
@end
