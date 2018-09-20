//
//  ConfirmThePayment.m
//  portal
//
//  Created by MiNi on 2018/5/10.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "ConfirmThePayment.h"

@interface ConfirmThePayment ()
@property (nonatomic,weak) UILabel *titlem;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *payType;

@property (nonatomic,weak) UILabel *TMoney;
@property (nonatomic,weak) UILabel *TMoneyRed;
@property (nonatomic,weak) UILabel *Ttitle;
@property (nonatomic,weak) UIView *Tline;
@property (nonatomic,weak) UISwitch *btn;
@end


@implementation ConfirmThePayment

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.back.userInteractionEnabled = YES;
        [self.back SetFilletWith:0];
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@(378));
        }];
        
        [self.close mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.left.equalTo(self.back).offset(5.5);
            make.top.equalTo(self.back).offset(0.5);
        }];
        [self.close setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        
        UILabel *title = [UILabel new];
        [self.back addSubview:title];
        UIImageView *titleIcon = [UIImageView new];
        [self.back addSubview:titleIcon];
        
        
        UILabel *titleY = [UILabel new];
        [self.back addSubview:titleY];
        UILabel *titlem = [UILabel new];
        self.titlem = titlem;
        [self.back addSubview:titlem];

        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.back).offset(25/2.0);
            make.centerY.equalTo(self.close);
        }];
        [titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(title.mas_left).offset(-5.0);
            make.centerY.equalTo(self.close);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        [titlem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(29);
            make.centerX.equalTo(self.back).offset(19/2.0);
            make.height.equalTo(@32);
        }];
        [titleY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titlem.mas_left).offset(-5.0);
            make.bottom.equalTo(titlem).offset(-2);
            make.height.equalTo(@18);
        }];

        [title setWithColor:0x10213A Alpha:1.0 Font:18 ROrM:@"r"];
        [titlem setWithColor:0x10213A Alpha:1.0 Font:32 ROrM:@"m"];
        [titleY setWithColor:0x10213A Alpha:1.0 Font:18 ROrM:@"m"];

        title.text  =@"确认付款";
        titleY.text = @"¥";
        titleIcon.image = [UIImage imageNamed:@"T钱包图标"];
        
        titlem.text = @"100.0";
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"产品名称";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:133/255.0 green:142/255.0 blue:155/255.0 alpha:1/1.0];

            [self.back addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(20);
                make.top.equalTo(titlem.mas_bottom).offset(40);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            self.name = label;
            label.text = @"---";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
            
            [self.back addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(100);
                make.right.equalTo(self.back).offset(-20);
                make.top.equalTo(titlem.mas_bottom).offset(40);
                make.height.equalTo(@15);
            }];

            UIView *view = [[UIView alloc] init];
            view.backgroundColor = ColorWithHex(0xDADEE3, 1.0);
            [self.back addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(20);
                make.right.equalTo(self.back).offset(-20);
                make.top.equalTo(label.mas_bottom).offset(20);
                make.height.equalTo(@0.5);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"付款方式";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:133/255.0 green:142/255.0 blue:155/255.0 alpha:1/1.0];
            
            [self.back addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(20);
                make.top.equalTo(self.name.mas_bottom).offset(42);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            self.payType = label;
            label.text = @"零钱";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
            
            [self.back addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(100);
                make.right.equalTo(self.back).offset(-20);
                make.top.equalTo(self.name.mas_bottom).offset(42);
                make.height.equalTo(@15);
            }];
            
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = ColorWithHex(0xDADEE3, 1.0);
            [self.back addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(20);
                make.right.equalTo(self.back).offset(-20);
                make.top.equalTo(label.mas_bottom).offset(20);
                make.height.equalTo(@0.5);
            }];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"更多.png"];
            [self.back addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view);
                make.centerY.equalTo(label);
                make.width.equalTo(@6);
                make.height.equalTo(@10);
            }];
            
            
            UIButton *btn = [[UIButton alloc] init];
            [self.back addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(20);
                make.right.equalTo(self.back).offset(-20);
                make.centerY.equalTo(label);
                make.height.equalTo(@44);
            }];
            [btn addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
        {
            UILabel *label = [[UILabel alloc] init];
            self.Ttitle = label;
            label.text = @"T币抵扣";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:133/255.0 green:142/255.0 blue:155/255.0 alpha:1/1.0];
            
            [self.back addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(20);
                make.top.equalTo(self.payType.mas_bottom).offset(48);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            self.TMoney = label;
            label.text = @"可用40T币抵扣";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            label.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
            
            [self.back addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(100);
                make.top.equalTo(self.payType.mas_bottom).offset(48);
                make.height.equalTo(@15);
            }];
            
            {
                UILabel *label = [[UILabel alloc] init];
                label.text = @"40元";
                label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
                label.textColor = [UIColor colorWithRed:244/255.0 green:78/255.0 blue:86/255.0 alpha:1/1.0];
                self.TMoneyRed = label;
                [self.back addSubview:label];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.TMoney.mas_right);
                    make.top.equalTo(self.payType.mas_bottom).offset(48);
                    make.height.equalTo(@15);
                }];
            }
            
            UIView *view = [[UIView alloc] init];
            self.Tline = view;
            view.backgroundColor = ColorWithHex(0xDADEE3, 1.0);
            [self.back addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(20);
                make.right.equalTo(self.back).offset(-20);
                make.top.equalTo(label.mas_bottom).offset(20);
                make.height.equalTo(@0.5);
            }];
            
            UISwitch *btn = [[UISwitch alloc] init];
            self.btn = btn;
            [self.back addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.back).offset(-20);
                make.centerY.equalTo(label);
                make.width.equalTo(@44);
                make.height.equalTo(@44);
            }];
            [btn addTarget:self action:@selector(TmoneyClick:) forControlEvents:UIControlEventValueChanged];
        }
        UIButton *btn = [[UIButton alloc] init];
        [self.back addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.bottom.equalTo(self.back);
            make.height.equalTo(@50);
        }];
        [btn setWithNormalColor:0xffffff NormalAlpha:1.0 NormalTitle:@"确认支付" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x5E7FFF backAlpha:1.0];
        [btn addTarget:self action:@selector(btnOKClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)TmoneyClick:(UISwitch *)btn{
    NSString *ticon = @"0";
    if (btn.isOn) {
        ticon = @"1";
        self.titlem.text = self.pasteboarddata[@"money"];
        if (([self.pasteboarddata[@"money"] doubleValue] - [self.ThreeOkdata.integral doubleValue]) > 0) {
            self.titlem.text = [NSString stringWithFormat:@"%.2f",[self.pasteboarddata[@"money"] doubleValue] - [self.ThreeOkdata.integral doubleValue]];
        } else {
           self.titlem.text = @"0.00";
        }
    } else {
        ticon = @"0";
        self.titlem.text = self.pasteboarddata[@"money"];
    }
    if (self.Tmoneytype) {
        self.Tmoneytype(ticon);
    }
}
- (void)typeClick{
    if (self.type) {
        self.type();
    }
}
- (void)btnOKClick{
    if (self.doneOk) {
        self.doneOk();
    }
}
- (void)closeClisck{
    if (self.guanbi) {
        self.guanbi();
    }
}


- (void)windosViewshowSub:(UIView *)subView{
    [subView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subView);
        make.right.equalTo(subView);
        make.top.equalTo(subView);
        make.bottom.equalTo(subView);
    }];
}

