//
//  GesturecipherCoCell.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "GesturecipherCoCell.h"
#import "HeaderAll.h"

@interface GesturecipherCoCell ()

@end

@implementation GesturecipherCoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *Icon = [[UIImageView alloc]init];
        self.Icon = Icon;
        [self.contentView addSubview:Icon];
        [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
        }];
        [Icon SetContentModeScaleAspectFill];
        [Icon SetFilletWith:6*PROPORTION_WIDTH];
        Icon.image = [ColorWithHex(0xF0F1F5, 1.0) imageWithColor];  
        Icon.highlightedImage = [ColorWithHex(0x1E2E47, 1.0) imageWithColor];
    }
    return self;
}
@end
