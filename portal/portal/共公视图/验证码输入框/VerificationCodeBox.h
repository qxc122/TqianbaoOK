//
//  VerificationCodeBox.h
//  portal
//
//  Created by Store on 2017/11/22.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"

@interface VerificationCodeBox : windosView
@property (nonatomic,weak) UITextField *codeInput;
- (void)windosViewshowWithsubView:(UIView *)subView;
@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *inText); //点击确定支付

@property (nonatomic, copy) void (^cannelPay)(); //取消了

@property (nonatomic, copy) void (^resendSmsCode)(); //重发验证码

@property (nonatomic, copy) void (^timeOut)(); //倒记时结束
-(void)creatTimer;
-(void)removeTimer;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIImageView *backkPng;
@property (nonatomic,weak) UIButton *backk;
@property (nonatomic,weak) UIView *Line;
@property (nonatomic,weak) UILabel *des;
@property (nonatomic,weak) UIView *backMain;

@property (nonatomic,weak) UIView *suLine;
@property (nonatomic,weak) UIButton *resent;
@property (nonatomic,weak) UIButton *okBtn;
@property (nonatomic,strong) NSTimer *scrollTimer;
@property (nonatomic,assign) NSInteger num;
@end