- (void)setPayMethod:(NSString *)payMethod{
    _payMethod = payMethod;
    if ([payMethod isEqualToString:@"BAL"]) {
        self.payType.text = @"零钱";
    } else if ([payMethod isEqualToString:@"BANK"]) {
        ThreeOkBankOne *one = self.ThreeOkdata.bankCardsArray.firstObject;
        if (one) {
            self.payType.text = [NSString stringWithFormat:@"%@(%@)",one.bankName,one.cardNo];
        }
    }
}
- (void)setPasteboarddata:(NSDictionary *)pasteboarddata{
    _pasteboarddata = pasteboarddata;
    self.titlem.text = self.pasteboarddata[@"money"];
    self.name.text = self.pasteboarddata[@"businessName"];
    
    if ([self.pasteboarddata[@"supportTcoin"] isEqualToString:@"1"]) {
        self.TMoney.hidden = NO;
        self.TMoneyRed.hidden = NO;
        self.Ttitle.hidden = NO;
        self.Tline.hidden = NO;
        self.btn.hidden = NO;
    }else{
        self.TMoney.hidden = YES;
        self.TMoneyRed.hidden = YES;
        self.Ttitle.hidden = YES;
        self.Tline.hidden = YES;
        self.btn.hidden = YES;
    }
}
- (void)setThreeOkdata:(ThreeOk *)ThreeOkdata{
    _ThreeOkdata  =ThreeOkdata;
    if ([ThreeOkdata.integral intValue] >0) {
        if (([self.pasteboarddata[@"money"] doubleValue] - [self.ThreeOkdata.integral doubleValue]) > 0) {
            self.TMoney.text = [NSString stringWithFormat:@"可用%@T币抵扣",ThreeOkdata.integral];
            self.TMoneyRed.text = [NSString stringWithFormat:@"%@元",ThreeOkdata.integral];
        } else {
            NSInteger all = [self.pasteboarddata[@"money"] doubleValue] *100;
            if (all%100) {
                all = all/100 + 1;
            } else {
                all = all/100;
            }
            self.TMoney.text = [NSString stringWithFormat:@"可用%ldT币抵扣",(long)all];
            self.TMoneyRed.text = [NSString stringWithFormat:@"%.2f元",[self.pasteboarddata[@"money"] doubleValue]];
        }
        
        self.TMoney.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
        self.btn.enabled  = YES;
    } else {
        self.btn.enabled  = NO;
        self.TMoney.text = @"没有可抵扣的T币";
        self.TMoneyRed.text = nil;
        self.TMoney.textColor = [UIColor colorWithRed:160/255.0 green:166/255.0 blue:173/255.0 alpha:1/1.0];
    }
}
- (void)setIsOA:(BOOL)isOA{
    _isOA = isOA;
    if (isOA) {
        self.TMoney.hidden = YES;
        self.TMoneyRed.hidden = YES;
        self.Ttitle.hidden = YES;
        self.Tline.hidden = YES;
        self.btn.hidden = YES;
    }
}
@end
