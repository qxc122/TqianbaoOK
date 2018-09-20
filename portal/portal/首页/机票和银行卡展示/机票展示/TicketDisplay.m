//
//  TicketDisplay.m
//  portal
//
//  Created by Store on 2017/10/10.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "TicketDisplay.h"
#import "YYText.h"

@interface TicketDisplay ()
@property (nonatomic,weak) UIImageView *back;
@property (nonatomic,weak) UIImageView *back2;
@property (nonatomic,weak) UIImageView *back22;
@property (nonatomic,weak) UIImageView *back3;
@property (nonatomic,weak) UIImageView *back4;
@property (nonatomic,weak) UIImageView *back5;
@property (nonatomic,weak) UIImageView *back6;
@property (nonatomic,weak) UIImageView *back7;
@property (nonatomic,weak) UIImageView *back8;


@property (nonatomic,weak) UIImageView *Airlogo;
@property (nonatomic,weak) UILabel *AirName;
@property (nonatomic,weak) UILabel *AirDate;

@property (nonatomic,weak) UILabel *plantext;

@property (nonatomic,weak) UIImageView *plan;
@property (nonatomic,weak) UILabel *planLeftOne;
@property (nonatomic,weak) UILabel *planLeftTwo;
@property (nonatomic,weak) UILabel *planLeftThree;
@property (nonatomic,weak) UILabel *planRightOne;
@property (nonatomic,weak) UILabel *planRightTwo;
@property (nonatomic,weak) UILabel *planRightThree;
@property (nonatomic,weak) UILabel *PunctualityRate;

@property (nonatomic,weak) UIImageView *Airline;
@property (nonatomic,weak) UIImageView *Air;

@property (nonatomic,weak) UIImageView *startPlacePng;
@property (nonatomic,weak) YYLabel *startPlace;
@property (nonatomic,weak) UILabel *startweather;
@property (nonatomic,weak) UILabel *startLabel_1;
@property (nonatomic,weak) UILabel *startLabel_2;
@property (nonatomic,weak) UILabel *startLabel_3;
@property (nonatomic,weak) UILabel *startLabel1;
@property (nonatomic,weak) UILabel *startLabel2;
@property (nonatomic,weak) UILabel *startLabel3;

@property (nonatomic,weak) UIImageView *endPlacePng;
@property (nonatomic,weak) YYLabel *endPlace;
@property (nonatomic,weak) UILabel *endweather;
@property (nonatomic,weak) UILabel *endLabel_1;
@property (nonatomic,weak) UILabel *endLabel_2;

@property (nonatomic,weak) UILabel *endLabel1;
@property (nonatomic,weak) UILabel *endLabel2;

@property (nonatomic,weak) UILabel *airNameTwo;
@property (nonatomic,weak) UILabel *airNumber;

@property (nonatomic,weak) UILabel *peopleName;
@property (nonatomic,weak) UIImageView *peopleLogo;
@property (nonatomic,weak) UILabel *peopleNumberDes;
@property (nonatomic,weak) UILabel *peopleNumber;
@end


