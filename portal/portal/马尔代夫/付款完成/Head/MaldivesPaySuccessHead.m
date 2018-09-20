//
//  MaldivesPaySuccessHead.m
//  portal
//
//  Created by Store on 2018/3/13.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "MaldivesPaySuccessHead.h"

@interface MaldivesPaySuccessHead ()
@property (nonatomic, weak) UILabel *moneyNow;
@property (nonatomic, weak) UILabel *moneyOld;
@end

@implementation MaldivesPaySuccessHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.icon.image = [UIImage imageNamed:@"logomedf"];
        self.backgroundColor = [UIColor whiteColor];
        [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(20);
            make.height.equalTo(@(60*PROPORTION_WIDTH));
            make.width.equalTo(@(60*PROPORTION_WIDTH));
        }];
        {
            UILabel *label = [[UILabel alloc] init];
//            label.frame = CGRectMake(141, 156, 93, 29);
//            label.text = @"1950.21";
            label.font = [UIFont fontWithName:@"SFUIText-Medium" size:24];
            label.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
            self.moneyNow = label;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.icon);
                make.top.equalTo(self.icon.mas_bottom).offset(10);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
//            label.frame = CGRectMake(246, 166, 55, 16);
//            label.text = @"1950.00";
            label.font = [UIFont fontWithName:@"SFUIText-Regular" size:14];
            label.textColor = [UIColor colorWithRed:133/255.0 green:142/255.0 blue:155/255.0 alpha:1/1.0];
            self.moneyOld = label;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.moneyNow.mas_right).offset(12);
                make.bottom.equalTo(self.moneyNow);
            }];
        }
        [self.titlee mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.icon);
            make.top.equalTo(self.moneyNow.mas_bottom).offset(10);
        }];
        
        //中划线
//        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
//        self.moneyOld.attributedText = attribtStr;
    }
    return self;
}
- (void)setNoticationdata:(MaldivesPush *)noticationdata{
    _noticationdata = noticationdata;
    self.titlee.text = noticationdata.conten.tranName;
    self.moneyNow.text = [NSString stringWithFormat:@"%.2f",[noticationdata.conten.tranAmt doubleValue]];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f",[noticationdata.conten.tranAmt doubleValue]] attributes:attribtDic];
    self.moneyOld.attributedText = attribtStr;

}
@end
