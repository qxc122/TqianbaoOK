//
//  BorrowingBillNot.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BorrowingBillNot.h"


@interface BorrowingBillNot ()

@end

@implementation BorrowingBillNot

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    BorrowingBillNot *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[BorrowingBillNot alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.title.mas_bottom).offset(21);
            make.height.equalTo(@0.5);
        }];
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"最高可借(元)";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            self.heightTitle = label;
            [self.contentView addSubview:label];
            [self.heightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line.mas_bottom).offset(20);
                make.centerX.equalTo(self.contentView);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"100000.00";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
            label.textColor = [UIColor colorWithRed:94/255.0 green:127/255.0 blue:255/255.0 alpha:1/1.0];
            self.heightMoney = label;
            [self.contentView addSubview:label];
            [self.heightMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.heightTitle.mas_bottom).offset(10);
                make.centerX.equalTo(self.contentView);
            }];
        }
        {
            UIButton *btn1 = [UIButton new];
            [btn1 setWithNormalColor:0x475468 NormalAlpha:0.5 NormalTitle:@" 快速到账" NormalImage:@"30秒到账图标.png" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0];
//            btn1.contentMode = UIViewContentModeCenter;
//            btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            btn1.contentEdgeInsets = UIEdgeInsetsMake(0, (SCREENWIDTH-3*(52+11+5))/4.0, 0, 0);
            self.btn1 = btn1;
            [self.contentView addSubview:btn1];
            [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.top.equalTo(self.heightMoney.mas_bottom).offset(30);
                make.height.equalTo(@12);
            }];
            UIButton *btn2 = [UIButton new];
            [btn2 setWithNormalColor:0x475468 NormalAlpha:0.5 NormalTitle:@" 按日计息" NormalImage:@"按日计息图标.png" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0];
            self.btn2 = btn2;
            [self.contentView addSubview:btn2];
            [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.btn1.mas_right);
                make.top.equalTo(self.btn1);
                make.height.equalTo(@12);
            }];

            UIButton *btn3 = [UIButton new];
            [btn3 setWithNormalColor:0x475468 NormalAlpha:0.5 NormalTitle:@" 随借随还" NormalImage:@"随借随还小图标.png" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0];
            self.btn3 = btn3;
            [self.contentView addSubview:btn3];
            [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView);
                make.left.equalTo(self.btn2.mas_right);
                make.top.equalTo(self.btn1);
                make.height.equalTo(@12);
                make.width.equalTo(@[self.btn1,self.btn2]);
            }];
        }
        {
            UIButton *Borrowing = [UIButton new];
            [Borrowing setWithNormalColor:0x5E7FFF NormalAlpha:1.0 NormalTitle:@"立即申请" NormalImage:nil NormalBackImage:@"立即申请按钮" SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
            self.Borrowing = Borrowing;
            [self.contentView addSubview:Borrowing];
            [self.Borrowing mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@100);
                make.height.equalTo(@27);
                make.top.equalTo(self.btn1).offset(30);
                make.centerX.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView).offset(-20);
            }];
            [Borrowing addTarget:self action:@selector(BorrowingClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
- (void)BorrowingClick{
    if (self.BorrowingMoney) {
        self.BorrowingMoney();
    }
}
@end
