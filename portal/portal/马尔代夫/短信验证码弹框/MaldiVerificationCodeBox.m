//
//  MaldiVerificationCodeBox.m
//  portal
//
//  Created by Store on 2018/3/13.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "MaldiVerificationCodeBox.h"

@implementation MaldiVerificationCodeBox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.back.backgroundColor = [UIColor whiteColor];
        self.title.text = @"找回支付密码";
        self.title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        self.title.textColor = [UIColor colorWithRed:16/255.0 green:33/255.0 blue:58/255.0 alpha:1/1.0];

        [self.codeInput mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Line);
            make.right.equalTo(self.resent.mas_left).offset(-20);
            make.top.equalTo(self.title.mas_bottom).offset(5);
            make.height.equalTo(@(50));
        }];
        
        [self.resent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.Line);
            make.centerY.equalTo(self.codeInput);
            make.width.equalTo(@70);
        }];
        [self.Line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.top.equalTo(self.codeInput.mas_bottom);
            make.height.equalTo(@0.5);
        }];
        [self.des mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.top.equalTo(self.Line.mas_bottom).offset(20);
            make.height.equalTo(@12);
        }];
        [self.okBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.des).offset(0);
            make.right.equalTo(self.des).offset(0);
            make.top.equalTo(self.des.mas_bottom).offset(23);
            make.height.equalTo(@50);
        }];
        self.des.text = [NSString stringWithFormat:@"系统已将验证码发送至%@,请查收",[[PortalHelper sharedInstance]get_userInfo].bankMobile];
    }
    return self;
}
- (void)selfresentsetTitle{
    [self.resent setTitle:@"60s" forState:UIControlStateNormal];
}
#pragma mark----倒计时
-(void)daojishiRunning{
    self.num--;
    if (self.num == 0) {
        [self removeTimer];
    }else{
        [self.resent setTitle:[NSString stringWithFormat:@"%lds",(long)self.num] forState:UIControlStateNormal];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 127.f;
    return YES;
    //    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
}
@end
