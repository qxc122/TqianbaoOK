//
//  AirTiketView.m
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AirTiketView.h"


@interface AirTiketView ()
@property (nonatomic,weak) UIImageView *top;
@property (nonatomic,weak) UIImageView *bottom;

@property (nonatomic,weak) UIImageView *Airlogo;
@property (nonatomic,weak) UILabel *AirName;
@property (nonatomic,weak) UILabel *AirDate;


@property (nonatomic,weak) UIImageView *plan;
@property (nonatomic,weak) UIImageView *planLeft;
@property (nonatomic,weak) UIImageView *planRight;
@property (nonatomic,weak) UILabel *planLeftOne;
@property (nonatomic,weak) UILabel *planLeftTwo;

@property (nonatomic,weak) UILabel *planRightOne;
@property (nonatomic,weak) UILabel *planRightTwo;

@property (nonatomic,weak) UILabel *PunctualityRate;
@end

@implementation AirTiketView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *top = [[UIImageView alloc]init];
        self.top = top;
        [self addSubview:top];
        
        UIImageView *bottom = [[UIImageView alloc]init];
        self.bottom = bottom;
        [self addSubview:bottom];

        UILabel *AirName = [[UILabel alloc]init];
        self.AirName = AirName;
        [self addSubview:AirName];
        
        UILabel *AirDate = [[UILabel alloc]init];
        self.AirDate = AirDate;
        [self addSubview:AirDate];
        
        UIImageView *Airlogo = [[UIImageView alloc]init];
        self.Airlogo = Airlogo;
        [self.Airlogo SetContentModeScaleAspectFill];
        [self addSubview:Airlogo];
        
        UIImageView *plan = [[UIImageView alloc]init];
        self.plan = plan;
        [self.plan SetContentModeScaleAspectFill];
        [self addSubview:plan];
        
        UIImageView *planLeft = [[UIImageView alloc]init];
        self.planLeft = planLeft;
        [self.planLeft SetContentModeScaleAspectFill];
        [self addSubview:planLeft];
        
        UIImageView *planRight = [[UIImageView alloc]init];
        self.planRight = planRight;
        [self.planRight SetContentModeScaleAspectFill];
        [self addSubview:planRight];
        
        
        UILabel *planLeftOne = [[UILabel alloc]init];
        self.planLeftOne = planLeftOne;
        [self addSubview:planLeftOne];
        UILabel *planLeftTwo = [[UILabel alloc]init];
        self.planLeftTwo = planLeftTwo;
        [self addSubview:planLeftTwo];
        
        UILabel *planRightOne = [[UILabel alloc]init];
        self.planRightOne = planRightOne;
        [self addSubview:planRightOne];
        UILabel *planRightTwo = [[UILabel alloc]init];
        self.planRightTwo = planRightTwo;
        [self addSubview:planRightTwo];

        UILabel *PunctualityRate = [[UILabel alloc]init];
        self.PunctualityRate = PunctualityRate;
        [self addSubview:PunctualityRate];
        
        UIButton *btn = [[UIButton alloc]init];
        [self addSubview:btn];
        
        [self.top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(top.mas_width).multipliedBy(36/335.0);
            make.top.equalTo(self);
        }];
        
        [self.bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self.top.mas_bottom);
            make.bottom.equalTo(self);
        }];
        
        [self.Airlogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.top).offset(15+20);
            make.centerY.equalTo(self.top).offset(3);
            make.width.equalTo(@(18));
            make.height.equalTo(@(18));
        }];
        [self.AirName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airlogo.mas_right).offset(10);
            make.centerY.equalTo(self.Airlogo);
        }];
        [self.AirDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.AirName.mas_right).offset(10);
            make.right.equalTo(self.top).offset(-15-20);
            make.centerY.equalTo(self.Airlogo);
        }];
        
        [self.plan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottom);
            make.width.equalTo(@(15));
            make.height.equalTo(@(6.1));
            make.centerY.equalTo(self.bottom);
        }];
        
        [self.planLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.plan.mas_left).offset(-5);
            make.width.equalTo(@(16));
            make.height.equalTo(@1);
            make.centerY.equalTo(self.plan);
        }];
        
        [self.planRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.plan.mas_right).offset(5);
            make.width.equalTo(planLeft);
            make.height.equalTo(planLeft);
            make.centerY.equalTo(self.plan);
        }];
        
        
        [self.planLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.plan.mas_left);
            make.bottom.equalTo(self.bottom.mas_centerY).offset(-2);
        }];
        [self.planLeftTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.plan.mas_left);
            make.top.equalTo(self.bottom.mas_centerY).offset(2);
        }];

        
        [self.planRightOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.plan.mas_right);
            make.right.equalTo(self);
            make.bottom.equalTo(self.bottom.mas_centerY).offset(-2);
        }];
        [self.planRightTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.plan.mas_right);
            make.right.equalTo(self);
            make.top.equalTo(self.bottom.mas_centerY).offset(2);
        }];

        [self.PunctualityRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.planLeftOne);
            make.centerX.equalTo(self);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.top.equalTo(self);
        }];
        [btn addTarget:self action:@selector(btnClickTagg) forControlEvents:UIControlEventTouchUpInside];
        
        self.top.contentMode = UIViewContentModeBottom;
        self.top.clipsToBounds = YES;
        
        self.bottom.contentMode = UIViewContentModeTop;
        self.bottom.clipsToBounds = YES;
        
        [top SetContentModeScaleAspectFill];
        [bottom SetContentModeScaleAspectFill];
        [Airlogo SetContentModeScaleAspectFill];
        [plan SetContentModeScaleAspectFill];
        [planLeft SetContentModeScaleAspectFill];
        [planRight SetContentModeScaleAspectFill];

        [AirName setWithColor:0xFFFFFF Alpha:1.0 Font:12 ROrM:@"r"]; //0x1E2D46
        [AirDate setWithColor:0xFFFFFF Alpha:1.0 Font:12 ROrM:@"r"];
        [planLeftOne setWithColor:0x1E2E47 Alpha:1.0 Font:18 ROrM:@"r"];
        [planLeftTwo setWithColor:0x475468 Alpha:1.0 Font:12 ROrM:@"r"];
        [planRightOne setWithColor:0x1E2E47 Alpha:1.0 Font:18 ROrM:@"r"];
        [planRightTwo setWithColor:0x475468 Alpha:1.0 Font:12 ROrM:@"r"];
        [PunctualityRate setWithColor:0x9DA4AE Alpha:1.0 Font:12 ROrM:@"r"];
        
        self.planLeftOne.textAlignment = NSTextAlignmentCenter;
        self.planLeftTwo.textAlignment = NSTextAlignmentCenter;
        self.planRightOne.textAlignment = NSTextAlignmentCenter;
        self.planRightTwo.textAlignment = NSTextAlignmentCenter;
        
        self.plan.image = [UIImage imageNamed:PIC_HOME_AIRCRAFT];
        self.planLeft.image = [UIImage imageNamed:PIC_HOME_DASHED_LINE];
        self.planRight.image = [UIImage imageNamed:PIC_HOME_DASHED_LINE];
        self.top.image = [UIImage imageNamed:PIC_HOME_THE_FIRST_HALF_OF_THE_HOME_PAGE_TOP];
        self.bottom.image = [UIImage imageNamed:PIC_HOME_THE_FIRST_HALF_OF_THE_HOME_PAGE_BOTTOM];
        
