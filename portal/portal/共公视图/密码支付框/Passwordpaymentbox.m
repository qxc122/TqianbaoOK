//
//  Passwordpaymentbox.m
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "Passwordpaymentbox.h"


@interface Passwordpaymentbox ()
@property (nonatomic,weak) UILabel *title;

@property (nonatomic,weak) UIView *suLine;
@property (nonatomic,weak) UIView *HonLine;
@property (nonatomic,weak) UIButton *LeftBtn;


@property (nonatomic,strong) NSString *passWord;
@end


@implementation Passwordpaymentbox
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.close.hidden = YES;
        self.back.userInteractionEnabled = YES;
        [self.back SetFilletWith:0.0];
//        CGFloat tmp = 64+50;
//        if (IPoneX) {
//            tmp += 20;
//        }
        
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-150);
            make.height.equalTo(@182);
        }];
        
//        UIButton *btn = [UIButton new];
//        [self addSubview:btn];
//        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.right.equalTo(self);
//            make.bottom.equalTo(self);
//            make.top.equalTo(self);
//        }];
//        btn.backgroundColor = [UIColor redColor];
        
        UILabel *title = [UILabel new];
        [self.back addSubview:title];
        self.title = title;


        
        
        SYPasswordView *input = [[SYPasswordView alloc]initWithFrame:CGRectMake(52*PROPORTION_WIDTH, 62, SCREENWIDTH-52*PROPORTION_WIDTH*2, 50)];
        self.input = input;
        kWeakSelf(self);
        input.Fill_in_the_text = ^(NSString *inText) {
            weakself.passWord = inText;
            if (weakself.Fill_in_the_text) {
                weakself.Fill_in_the_text(inText);
            }
//            if (inText.length == 6 /*&&  [weakself.input.textField canResignFirstResponder]*/) {
////                [weakself.input.textField resignFirstResponder];
//                [weakself closeClisck];
//            }
        };
        
        [self.back addSubview:input];
        
//        UIView *suLine = [UIView new];
//        [self.back addSubview:suLine];
//        self.suLine = suLine;
//
//        UIView *HonLine = [UIView new];
//        [self.back addSubview:HonLine];
//        self.HonLine = HonLine;
//
        UIButton *LeftBtn = [UIButton new];
        [self.back addSubview:LeftBtn];
        self.LeftBtn = LeftBtn;
        
        UIImageView *LeftBtnPNG = [UIImageView new];
        [self.back addSubview:LeftBtnPNG];
//
        UIButton *RightBtn = [UIButton new];
        [self.back addSubview:RightBtn];
        self.RightBtn = RightBtn;
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.top.equalTo(self.back).offset(20);
        }];
//        [self.suLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.back);
//            make.bottom.equalTo(self.back);
//            make.width.equalTo(@0.5);
//            make.height.equalTo(@50);
//        }];
//        [self.HonLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.back);
//            make.right.equalTo(self.back);
//            make.bottom.equalTo(self.suLine.mas_top);
//            make.height.equalTo(@0.5);
//        }];
        [self.LeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(3);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.centerY.equalTo(self.title);
        }];
        [LeftBtnPNG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.LeftBtn);
            make.width.equalTo(@9);
            make.height.equalTo(@16);
            make.centerY.equalTo(self.LeftBtn);
        }];
        
        [self.RightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.input);
            make.top.equalTo(self.input.mas_bottom);
            make.bottom.equalTo(self.back);
//            make.width.equalTo(@150);
        }];
//        self.suLine.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
//        self.HonLine.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
        [title setWithColor:0x10213A Alpha:1.0 Font:18 ROrM:@"r"];
        title.textAlignment = NSTextAlignmentCenter;

        title.text  =@"请输入支付密码";
        LeftBtnPNG.image = [UIImage imageNamed:@"反回按钮"];
        
//        [self.LeftBtn setWithNormalColor:0x0076FF NormalAlpha:1.0 NormalTitle:nil NormalImage:nil NormalBackImage:@"反回按钮" SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        
        [self.RightBtn setWithNormalColor:0xCBCED3 NormalAlpha:0.7 NormalTitle:NSLocalizedString(@"忘记密码", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [self.LeftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.RightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)btnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    if ([btn isEqual:self.LeftBtn]) {
        if (self.cannelPay) {
            self.cannelPay();
        } else {
            [self closeClisck];
        }
    } else {
        if (self.changePassWord) {
            [self closeClisck];
            self.changePassWord();
        }
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
    return YES;
    //    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop
{
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
    return YES;
}
- (void)windosViewshowWithsubView:(UIView *)subView{
    [subView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subView);
        make.right.equalTo(subView);
        make.top.equalTo(subView);
        make.bottom.equalTo(subView);
    }];
    [self performSelector:@selector(firstINput) withObject:nil afterDelay:0.3];
}
- (void)firstINput{
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 50.f;
    if ([self.input.textField canBecomeFirstResponder]) {
        [self.input.textField becomeFirstResponder];
    }
//    [self performSelector:@selector(firstINput) withObject:nil afterDelay:0.5];
}
- (void)ResignfirstINput{
    if ([self.input.textField canResignFirstResponder]) {
        [self.input.textField resignFirstResponder];
    }
}
@end
