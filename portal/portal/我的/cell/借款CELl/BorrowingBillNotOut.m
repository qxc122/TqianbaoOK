//
//  BorrowingBillNotOut.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BorrowingBillNotOut.h"


@interface BorrowingBillNotOut ()
@property (nonatomic,weak) UIImageView *ContentIcon;
@property (nonatomic,weak) UILabel *ContentTitle;
@end

@implementation BorrowingBillNotOut

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    BorrowingBillNotOut *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[BorrowingBillNotOut alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
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
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(158, 447, 60, 62);
            imageView.image = [UIImage imageNamed:@"我的借款控状态图标.png"];
            self.ContentIcon = imageView;
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.contentView);
                make.top.equalTo(self.line.mas_bottom).offset(21);
                make.width.equalTo(@60);
                make.height.equalTo(@62);
            }];
            
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(96, 519, 183, 20);
            label.text = @"本月账单未生成";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            self.ContentTitle = label;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.contentView);
                make.top.equalTo(self.ContentIcon.mas_bottom).offset(10);
                make.bottom.equalTo(self.contentView).offset(-21);
            }];
        }
    }
    return self;
}
@end
