//
//  FindPassWordFoot.m
//  portal
//
//  Created by Store on 2018/3/13.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "FindPassWordFoot.h"

@implementation FindPassWordFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
    }
    
    return self;
}

@end
