//
//  SignINbaseFillCell.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SignINbaseFillCell.h"

@implementation SignINbaseFillCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    SignINbaseFillCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.bottom.equalTo(self.line);
            make.height.equalTo(@(14+20));
            make.width.equalTo(@(0));
        }];
    }
    return self;
}

@end
