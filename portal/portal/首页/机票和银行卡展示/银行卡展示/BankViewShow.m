//
//  BankViewShow.m
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "BankViewShow.h"

@implementation BankViewShow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.top.equalTo(self.back).offset(20);
            make.height.equalTo(@(30));
        }];
//        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(20);
//            make.right.equalTo(self).offset(-20);
//            make.bottom.equalTo(self);
//            make.top.equalTo(self);
//        }];
    }
    return self;
}

@end
