//
//  newsListCell.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "newsListCell.h"

@interface newsListCell ()
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *des;
@property (nonatomic,weak) UILabel *time;
@property (nonatomic,weak) UIView *line;
@end


@implementation newsListCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    newsListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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

        UILabel *title = [[UILabel alloc]initWithColor:NORMOL_BLACK Alpha:1.0 Font:15 ROrM:@"r"];
        self.title = title;
        [self.contentView addSubview:title];
        
        UILabel *des = [[UILabel alloc]initWithColor:NORMOL_GRAY Alpha:1.0 Font:14 ROrM:@"r"];
        self.des = des;
        [self.contentView addSubview:des];
        
        UILabel *time = [[UILabel alloc]initWithColor:0xCBCED3 Alpha:1.0 Font:12 ROrM:@"r"];
        self.time = time;
        [self.contentView addSubview:time];

        UIView *line = [UIView new];
        self.line = line;
        [self.contentView addSubview:line];

        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(20);
        }];
        
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.right.equalTo(self.time);
            make.top.equalTo(self.title.mas_bottom).offset(10);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.title);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.des.mas_bottom).offset(20);
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.height.equalTo(@0.5f);
        }];

        //set
        title.highlightedTextColor = ColorWithHex(NORMOL_GRAY, 1.0);
        [title setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        line.backgroundColor = COLOUR_LINE_NORMAL;
        des.numberOfLines = 0;
        time.textAlignment = NSTextAlignmentRight;
        
        title.text = @"优惠券即将到期通知";
        des.text = @"相关信息缩略";
        time.text = @"10:30";
        
    }
    return self;
}

@end
