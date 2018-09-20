//
//  SetUpCell.m
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SetUpCell.h"




@interface SetUpCell ()


@end


@implementation SetUpCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc]initWithColor:0x1E2E47 Alpha:1.0 Font:15 ROrM:@"r"];
        self.title = title;
        [self.contentView addSubview:title];
        
        UILabel *des = [[UILabel alloc]initWithColor:0x9DA4AE Alpha:1.0 Font:15 ROrM:@"r"];
        self.des = des;
        [self.contentView addSubview:des];
        
        
        UIImageView *more = [UIImageView new];
        self.more = more;
        [self.contentView addSubview:more];
        
        UIView *line = [UIView new];
        self.line = line;
        [self.contentView addSubview:line];
        
        UISwitch *switch_one = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 51, 31)];
        self.switchBtn  =switch_one;
        [self.contentView addSubview:switch_one];
        [switch_one addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
//            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(22);
            make.bottom.equalTo(self.contentView).offset(-22);
        }];
        
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).offset(15);
            make.right.equalTo(more.mas_left).offset(-15);
            make.centerY.equalTo(self.title);
        }];
        
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-20);
            make.width.equalTo(@6);
            make.height.equalTo(@11);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.height.equalTo(@0.5f);
        }];
        [switch_one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.more);
        }];
        //set
        line.backgroundColor = COLOUR_LINE_NORMAL;
        [more SetContentModeScaleAspectFill];
        self.switchBtn.hidden = YES;
        more.image = [UIImage imageNamed:PIC_CELL_MORE];
        
//        title.text = @"sdf";
//        des.text = @"sdffdg";
        
    }
    return self;
}

- (void)switchClick:(UISwitch *)btn{
    NSLog(@"%s",__func__);
    if (self.switchBtnClick) {
        self.switchBtnClick(self.title.text,btn.isOn);
    }
}


- (void)setData:(id)data{
    [super setData:data];
    setUpData *tmp = data;
    self.title.text = tmp.title;
    self.des.text = tmp.describe;
}
- (void)setHidenswitchBtn:(BOOL)hidenswitchBtn{
    _hidenswitchBtn = hidenswitchBtn;
    self.switchBtn.hidden = hidenswitchBtn;
}
- (void)setHidenMoreAndDes:(BOOL)hidenMoreAndDes{
    _hidenMoreAndDes = hidenMoreAndDes;
    self.more.hidden = hidenMoreAndDes;
    self.des.hidden = hidenMoreAndDes;
}
@end
