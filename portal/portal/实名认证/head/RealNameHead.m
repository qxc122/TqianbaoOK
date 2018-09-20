//
//  RealNameHead.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RealNameHead.h"
#import "HeaderAll.h"

@interface RealNameHead ()
@property (nonatomic,weak) UIImageView *headImg;
@end


@implementation RealNameHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *headImg = [UIImageView new];
        self.headImg  =headImg;
        [self addSubview:headImg];
        
        UILabel *title = [UILabel new];
        self.title  =title;
        [self addSubview:title];
        
        [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.top.equalTo(self.returnBtn.mas_bottom).offset(20);
            make.width.equalTo(@6);
            make.height.equalTo(@18);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headImg.mas_right).offset(15);
            make.right.equalTo(self).offset(-30);
            make.centerY.equalTo(headImg);
        }];
        headImg.backgroundColor = COLOUR_TITLE_NORMAL;
        [title setWithColor:0x454E5A Alpha:1.0 Font:20 ROrM:@"m"];
    }
    return self;
}

- (void)setPading:(CGFloat)pading{
    _pading = pading;
    [self.headImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.returnBtn.mas_bottom).offset(pading);
        make.width.equalTo(@6);
        make.height.equalTo(@18);
    }];
}
@end
