//
//  NavigationBarDetais.m
//  TourismT
//
//  Created by Store on 2017/7/28.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "NavigationBarDetais.h"
#import "HeaderAll.h"


@interface NavigationBarDetais ()

@end


@implementation NavigationBarDetais
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *HeadBack = [UIView new];
        self.HeadBack  =HeadBack;
        [self addSubview:HeadBack];
        
        UIButton *returnBtn = [UIButton new];
        self.returnBtn  =returnBtn;
        [self addSubview:returnBtn];
        
        
        CGFloat heightHeadBack = 64;
        if (IPoneX) {
            heightHeadBack += 20;
        }
        [self.HeadBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(@(heightHeadBack));
        }];
        
        
        
        [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            if (IPoneX) {
                make.top.equalTo(self).offset(22+20);
            }else{
                make.top.equalTo(self).offset(22);
            }
            make.width.equalTo(@44);
            make.height.equalTo(@44);
        }];

        
        [returnBtn setWithNormalColor:0x0 NormalAlpha:0 NormalTitle:nil NormalImage:PIC_CUSTOM_NAVIGATION_BACK NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:0 NormalROrM:nil backColor:0x0 backAlpha:0];
        [returnBtn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *RightBtn = [UIButton new];
        self.RightBtn  =RightBtn;
        [self addSubview:RightBtn];
        
        
        [RightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-5);
            make.top.equalTo(returnBtn);
//            make.width.equalTo(returnBtn);
            make.width.equalTo(@44);
            make.height.equalTo(returnBtn);
        }];
        
        [RightBtn setWithNormalColor:0x1E2E47 NormalAlpha:1.0 NormalTitle:nil NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [RightBtn addTarget:self action:@selector(RightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *titleNa = [UILabel new];
        self.titleNa  =titleNa;
        [self addSubview:titleNa];

        [titleNa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.returnBtn.mas_right).offset(5);
//            make.right.equalTo(self.RightBtn.mas_left).offset(-5);
            make.centerX.equalTo(self);
            make.centerY.equalTo(returnBtn);
        }];
        titleNa.textAlignment = NSTextAlignmentCenter;
        [titleNa setWithColor:0xE3BF7C Alpha:1.0 Font:17 ROrM:@"m"];
    }
    return self;
}
- (void)returnBtnClick{
    if (self.ClickreturnBtn) {
        self.ClickreturnBtn();
    }
}
- (void)RightBtnClick{
    if (self.ClickRightBtn) {
        self.ClickRightBtn();
    }
}
@end
