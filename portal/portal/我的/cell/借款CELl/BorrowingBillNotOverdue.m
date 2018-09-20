//
//  BorrowingBillNotOverdue.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BorrowingBillNotOverdue.h"

@interface BorrowingBillNotOverdue ()
@property (nonatomic,weak) UILabel *ContentTitle1;
@property (nonatomic,weak) UILabel *ContentTitle2;
@property (nonatomic,weak) UILabel *ContentTitle3;

@property (nonatomic,weak) UILabel *ContentTitle11;
@property (nonatomic,weak) UILabel *ContentTitle22;
@property (nonatomic,weak) UILabel *ContentTitle33;
@end

@implementation BorrowingBillNotOverdue

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    BorrowingBillNotOverdue *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[BorrowingBillNotOverdue alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
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
            label.text = @"本月应还";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.ContentTitle1 = label;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.top.equalTo(self.line.mas_bottom).offset(22);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"账单笔数";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.ContentTitle2 = label;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.ContentTitle1.mas_right);
                make.top.equalTo(self.line.mas_bottom).offset(22);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"还款日";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.ContentTitle3 = label;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView);
                make.left.equalTo(self.ContentTitle2.mas_right);
                make.top.equalTo(self.line.mas_bottom).offset(22);
                make.width.equalTo(@[self.ContentTitle1,self.ContentTitle2]);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(20, 470, 69, 20);
            label.text = @"500.00";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
            label.textColor = [UIColor colorWithRed:94/255.0 green:127/255.0 blue:255/255.0 alpha:1/1.0];
            self.ContentTitle11 = label;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.top.equalTo(self.ContentTitle1.mas_bottom).offset(10);
                make.bottom.equalTo(self.contentView).offset(-22);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(153, 472, 69, 20);
            label.text = @"1笔";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            self.ContentTitle22 = label;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.ContentTitle11.mas_right);
                make.top.equalTo(self.ContentTitle11);
                make.bottom.equalTo(self.ContentTitle11);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(265, 472, 90, 20);
            label.text = @"2017-11-24";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];

            self.ContentTitle33 = label;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView);
                make.left.equalTo(self.ContentTitle22.mas_right);
                make.top.equalTo(self.ContentTitle11);
                make.bottom.equalTo(self.ContentTitle11);
                make.width.equalTo(@[self.ContentTitle11,self.ContentTitle22]);
            }];
        }
        self.ContentTitle1.textAlignment = NSTextAlignmentCenter;
        self.ContentTitle2.textAlignment = NSTextAlignmentCenter;
        self.ContentTitle3.textAlignment = NSTextAlignmentCenter;
        self.ContentTitle11.textAlignment = NSTextAlignmentCenter;
        self.ContentTitle22.textAlignment = NSTextAlignmentCenter;
        self.ContentTitle33.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    self.ContentTitle11.text = [NSString stringWithFormat:@"%.2f",[userData.loanDueRepayAmt doubleValue]];
    self.ContentTitle22.text = [NSString stringWithFormat:@"%.f笔",[userData.loanCnt doubleValue]];;
    self.ContentTitle33.text = [NSString stringWithFormat:@"%@",userData.loanRepayDate];;
}
@end
