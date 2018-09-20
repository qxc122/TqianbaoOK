//
//  myBankCardFoot.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "myBankCardFoot.h"
#import "HeaderAll.h"

@implementation myBankCardFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
//        btn.backgroundColor = ColorWithHex(, );
        [btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"添加银行卡", @"") NormalImage:@"编辑" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x5E7FFF backAlpha:1.0];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)btnClick{
    NSLog(@"%s",__func__);
    if(self.addBankCard){
        self.addBankCard();
    }
}
@end
