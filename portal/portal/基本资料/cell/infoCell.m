//
//  infoCell.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "infoCell.h"


@interface infoCell ()

@end


@implementation infoCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *icon = [UIImageView new];
        self.icon = icon;
        [self.contentView addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.des);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@(45));
            make.height.equalTo(icon.mas_width);
        }];
        
        [icon SetContentModeScaleAspectFill];
        icon.layer.cornerRadius = 45*0.5;
        icon.layer.masksToBounds = YES;
        
        icon.image = [UIImage imageNamed:@"背景"];
    }
    return self;
}
- (void)setHidenIcon:(BOOL)hidenIcon{
    _hidenIcon = hidenIcon;
    self.icon.hidden = hidenIcon;
}
- (void)setHidenMore:(BOOL)hidenMore{
    _hidenMore = hidenMore;
    self.more.hidden = hidenMore;
}
@end