@implementation TicketDisplay
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
        
        UIImageView *back = [[UIImageView alloc]init];
        self.back = back;
        [self.contentView addSubview:back];
        UIImageView *back2 = [[UIImageView alloc]init];
        self.back2 = back2;
        [self.contentView addSubview:back2];
        UIImageView *back22 = [[UIImageView alloc]init];
        self.back22 = back22;
        [self.contentView addSubview:back22];
        UIImageView *back3 = [[UIImageView alloc]init];
        self.back3 = back3;
        [self.contentView addSubview:back3];
        UIImageView *back4 = [[UIImageView alloc]init];
        self.back4 = back4;
        [self.contentView addSubview:back4];
        UIImageView *back5 = [[UIImageView alloc]init];
        self.back5 = back5;
        [self.contentView addSubview:back5];
        UIImageView *back6 = [[UIImageView alloc]init];
        self.back6 = back6;
        [self.contentView addSubview:back6];
        UIImageView *back7 = [[UIImageView alloc]init];
        self.back7 = back7;
        [self.contentView addSubview:back7];
        UIImageView *back8 = [[UIImageView alloc]init];
        self.back8 = back8;
        [self.contentView addSubview:back8];
        
        UIImageView *startPlacePng = [[UIImageView alloc]init];
        self.startPlacePng = startPlacePng;
        [self.contentView addSubview:startPlacePng];
        UIImageView *endPlacePng = [[UIImageView alloc]init];
        self.endPlacePng = endPlacePng;
        [self.contentView addSubview:endPlacePng];
        
        
        UIImageView *Airlogo = [[UIImageView alloc]init];
        self.Airlogo = Airlogo;
        [self.Airlogo SetContentModeScaleAspectFill];
        [self.contentView addSubview:Airlogo];
        
        UILabel *AirName = [[UILabel alloc]init];
        self.AirName = AirName;
        [self.contentView addSubview:AirName];
        
        UILabel *AirDate = [[UILabel alloc]init];
        self.AirDate = AirDate;
        [self.contentView addSubview:AirDate];

        
        UIImageView *plan = [[UIImageView alloc]init];
        self.plan = plan;
        [self.plan SetContentModeScaleAspectFill];
        [self.contentView addSubview:plan];
        UILabel *plantext = [[UILabel alloc]init];
        self.plantext = plantext;
        [self.contentView addSubview:plantext];
        
        UILabel *planLeftOne = [[UILabel alloc]init];
        self.planLeftOne = planLeftOne;
        [self.contentView addSubview:planLeftOne];
        UILabel *planLeftTwo = [[UILabel alloc]init];
        self.planLeftTwo = planLeftTwo;
        [self.contentView addSubview:planLeftTwo];
        UILabel *planLeftThree = [[UILabel alloc]init];
        self.planLeftThree = planLeftThree;
        [self.contentView addSubview:planLeftThree];
        
        UILabel *planRightOne = [[UILabel alloc]init];
        self.planRightOne = planRightOne;
        [self.contentView addSubview:planRightOne];
        UILabel *planRightTwo = [[UILabel alloc]init];
        self.planRightTwo = planRightTwo;
        [self.contentView addSubview:planRightTwo];
        UILabel *planRightThree = [[UILabel alloc]init];
        self.planRightThree = planRightThree;
        [self.contentView addSubview:planRightThree];
        
        UILabel *PunctualityRate = [[UILabel alloc]init];
        self.PunctualityRate = PunctualityRate;
        [self.contentView addSubview:PunctualityRate];
        
        UIImageView *Airline = [[UIImageView alloc]init];
        self.Airline = Airline;
        [self.contentView addSubview:Airline];
        
        UIImageView *Air = [[UIImageView alloc]init];
        self.Air = Air;
        [self.contentView addSubview:Air];
        
        YYLabel *startPlace = [[YYLabel alloc]init];
        self.startPlace = startPlace;
        [self.contentView addSubview:startPlace];
        UILabel *startweather = [[UILabel alloc]init];
        self.startweather = startweather;
        [self.contentView addSubview:startweather];
        UILabel *startLabel_1 = [[UILabel alloc]init];
        self.startLabel_1 = startLabel_1;
        [self.contentView addSubview:startLabel_1];
        UILabel *startLabel_2 = [[UILabel alloc]init];
        self.startLabel_2 = startLabel_2;
        [self.contentView addSubview:startLabel_2];
        UILabel *startLabel_3 = [[UILabel alloc]init];
        self.startLabel_3 = startLabel_3;
        [self.contentView addSubview:startLabel_3];
        UILabel *startLabel1 = [[UILabel alloc]init];
        self.startLabel1 = startLabel1;
        [self.contentView addSubview:startLabel1];
        UILabel *startLabel2 = [[UILabel alloc]init];
        self.startLabel2 = startLabel2;
        [self.contentView addSubview:startLabel2];
        UILabel *startLabel3 = [[UILabel alloc]init];
        self.startLabel3 = startLabel3;
        [self.contentView addSubview:startLabel3];

        YYLabel *endPlace = [[YYLabel alloc]init];
        self.endPlace = endPlace;
        [self.contentView addSubview:endPlace];
        UILabel *endweather = [[UILabel alloc]init];
        self.endweather = endweather;
        [self.contentView addSubview:endweather];
        UILabel *endLabel_1 = [[UILabel alloc]init];
        self.endLabel_1 = endLabel_1;
        [self.contentView addSubview:endLabel_1];
        UILabel *endLabel_2 = [[UILabel alloc]init];
        self.endLabel_2 = endLabel_2;
        [self.contentView addSubview:endLabel_2];

        UILabel *endLabel1 = [[UILabel alloc]init];
        self.endLabel1 = endLabel1;
        [self.contentView addSubview:endLabel1];
        UILabel *endLabel2 = [[UILabel alloc]init];
        self.endLabel2 = endLabel2;
        [self.contentView addSubview:endLabel2];

        UILabel *airNameTwo = [[UILabel alloc]init];
        self.airNameTwo = airNameTwo;
        [self.contentView addSubview:airNameTwo];
        UILabel *airNumber = [[UILabel alloc]init];
        self.airNumber = airNumber;
        [self.contentView addSubview:airNumber];
        
        UILabel *peopleName = [[UILabel alloc]init];
        self.peopleName = peopleName;
        [self.contentView addSubview:peopleName];
        
        UIImageView *peopleLogo = [[UIImageView alloc]init];
        self.peopleLogo = peopleLogo;
        [self.contentView addSubview:peopleLogo];
        
        UILabel *peopleNumberDes = [[UILabel alloc]init];
        self.peopleNumberDes = peopleNumberDes;
        [self.contentView addSubview:peopleNumberDes];
        UILabel *peopleNumber = [[UILabel alloc]init];
        self.peopleNumber = peopleNumber;
        [self.contentView addSubview:peopleNumber];
        
