//
//  BorrowingBillOverdue.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BorrowingBillOverdue.h"


@interface BorrowingBillOverdue ()
@property (nonatomic,weak) UIImageView *overdue;
@end

@implementation BorrowingBillOverdue

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    BorrowingBillOverdue *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[BorrowingBillOverdue alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(126, 387, 30, 16);
            imageView.image = [UIImage imageNamed:@"逾期图标.png"];
            self.overdue = imageView;
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.title.mas_right).offset(10);
                make.centerY.equalTo(self.title);
            }];
        }
    }
    return self;
}

@end
