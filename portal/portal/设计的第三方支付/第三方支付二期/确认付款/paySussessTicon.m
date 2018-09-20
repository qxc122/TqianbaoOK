//
//  paySussessTicon.m
//  portal
//
//  Created by MiNi on 2018/5/10.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "paySussessTicon.h"
#import "Masonry.h"
#import "MACRO_COLOR.h"
@interface paySussessTicon ()
@property (nonatomic,weak) UIButton *StayT;
@property (nonatomic,weak) UIButton *leave;
@end

@implementation paySussessTicon

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *StayT = [UIButton new];
        self.StayT  =StayT;
        [self addSubview:StayT];
        [StayT mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@(51));
        }];
        
        {
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.centerY.equalTo(StayT.mas_top);
                make.height.equalTo(@(0.5));
            }];
            view.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
        }

        
        UIButton *leave = [UIButton new];
        self.leave  =leave;
        [self addSubview:leave];
        [leave mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(StayT.mas_top);
            make.height.equalTo(@(51));
        }];
        {
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.centerY.equalTo(leave.mas_top);
                make.height.equalTo(@(0.5));
            }];
            view.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"付款成功";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            [self addSubview:label];
            [label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).offset(20);
                make.height.equalTo(@17);
                make.bottom.equalTo(self.leave.mas_top).offset(-36);
            }];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"成功"];
            [self addSubview:imageView];
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(label);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
                make.right.equalTo(label.mas_left).offset(-10);
            }];
        }

        [self.leave setTitle:@"返回" forState:UIControlStateNormal];
        [self.leave setTitleColor:ColorWithHex(0x0076FF, 1.0) forState:UIControlStateNormal];
        self.leave.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        [self.leave addTarget:self action:@selector(leaveBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self.StayT setTitle:@"留在T钱包" forState:UIControlStateNormal];
        [self.StayT setTitleColor:ColorWithHex(0x0076FF, 1.0) forState:UIControlStateNormal];
        self.StayT.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        [self.StayT addTarget:self action:@selector(StayTBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)setWhoCalls:(NSString *)WhoCalls{
    _WhoCalls = WhoCalls;
    if ([WhoCalls isEqualToString:@"TempusPortal"]) {
        [self.leave setTitle:@"返回腾邦生活" forState:UIControlStateNormal];
    }else if([WhoCalls isEqualToString:@"zeji"]){
        [self.leave setTitle:@"返回择机" forState:UIControlStateNormal];
    }else {
        [self.leave setTitle:@"返回腾邦通" forState:UIControlStateNormal];
    }
}
- (void)leaveBtn{
    if (self.leaveBtnBlock) {
        self.leaveBtnBlock();
    }
}
- (void)StayTBtn{
    if (self.StayTBtnBlock) {
        self.StayTBtnBlock();
    }
}
@end