//        CGFloat tmp = 70*PROPORTION_HEIGHT;
//        if (IPoneX) {
//            tmp += 22;
//        }
        [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.back2.mas_top);
            make.height.equalTo(@50);
        }];
        [self.back2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.bottom.equalTo(self.back3.mas_top);
            make.height.equalTo(@167);
        }];

        [self.back3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.bottom.equalTo(self.back4.mas_top);
            make.height.equalTo(@40);
        }];
        
        [self.back4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.centerY.equalTo(self).offset(-15+32);
            make.height.equalTo(@76);
        }];
        
        [self.back5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.top.equalTo(self.back4.mas_bottom);
            make.height.equalTo(@40);
        }];
        
        [self.back6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.top.equalTo(self.back5.mas_bottom);
            make.height.equalTo(@76);
        }];
        
        [self.back7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.top.equalTo(self.back6.mas_bottom);
            make.height.equalTo(@40);
        }];
        [self.back8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.top.equalTo(self.back7.mas_bottom);
            make.height.equalTo(@50);
        }];

        [self.Airlogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(15);
            make.centerY.equalTo(self.back);
            make.width.equalTo(@(18));
            make.height.equalTo(@(18));
        }];
        [self.AirName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airlogo.mas_right).offset(10);
            make.centerY.equalTo(self.Airlogo);
        }];
        [self.AirDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.AirName.mas_right).offset(10);
            make.right.equalTo(self.back).offset(-15);
            make.centerY.equalTo(self.Airlogo);
        }];

        [self.plan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.back2).offset(28);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.centerX.equalTo(self.contentView);
        }];
        [self.plantext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.plan);
            make.centerX.equalTo(self.plan);
        }];
        [self.PunctualityRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.plan.mas_bottom).offset(9);
            make.centerX.equalTo(self.plan);
        }];
        

        
        [self.planLeftOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.planLeftTwo);
            make.right.equalTo(self.planLeftTwo);
            make.bottom.equalTo(self.planLeftTwo.mas_top).offset(-10);
        }];
        [self.planLeftTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.plan.mas_left);
            make.bottom.equalTo(self.plan);
            make.height.equalTo(@24);
        }];
        [self.planLeftThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.planLeftTwo);
            make.right.equalTo(self.planLeftTwo);
            make.top.equalTo(self.planLeftTwo.mas_bottom).offset(10);
        }];
        
        [self.planRightOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.planRightTwo);
            make.right.equalTo(self.planRightTwo);
            make.bottom.equalTo(self.planRightTwo.mas_top).offset(-10);
        }];
        [self.planRightTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.plan.mas_right);
            make.right.equalTo(self.back);
            make.bottom.equalTo(self.plan);
            make.height.equalTo(@24);
        }];
        [self.planRightThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.planRightTwo);
            make.right.equalTo(self.planRightTwo);
            make.top.equalTo(self.planRightTwo.mas_bottom).offset(10);
        }];

        [self.Air mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline);
            make.width.equalTo(@25);
            make.height.equalTo(@12);
            make.bottom.equalTo(self.Airline.mas_top).offset(-3);
        }];
        
        [self.Airline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.height.equalTo(@(3));
            make.bottom.equalTo(self.back2).offset(-20);
        }];

        [self.startPlacePng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline);
            make.centerY.equalTo(self.back3);
            make.width.equalTo(@30);
            make.height.equalTo(@16);
        }];
        [self.startPlace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.startPlacePng.mas_right).offset(13);
            make.centerY.equalTo(self.back3);
        }];
        [self.startweather mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.startPlace.mas_right);
            make.right.equalTo(self.Airline);
            make.centerY.equalTo(self.startPlace);
        }];
        /////////////////

        
        [self.startLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline);
            make.bottom.equalTo(self.back4.mas_centerY).offset(-5);
        }];
        [self.startLabel_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.startLabel_1);
        }];
        [self.startLabel_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.Airline);
            make.centerY.equalTo(self.startLabel_2);
        }];
        [self.startLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.startLabel_1);
            make.top.equalTo(self.startLabel_1.mas_bottom).offset(10);
        }];
        [self.startLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.startLabel_2);
            make.top.equalTo(self.startLabel_2.mas_bottom).offset(10);
        }];
        [self.startLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.startLabel_3);
            make.top.equalTo(self.startLabel_3.mas_bottom).offset(10);
        }];
        
        [self.endPlacePng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline);
            make.centerY.equalTo(self.back5);
            make.width.equalTo(@30);
            make.height.equalTo(@16);
        }];
        
        [self.endPlace mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.endPlacePng.mas_right).offset(13);
            make.centerY.equalTo(self.back5);
        }];
        [self.endweather mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.endPlace.mas_right);
            make.right.equalTo(self.Airline);
            make.centerY.equalTo(self.endPlace);
        }];
        [self.endLabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline);
            make.bottom.equalTo(self.back6.mas_centerY).offset(-5);
        }];
        [self.endLabel_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.startLabel_2);
            make.centerY.equalTo(self.endLabel_1);
        }];

        
        [self.endLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.endLabel_1);
            make.top.equalTo(self.endLabel_1.mas_bottom).offset(10);
        }];
        [self.endLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.endLabel_2);
            make.centerY.equalTo(self.endLabel1);
        }];

        [self.airNameTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline);
            make.centerY.equalTo(self.back7);
        }];
        [self.airNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.Airline);
            make.centerY.equalTo(self.airNameTwo);
        }];


        self.peopleLogo.backgroundColor = [UIColor whiteColor];
        [self.peopleLogo SetFilletWith:31];
        [self.peopleLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline);
            make.centerY.equalTo(self.back8);
            make.width.equalTo(@31);
            make.height.equalTo(@31);
        }];
        
        [self.peopleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.peopleLogo.mas_right).offset(10);
            make.centerY.equalTo(self.back8);
        }];
        [self.peopleNumberDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.peopleNumber.mas_left).offset(-10);
            make.centerY.equalTo(self.peopleName);
        }];
        [self.peopleNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.Airline);
            make.centerY.equalTo(self.peopleName);
        }];
        self.peopleNumber.numberOfLines = 0;
