//
//  typeCell.m
//  portal
//
//  Created by Store on 2018/3/13.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "typeCell.h"

@interface typeCell ()

@end

@implementation typeCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    typeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        self.title.textColor = [UIColor colorWithRed:157/255.0 green:164/255.0 blue:174/255.0 alpha:1/1.0];

        self.des.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        self.des.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
        
        UILabel *label = [[UILabel alloc] init];
        self.lastLabel = label;
//        label.frame = CGRectMake(298, 335, 57, 20);
//        label.text = @"-1950.21";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];

        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.des);
            make.right.equalTo(self.line);
        }];
    }
    return self;
}

@end
