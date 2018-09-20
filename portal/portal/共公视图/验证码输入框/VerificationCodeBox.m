//
//  VerificationCodeBox.m
//  portal
//
//  Created by Store on 2017/11/22.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "VerificationCodeBox.h"
#import "HeaderAll.h"
@interface VerificationCodeBox ()<UITextFieldDelegate>

@end

@implementation VerificationCodeBox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.close.hidden = YES;
        self.back.userInteractionEnabled = YES;
        [self.back SetFilletWith:0.0];

        
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-150);
            make.height.equalTo(@224);
        }];
        
        UILabel *title = [[UILabel alloc]init];
        self.title = title;
        [self addSubview:title];
        
        UIImageView *backkPng = [[UIImageView alloc]init];
        self.backkPng = backkPng;
        [self addSubview:backkPng];
        
        UIButton *backk = [[UIButton alloc]init];
        self.backk = backk;
        [self addSubview:backk];
        
        UIView *Line = [[UIView alloc]init];
        self.Line = Line;
        [self addSubview:Line];
        
        UILabel *des = [[UILabel alloc]init];
        self.des = des;
        [self addSubview:des];
        
        UIView *backMain = [[UIView alloc]init];
        self.backMain = backMain;
        [self addSubview:backMain];
        
        UITextField *codeInput = [[UITextField alloc]init];
        self.codeInput = codeInput;
        [self addSubview:codeInput];
        
        UIView *suLine = [[UIView alloc]init];
        self.suLine = suLine;
        [self addSubview:suLine];
        
        UIButton *resent = [UIButton buttonWithType:UIButtonTypeCustom];
        self.resent = resent;
        [self addSubview:resent];
        
        UIButton *okBtn = [[UIButton alloc]init];
        self.okBtn = okBtn;
        [self addSubview:okBtn];
        
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(0);
            make.right.equalTo(self.back).offset(0);
            make.top.equalTo(self.back).offset(16);
            make.height.equalTo(@17);
        }];
        [self.backkPng mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.centerY.equalTo(self.title).offset(0);
            make.width.equalTo(@8.3);
            make.height.equalTo(@15);
        }];
        [self.backk mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backkPng).offset(0);
            make.centerX.equalTo(self.backkPng).offset(0);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
        }];
        [self.Line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(0);
            make.right.equalTo(self.back).offset(0);
            make.top.equalTo(self.title.mas_bottom).offset(17);
            make.height.equalTo(@0.5);
        }];
        [self.des mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.top.equalTo(self.Line.mas_bottom).offset(15);
            make.height.equalTo(@12);
        }];
        [self.backMain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.des).offset(0);
            make.right.equalTo(self.des).offset(0);
            make.top.equalTo(self.des.mas_bottom).offset(15);
            make.height.equalTo(@60);
        }];
        [self.resent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backMain).offset(-15);
            make.centerY.equalTo(self.backMain);
            make.width.equalTo(@100);
        }];
        [self.suLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.resent.mas_left).offset(-15);
            make.top.equalTo(self.backMain).offset(15);
            make.bottom.equalTo(self.backMain).offset(-15);
            make.width.equalTo(@0.5);
        }];
        [self.codeInput mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backMain).offset(15);
            make.right.equalTo(self.suLine).offset(-10);
            make.top.equalTo(self.backMain);
            make.bottom.equalTo(self.backMain);
        }];
        [self.okBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.des).offset(0);
            make.right.equalTo(self.des).offset(0);
            make.top.equalTo(self.backMain.mas_bottom).offset(10);
            make.height.equalTo(@50);
        }];
        [title setWithColor:0x161E2B Alpha:0.7 Font:17 ROrM:@"r"];
        [des setWithColor:0x9DA4AE Alpha:0.7 Font:12 ROrM:@"r"];
        Line.backgroundColor = ColorWithHex(0xCBCED3, 1.0);
        suLine.backgroundColor = ColorWithHex(0xCBCED3, 1.0);
        backMain.backgroundColor = [UIColor whiteColor];
        self.back.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
        [resent setWithNormalColor:0xCBCED3 NormalAlpha:0.7 NormalTitle:nil NormalImage:nil NormalBackImage:nil SelectedColor:0x5E7FFF SelectedAlpha:0.7 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        title.text = @"身份验证";
        des.text = [NSString stringWithFormat:@"系统已发送验证码到%@,请查收",[[PortalHelper sharedInstance]get_userInfo].bankMobile];
        [okBtn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"确定" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [okBtn setBackgroundImage:[ColorWithHex(0x5E7FFF, 1.0) imageWithColor] forState:UIControlStateNormal];
        [codeInput setWithColor:0x1E2E47 Alpha:0.7 Font:16 ROrM:@"r"];
        resent.userInteractionEnabled = NO;
        
        [self.codeInput setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        self.codeInput.placeholder = @"请输入短信验证码";
        self.title.textAlignment = NSTextAlignmentCenter;
        self.backkPng.image = [UIImage imageNamed:@"返回"];
        [self.backk addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.codeInput.delegate = self;
        [self.resent addTarget:self action:@selector(resentClick) forControlEvents:UIControlEventTouchUpInside];
        self.codeInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.codeInput.keyboardType = UIKeyboardTypeNumberPad;
//        [self creatTimer];
    }
    return self;
}
#pragma mark----创建定时器
-(void)creatTimer
{
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
#ifdef DEBUG
    self.num = 60;
#else
    self.num = 60;
#endif
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiRunning) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    self.resent.userInteractionEnabled = NO;
    self.resent.selected = NO;
    [self selfresentsetTitle];
}
- (void)selfresentsetTitle{
    [self.resent setTitle:@"60s后重新发送" forState:UIControlStateNormal];
}
#pragma mark----倒计时
-(void)daojishiRunning{
    self.num--;
    if (self.num == 0) {
        [self removeTimer];
    }else{
        [self.resent setTitle:[NSString stringWithFormat:@"%lds后重新发送",(long)self.num] forState:UIControlStateNormal];
    }
}
#pragma mark----移除定时器
-(void)removeTimer
{
    self.resent.selected = YES;
    [self.resent setTitle:@"重新发送" forState:UIControlStateNormal];
    self.resent.userInteractionEnabled = YES;
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
    if (self.timeOut) {
        self.timeOut();
    }
}
- (void)cancleBtn{
    if (self.cannelPay) {
        self.cannelPay();
    }
}
- (void)okBtnClick{
    if (self.Fill_in_the_text && self.codeInput.text.length == 6) {
        self.Fill_in_the_text(self.codeInput.text);
    }else{
        [MBProgressHUD showPrompt:@"请输入正确的验证码"];
    }
}
- (void)resentClick{
    if (self.resendSmsCode) {
        self.resendSmsCode();
    }
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        BOOL tmp = NO;
        if (textField.text.length + string.length >6) {
            return NO;
        }
        NSCharacterSet*cs = [NSCharacterSet decimalDigitCharacterSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        tmp =  ![string isEqualToString:filtered];
        return tmp;
    }
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
    if ([self.codeInput canBecomeFirstResponder]) {
        [self.codeInput becomeFirstResponder];
    }
}
- (void)dealloc{
    [self removeTimer];
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
    return YES;
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop
//{
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
//    return YES;
//}
@end