//        self.AirName.text = @"2.01224";
//        self.AirDate.text = @"2.01224";
//        self.planLeftOne.text = @"2.01224";
//        self.planLeftTwo.text = @"2.01224";
//        self.planRightOne.text = @"2.01224";
//        self.planRightTwo.text = @"2.01224";
//        self.PunctualityRate.text = @"2.01224";
//        
//        self.Airlogo.image = [UIImage imageNamed:@"背景"];

    }
    return self;
}
- (void)setBankCardOne:(bankCard *)bankCardOne{
    _bankCardOne = bankCardOne;
    self.AirName.text = [NSString stringWithFormat:@"%@ %@",bankCardOne.airName,bankCardOne.flightNo];
    self.AirDate.text = bankCardOne.depDate;
    self.planLeftOne.text = bankCardOne.depTime;
    self.planLeftTwo.text = bankCardOne.depCityName;
    self.planRightOne.text = bankCardOne.arrTime;
    self.planRightTwo.text = bankCardOne.arrCityName;
    self.PunctualityRate.text = bankCardOne.duration;
    
    [self.Airlogo sd_setImageWithURL:bankCardOne.airLogo placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
}


- (void)btnClickTagg{
    if (self.UIViewClick) {
        self.UIViewClick(self.bankCardOne,self.tagg);
    }
}

//- (void)restlogo{
//    
//    [self.Airlogo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.top).offset(15+20);
//        make.centerY.equalTo(self.top).offset(4);
//        make.width.equalTo(@(18));
//        make.height.equalTo(@(18));
//    }];
//}
@end
