//
//  windosView.m
//  TourismT
//
//  Created by Store on 16/12/15.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"
#import "UIView+Add.h"
@implementation windosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *blcak = [[UIButton alloc]init];
        self.blcak = blcak;
        [blcak setBackgroundImage:[ColorWithHex(0x000000, 0.5) imageWithColor] forState:UIControlStateNormal];
        [self addSubview:blcak];
        
        UIImageView *back = [[UIImageView alloc]init];
        self.back = back;
        [back SetFilletWith:PICTURE_FILLET_SIZE*2];
        back.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
        [self addSubview:back];

        UIButton *close = [[UIButton alloc]init];
        self.close = close;
        [self addSubview:close];
        
        [self.close setImage:[[UIImage imageNamed:PIC_HOME_CANEL] thumbnailsize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
        [self.close addTarget:self action:@selector(closeClisck) forControlEvents:UIControlEventTouchUpInside];

        CGFloat bottomSpaing = -8;
        if (IPoneX) {
            bottomSpaing -= 34;
        }
        [self.close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(bottomSpaing);
        }];
        
        [blcak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-15);
            make.height.equalTo(@353);
        }];
        [self.back SetContentModeScaleAspectFill];
//        [blcak addTarget:self action:@selector(closeClisck) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)closeClisck{
    [self removeFromSuperview];
}
- (void)windosViewshow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window);
        make.right.equalTo(window);
        make.top.equalTo(window);
        make.bottom.equalTo(window);
    }];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
