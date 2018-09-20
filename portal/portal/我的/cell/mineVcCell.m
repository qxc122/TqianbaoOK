//
//  mineVcCell.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "mineVcCell.h"

@interface mineVcCell ()
@property (nonatomic,weak) UIImageView *icon;
@end

@implementation mineVcCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIImageView *icon = [UIImageView new];
        self.icon = icon;
        [self.contentView addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
        }];
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(20);
            make.top.equalTo(self.contentView).offset(22);
            make.bottom.equalTo(self.contentView).offset(-22);
        }];
        icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}
- (void)setData:(id)data{
    [super setData:data];
    setUpData *tmp = data;
    self.icon.image = [UIImage imageNamed:tmp.icon];
    
    
}
@end
