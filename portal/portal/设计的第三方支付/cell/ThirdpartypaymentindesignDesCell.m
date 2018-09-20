//
//  ThirdpartypaymentindesignDesCell.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ThirdpartypaymentindesignDesCell.h"



@interface ThirdpartypaymentindesignDesCell ()

@end

@implementation ThirdpartypaymentindesignDesCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ThirdpartypaymentindesignDesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        
        UILabel * title = [[UILabel alloc]init];
        self.title = title;
        [self.contentView addSubview:title];
        UILabel * num = [[UILabel alloc]init];
        self.num = num;
        [self.contentView addSubview:num];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.height.equalTo(@0.5);
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.right.equalTo(self.line);
            make.top.equalTo(self.contentView).offset(25);
        }];
        [num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.right.equalTo(self.line);
            make.top.equalTo(self.title.mas_bottom).offset(15);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        line.backgroundColor  =ColorWithHex(0xE9EBEE, 1.0);
        [title setWithColor:0x1E2E47 Alpha:1.0 Font:15 ROrM:@"r"];
        [num setWithColor:0x9DA4AE Alpha:1.0 Font:14 ROrM:@"r"];
        
//        title.text = @"sdf";
//        num.text = @"sdf";
    }
    return self;
}
- (void)setPasteboarddata:(NSDictionary *)pasteboarddata{
    _pasteboarddata = pasteboarddata;
    self.title.text = pasteboarddata[@"businessName"];
    self.num.text = [NSString stringWithFormat:@"%@%@",@"订单号:",pasteboarddata[@"businessID"]];
}
@end
