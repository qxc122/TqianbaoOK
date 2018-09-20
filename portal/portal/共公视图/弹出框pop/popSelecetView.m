//
//  popSelecetView.m
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "popSelecetView.h"


@interface popSelecetView ()

@end
    
@implementation popSelecetView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.close.hidden = YES;
        self.back.hidden =  YES;
        self.blcak.backgroundColor = [UIColor clearColor];
        [self.blcak addTarget:self action:@selector(closeClisck) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
