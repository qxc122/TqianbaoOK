//
//  LeadMoneyActivities.m
//  portal
//
//  Created by Store on 2018/2/5.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "LeadMoneyActivities.h"



@interface LeadMoneyActivities ()
@property (nonatomic,weak) UIButton *Activitiespng;

@end



@implementation LeadMoneyActivities
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self.blcak setBackgroundImage:[ColorWithHex(0x000000, 0.6) imageWithColor] forState:UIControlStateNormal];
        

        self.back.hidden = YES;
        UIButton *Activitiespng = [[UIButton alloc]init];
        self.Activitiespng  =Activitiespng;
        [Activitiespng setImage:[UIImage imageNamed:@"弹窗"] forState:UIControlStateNormal];
//        Activitiespng.image = [UIImage imageNamed:@"弹窗"];
        [Activitiespng addTarget:self action:@selector(ActivitiespngClick) forControlEvents:UIControlEventTouchUpInside];
//        [Activitiespng SetContentModeScaleAspectFill];
        [self addSubview:Activitiespng];
        [Activitiespng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(140*PROPORTION_HEIGHT);
            make.width.equalTo(@296);
            make.height.equalTo(@361);
        }];
        [self bringSubviewToFront:self.close];
        
        [self.close mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.centerX.equalTo(self);
            make.top.equalTo(self.Activitiespng.mas_bottom).offset(20);
        }];
    }
    return self;
}
- (void)ActivitiespngClick{
    if (self.ActivitiespngdoneClick) {
        self.ActivitiespngdoneClick();
    }
}
@end
