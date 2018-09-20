//
//  ThirdpartypaymentindesignTypeCell.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ThirdpartypaymentindesignTypeCell.h"


@interface ThirdpartypaymentindesignTypeCell ()
@property (nonatomic, weak) UIView *line;
@end

@implementation ThirdpartypaymentindesignTypeCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ThirdpartypaymentindesignTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        UIView * line = [[UIView alloc]init];
        self.line = line;
        [self.contentView addSubview:line];

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.height.equalTo(@0.5);
        }];

        line.backgroundColor  =ColorWithHex(0xE9EBEE, 1.0);

    }
    return self;
}
- (void)setThreeOkdata:(ThreeOk *)ThreeOkdata{
    _ThreeOkdata = ThreeOkdata;
    if (self.one) {
        self.title.text = @"银行卡";
        [self.icon sd_setImageWithURL:self.one.bankIcon placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
        if (self.one.cardNo.length >=4) {
            self.des.text = [NSString stringWithFormat:@"%@(%@)",self.one.bankName,[self.one.cardNo substringFromIndex:(self.one.cardNo.length-4)]];
        }
    } else {
        self.icon.image = [UIImage imageNamed:@"理财余额"];
        self.title.text = @"零钱";
        if (self.isOA) {
            self.des.text = [NSString stringWithFormat:@"%@ %.2f元",@"可用金额",[ThreeOkdata.cashAcctBal doubleValue]];
        } else {
            self.des.text = [NSString stringWithFormat:@"%@ %.2f元",@"可用金额",[ThreeOkdata.acctBal doubleValue]];
        }
    }
}
@end