//        self.Airline.backgroundColor = ColorWithHex(0x47BF6B, 0.2);
        [self.Airline SetFilletWith:PICTURE_FILLET_SIZE];
        [self.AirName setWithColor:0xFFFFFF  Alpha:1.0 Font:12 ROrM:@"m"];  //0x1E2D46
        [self.AirDate setWithColor:0xFFFFFF  Alpha:0.4 Font:12 ROrM:@"r"];
//        [self.plantext setWithColor:0xFFFFFF  Alpha:1.0 Font:14 ROrM:@"r"];
        

        
        [self.planLeftOne setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        [self.planLeftTwo setWithColor:0x475468  Alpha:1.0 Font:24 ROrM:@"m"];
        [self.planLeftThree setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        
        [self.planRightOne setWithColor:0x475468 Alpha:0.6 Font:12 ROrM:@"r"];
        [self.planRightTwo setWithColor:0x475468  Alpha:1.0 Font:24 ROrM:@"m"];
        [self.planRightThree setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        
        [self.PunctualityRate setWithColor:0x899097  Alpha:1.0 Font:12 ROrM:@"r"];

        
        [self.startweather setWithColor:0x475468  Alpha:1.0 Font:12 ROrM:@"r"];
        
        [self.startLabel_1 setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        [self.startLabel_2 setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        [self.startLabel_3 setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        
        [self.startLabel1 setWithColor:0x475468  Alpha:1.0 Font:14 ROrM:@"m"];
        [self.startLabel2 setWithColor:0x475468  Alpha:1.0 Font:14 ROrM:@"m"];
        [self.startLabel3 setWithColor:0x475468  Alpha:1.0 Font:14 ROrM:@"m"];
        

        [self.endweather setWithColor:0x475468  Alpha:1.0 Font:12 ROrM:@"r"];
        
        
        [self.endLabel_1 setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        [self.endLabel_2 setWithColor:0x475468  Alpha:0.6 Font:12 ROrM:@"r"];
        
        [self.endLabel1 setWithColor:0x475468  Alpha:1.0 Font:14 ROrM:@"m"];
        [self.endLabel2 setWithColor:0x475468  Alpha:1.0 Font:14 ROrM:@"m"];
        

        
        [self.airNameTwo setWithColor:0x475468   Alpha:1.0 Font:14 ROrM:@"r"];
        [self.airNumber setWithColor:0x475468  Alpha:1.0 Font:14 ROrM:@"m"];
        
        [self.peopleName setWithColor:0xFFFFFF  Alpha:1.0 Font:12 ROrM:@"r"];
        [self.peopleNumberDes setWithColor:0xFFFFFF  Alpha:0.7 Font:12 ROrM:@"m"];
        [self.peopleNumber setWithColor:0xFFFFFF  Alpha:0.4 Font:12 ROrM:@"r"];
        [self.plan SetFilletWith:44];

        
        self.AirDate.textAlignment = NSTextAlignmentRight;
        self.startweather.textAlignment = NSTextAlignmentRight;
        self.endweather.textAlignment = NSTextAlignmentRight;
        self.airNumber.textAlignment = NSTextAlignmentRight;
        
        self.planLeftOne.textAlignment = NSTextAlignmentCenter;
        self.planLeftTwo.textAlignment = NSTextAlignmentCenter;
        self.planLeftThree.textAlignment = NSTextAlignmentCenter;
        self.planRightOne.textAlignment = NSTextAlignmentCenter;
        self.planRightTwo.textAlignment = NSTextAlignmentCenter;
        self.planRightThree.textAlignment = NSTextAlignmentCenter;
        self.PunctualityRate.textAlignment = NSTextAlignmentCenter;
        self.startLabel_2.textAlignment = NSTextAlignmentCenter;
        self.endLabel_2.textAlignment = NSTextAlignmentCenter;

        self.planLeftOne.text = @"预计起飞";
        self.planRightOne.text = @"预计到达";
        self.startLabel_1.text = @"航站楼";
        self.startLabel_2.text = @"登机口";
        self.startLabel_3.text = @"值机柜台";
        self.airNameTwo.text = @"前序航班";
        self.endLabel_1.text = @"航站楼";
        self.endLabel_2.text = @"行李转盘";
        self.peopleNumberDes.text = @"票号 ";
        
        [self.back SetContentModeScaleAspectFill];
        [self.back22 SetContentModeScaleAspectFill];
        [self.back4 SetContentModeScaleAspectFill];
        [self.back5 SetContentModeScaleAspectFill];
        [self.back6 SetContentModeScaleAspectFill];
        [self.back7 SetContentModeScaleAspectFill];
        [self.back8 SetContentModeScaleAspectFill];
        [self.back2 SetContentModeScaleAspectFill];
        [self.back3 SetContentModeScaleAspectFill];

//        self.back2.contentMode = UIViewContentModeBottom;
//        self.back2.clipsToBounds = YES;
//        self.back3.contentMode = UIViewContentModeTop;
//        self.back3.clipsToBounds = YES;
        
        self.back.image = ImageNamed(PIC_HOME_AIRBACK1);
        self.back2.image = ImageNamed(@"机票券背景01");
//        self.back22.image = ImageNamed(PIC_HOME_AIRBACKLINE);
        self.back3.image = ImageNamed(@"出发背景切图");
        self.back4.image = ImageNamed(PIC_HOME_AIRBACK4);
//        self.back5.image = ImageNamed(PIC_HOME_AIRBACK5);
        self.back5.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:234/255.0 alpha:1/1.0];

        self.back6.image = ImageNamed(PIC_HOME_AIRBACK6);
//        self.back7.image = ImageNamed(PIC_HOME_AIRBACK7);
        self.back7.backgroundColor = [UIColor colorWithRed:247/255.0 green:248/255.0 blue:250/255.0 alpha:1/1.0];

        self.back8.image = ImageNamed(PIC_HOME_AIRBACK8);
        self.Air.image = [UIImage imageNamed:@"飞机图标"];
        
        self.endPlacePng.image = [UIImage imageNamed:@"到达图标"];
        self.startPlacePng.image = [UIImage imageNamed:@"出发"];
    }
    return self;
}
- (void)setBankCardOne:(bankCard *)bankCardOne{
    _bankCardOne = bankCardOne;
    self.AirName.text = [NSString stringWithFormat:@"%@ %@",bankCardOne.airName,bankCardOne.flightNo];
    self.AirDate.text = bankCardOne.depDate;
    
    self.planLeftTwo.text = self.bankCardOne.depTime;
    self.planRightTwo.text = self.bankCardOne.arrTime;
    self.planLeftThree.text = [NSString stringWithFormat:@"%@%@",@"计划起飞 ",bankCardOne.depTime];
    self.planRightThree.text = [NSString stringWithFormat:@"%@%@",@"计划到达 ",bankCardOne.arrTime];
    self.peopleName.text = bankCardOne.passengerName;
    
    NSString *tpm = [bankCardOne.ticketNo  stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    tpm = [tpm  stringByReplacingOccurrencesOfString:@"，" withString:@"\n"];
    self.peopleNumber.text = tpm;
    
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
//    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"  出发  "];
//    one.yy_font = PingFangSC_Regular(12);
//    one.yy_color = ColorWithHex(0x47BF6B, 1.0);
//    YYTextBorder *border = [YYTextBorder new];
//    border.cornerRadius = PICTURE_FILLET_SIZE*0.5;
//    border.insets = UIEdgeInsetsMake(0, 3, 0, 3);
//    border.strokeWidth = 0.5;
//    border.strokeColor = one.yy_color;
//    border.lineStyle = YYTextLineStyleSingle;
//    one.yy_textBackgroundBorder = border;
//    [text appendAttributedString:one];
//    self.startPlace.attributedText = text;
    

    NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@)",bankCardOne.depCityName,bankCardOne.depCityCode]];
    two.yy_font = PingFangSC_Medium(14);
    two.yy_color = ColorWithHex(0x475468, 1.0);
    [text appendAttributedString:two];
    self.startPlace.attributedText = text;
    
    NSMutableAttributedString *textTwo = [NSMutableAttributedString new];
//    NSMutableAttributedString *endPlaceTwo = [[NSMutableAttributedString alloc] initWithString:@"  到达  "];
//    endPlaceTwo.yy_font = PingFangSC_Regular(12);
//    endPlaceTwo.yy_color = ColorWithHex(0x47BF6B, 1.0);
//    endPlaceTwo.yy_textBackgroundBorder = border;
//    [textTwo appendAttributedString:endPlaceTwo];
    
    
    NSMutableAttributedString *endPlaceTwotwo = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@)",bankCardOne.arrCityName,bankCardOne.arrCityCode]];
    endPlaceTwotwo.yy_font = PingFangSC_Medium(14);
    endPlaceTwotwo.yy_color = ColorWithHex(0x475468, 1.0);
    [textTwo appendAttributedString:endPlaceTwotwo];
    self.endPlace.attributedText = textTwo;
    

    [self.peopleLogo sd_setImageWithURL:[[PortalHelper sharedInstance]get_userInfo].headUrl];
    [self.Airlogo sd_setImageWithURL:bankCardOne.airLogo placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
    if (![self.AirInfoOne isKindOfClass:[AirInfo class]]) {
        [self loadData];
    }
}
- (void)setAirInfoOne:(id)AirInfoOne{
    if ([AirInfoOne isKindOfClass:[AirInfo class]]) {
        _AirInfoOne = AirInfoOne;
        AirInfo *one = AirInfoOne;

        self.airNumber.text = one.preFlightNo;
        self.startweather.text = one.depWeather;
        self.endweather.text = one.arrWeather;;
        self.PunctualityRate.text = [NSString stringWithFormat:@"%@%@",@"准点率",one.rate];
        self.startLabel1.text = one.depTerminal;
        self.startLabel2.text = one.boardingGate;
        self.startLabel3.text = one.flightzj;
        self.endLabel1.text = one.arrTerminal;
        self.endLabel2.text = one.carousel&&one.carousel?one.carousel:@"--";
        
        if ([one.flightStatus isEqualToString:@"1"]) {
//            self.plan.text = @"计划";
            self.plan.image = [UIImage imageNamed:@"计划"];
            self.PunctualityRate.textColor = [UIColor colorWithRed:120/255.0 green:193/255.0 blue:40/255.0 alpha:1/1.0];
            self.Airline.image = [UIImage imageNamed:@"计划进度条"];
            self.planLeftOne.text = @"预计起飞";
            self.planRightOne.text = @"预计到达";
            self.planLeftTwo.text = self.bankCardOne.depTime;
            self.planRightTwo.text = self.bankCardOne.arrTime;
        } else if ([one.flightStatus isEqualToString:@"2"]) {
//            self.plantext.text = @"预警";
            self.plan.image = [UIImage imageNamed:@"预警"];
            self.PunctualityRate.textColor = [UIColor colorWithRed:255/255.0 green:155/255.0 blue:50/255.0 alpha:1/1.0];
            self.Airline.image = [UIImage imageNamed:@"预警进度条"];
            self.planLeftOne.text = @"预计起飞";
            self.planRightOne.text = @"预计到达";
            self.planLeftTwo.text = self.bankCardOne.depTime;
            self.planRightTwo.text = self.bankCardOne.arrTime;
        } else if ([one.flightStatus isEqualToString:@"3"]) {
//            self.plantext.text = @"延误";
            self.plan.image = [UIImage imageNamed:@"延误"];
            self.PunctualityRate.textColor = [UIColor colorWithRed:255/255.0 green:98/255.0 blue:50/255.0 alpha:1/1.0];
            self.Airline.image = [UIImage imageNamed:@"延误进度条"];
            self.planLeftOne.text = @"预计起飞";
            self.planRightOne.text = @"预计到达";
            self.planLeftTwo.text = self.bankCardOne.depTime;
            self.planRightTwo.text = self.bankCardOne.arrTime;
        } else if ([one.flightStatus isEqualToString:@"4"]) {
//            self.plantext.text = @"起飞";
            self.plan.image = [UIImage imageNamed:@"起飞"];
            self.PunctualityRate.textColor = [UIColor colorWithRed:50/255.0 green:163/255.0 blue:255/255.0 alpha:1/1.0];
            self.Airline.image = [UIImage imageNamed:@"起飞进度条"];
            self.planLeftOne.text = @"实际起飞";
            self.planRightOne.text = @"实际到达";
            self.planLeftTwo.text = one.depActual;
            self.planRightTwo.text = one.arrActual;
        } else if ([one.flightStatus isEqualToString:@"5"]) {
//            self.plantext.text = @"到达";
            self.plan.image = [UIImage imageNamed:@"到达"];
            self.PunctualityRate.textColor = [UIColor colorWithRed:50/255.0 green:163/255.0 blue:255/255.0 alpha:1/1.0];
            self.Airline.image = [UIImage imageNamed:@"到达进度条"];
            self.planLeftOne.text = @"实际起飞";
            self.planRightOne.text = @"实际到达";
            self.planLeftTwo.text = one.depActual;
            self.planRightTwo.text = one.arrActual;
        } else if ([one.flightStatus isEqualToString:@"6"]) {
//            self.plantext.text = @"取消";
            self.plan.image = [UIImage imageNamed:@"取消AIR"];
            self.PunctualityRate.textColor = [UIColor colorWithRed:255/255.0 green:73/255.0 blue:73/255.0 alpha:1/1.0];
            self.Airline.image = nil;
            self.Airline.backgroundColor = [UIColor colorWithRed:255/255.0 green:218/255.0 blue:219/255.0 alpha:1/1.0];
            self.planLeftOne.text = @"预计起飞";
            self.planRightOne.text = @"预计到达";
            self.planLeftTwo.text = self.bankCardOne.depTime;
            self.planRightTwo.text = self.bankCardOne.arrTime;
        } else if ([one.flightStatus isEqualToString:@"7"]) {
//            self.plantext.text = @"迫降";
            self.plan.image = [UIImage imageNamed:@"迫降"];
            self.PunctualityRate.textColor = [UIColor colorWithRed:255/255.0 green:112/255.0 blue:105/255.0 alpha:1/1.0];
            self.Airline.image = [UIImage imageNamed:@"迫降进度条"];
            self.planLeftOne.text = @"实际起飞";
            self.planRightOne.text = @"实际到达";
            self.planLeftTwo.text = one.depActual;
            self.planRightTwo.text = one.arrActual;
        }
        
        if ([one.flightStatus isEqualToString:@"1"] || [one.flightStatus isEqualToString:@"5"] ||  [one.flightStatus isEqualToString:@"4"]) {
            self.plan.backgroundColor = ColorWithHex(0x47BF6B, 1.0);
        } else if ([one.flightStatus isEqualToString:@"2"] ) {
            self.plan.backgroundColor = ColorWithHex(0xF7CE4C, 1.0);
        } else if ([one.flightStatus isEqualToString:@"3"]) {
            self.plan.backgroundColor = ColorWithHex(0xFB915C, 1.0);
        } else if ([one.flightStatus isEqualToString:@"6"] ) {
            self.plan.backgroundColor = ColorWithHex(0xFF4949, 1.0);
        } else if ([one.flightStatus isEqualToString:@"7"] ) {
            self.plan.backgroundColor = ColorWithHex(0xFF7069, 1.0);
        }

        if ([one.flyTimePercent containsString:@"%"]) {
            one.flyTimePercent = [one.flyTimePercent stringByReplacingOccurrencesOfString:@"%" withString:@""];
        }
        [self.Air mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Airline).offset((SCREENWIDTH-40-40-25)*[one.flyTimePercent floatValue]/100.0);
            make.width.equalTo(@25);
            make.height.equalTo(@12);
            make.bottom.equalTo(self.Airline.mas_top).offset(-3);
        }];
    }else{
        _AirInfoOne = nil;
    }
}
-(void)loadData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_flightqueryGssFlightDynamicWithdepDate:self.bankCardOne.depDate flightNo:self.bankCardOne.flightNo depTime:self.bankCardOne.depTime arrTime:self.bankCardOne.arrTime success:^(id dataDict, NSString *msg, NSInteger code) {
        AirInfo *data = [AirInfo mj_objectWithKeyValues:dataDict];
        if (weakself.loadSucces) {
            weakself.loadSucces(data,weakself.indexx,self.bankCardOne);
        }
        weakself.AirInfoOne = data;
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"msg=%@",msg);
        [weakself performSelector:@selector(loadData) withObject:nil afterDelay:0.3f];
    }];
}
@end
