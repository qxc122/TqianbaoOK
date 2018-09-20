//
//  payTypeSeleTicon.m
//  portal
//
//  Created by MiNi on 2018/5/10.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "payTypeSeleTicon.h"

@implementation payTypeSeleTicon

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.close setImage:[UIImage imageNamed:@"反回按钮"] forState:UIControlStateNormal];
        [self.blcak setBackgroundImage:[ColorWithHex(0xFFFFFF, 0.0) imageWithColor] forState:UIControlStateNormal];
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@(378));
        }];
        self.title.text = @"选择付款方式";
    }
    return self;
}
#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        kWeakSelf(self);
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([payTypeSeleBankCell class]) configuration:^(id cell) {
            [weakself configurepayTypeSeleBankCell:cell atIndexPath:indexPath];
        }];
    } else {
        kWeakSelf(self);
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([payTypeSeleMoneyCell class]) configuration:^(id cell) {
            [weakself configurepayTypeSeleMoneyCell:cell atIndexPath:indexPath];
        }];
    }
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        payTypeSeleMoneyCell *cell = [payTypeSeleMoneyCell returnCellWith:tableView];
        [self configurepayTypeSeleMoneyCell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        payTypeSeleBankCell *cell = [payTypeSeleBankCell returnCellWith:tableView];
        [self configurepayTypeSeleBankCell:cell atIndexPath:indexPath];
        return  cell;
    }
}

#pragma --mark< 配置payTypeSeleMoneyCell 的数据>
- (void)configurepayTypeSeleMoneyCell:(payTypeSeleMoneyCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if (self.isSuportBAL) {
        cell.title.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
        cell.des.textColor = [UIColor colorWithRed:133/255.0 green:142/255.0 blue:155/255.0 alpha:1/1.0];
        cell.icon.highlighted = NO;
        [super configurepayTypeSeleMoneyCell:cell atIndexPath:indexPath];
    } else {
        cell.icon.highlighted = YES;
        cell.title.text = @"零钱";
        cell.des.text = @"余额不足";
        cell.title.textColor = [UIColor colorWithRed:160/255.0 green:166/255.0 blue:173/255.0 alpha:1/1.0];
        cell.des.textColor = [UIColor colorWithRed:160/255.0 green:166/255.0 blue:173/255.0 alpha:1/1.0];
    }
    if ([self.payMethod isEqualToString:@"BAL"]) {
        UIImageView *gou = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选择"]];
        cell.accessoryView = gou;
    }else{
        cell.accessoryView = nil;
    }
}

#pragma --mark< 配置payTypeSeleBankCell 的数据>
- (void)configurepayTypeSeleBankCell:(payTypeSeleBankCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    [super configurepayTypeSeleBankCell:cell atIndexPath:indexPath];
    if ([self.payMethod isEqualToString:@"BANK"]) {
        UIImageView *gou = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选择"]];
        cell.accessoryView = gou;
    }else{
        cell.accessoryView = nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (([self.payMethod isEqualToString:@"BAL"] && indexPath.row == 0) || ([self.payMethod isEqualToString:@"BANK"] && indexPath.row == 1)  ) {
        if (self.isSuportBAL || indexPath.row == 0) {
            if (indexPath.row == 0) {
                self.payMethod = @"BANK";
            } else {
                self.payMethod = @"BAL";
            }
            [self.tableView reloadData];
            [super tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}
@end
