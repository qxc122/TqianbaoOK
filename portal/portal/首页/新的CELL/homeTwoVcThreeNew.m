//
//  homeTwoVcThreeNew.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcThreeNew.h"


@interface homeTwoVcThreeNew ()

@end

@implementation homeTwoVcThreeNew

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    homeTwoVcThreeNew *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[homeTwoVcThreeNew alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.stare.hidden = YES;
        [self.shouyi mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.money.mas_bottom).offset(10);
            make.left.equalTo(self.dian);
        }];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shouyi.mas_bottom).offset(20);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"马上领钱";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        label.textColor = [UIColor colorWithRed:94/255.0 green:127/255.0 blue:255/255.0 alpha:1/1.0];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(view.mas_bottom).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
    }
    return self;
}

@end
