//
//  addBankCard_smscell.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "addBankCardsmscell.h"


@interface addBankCardsmscell ()
@property (nonatomic,strong) NSTimer *scrollTimer;
@property (nonatomic,assign) NSInteger num;


@property (nonatomic,weak) UIView *sms;

@property (nonatomic,weak) UIImageView *smsView;
@property (nonatomic,weak) UIButton *smsBtn;
@end

@implementation addBankCardsmscell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView *sms = [UIView new];
        self.sms = sms;
        [self.contentView addSubview:sms];
        
        UIImageView *smsView = [UIImageView new];
        self.smsView = smsView;
        [self.sms addSubview:smsView];
        
        UIButton *smsBtn = [UIButton new];
        self.smsBtn = smsBtn;
        [self.sms addSubview:smsBtn];
        
        [sms mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smsView);
            make.right.equalTo(self.smsView);
            make.bottom.equalTo(self.smsView);
            make.top.equalTo(self.smsView);
        }];
        [smsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smsBtn).offset(-4);
            make.right.equalTo(self.line);
            make.centerY.equalTo(self.title);
            make.height.equalTo(@24);
        }];
        [smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.line).offset(-4);
            make.centerY.equalTo(self.title);
            make.height.equalTo(@44);
        }];
        [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right);
            make.right.equalTo(self.sms.mas_left).offset(-10);
            make.bottom.equalTo(self.title);
            make.top.equalTo(self.title);
        }];
//        [smsView SetBordersWith:0.5 Color:COLOUR_TEXT_NORMALBLACK];
        [smsBtn setWithNormalColor:NORMOL_BLACK NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"获取验证码", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0];

        [smsBtn addTarget:self action:@selector(smsBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [smsBtn setTitleColor:ColorWithHex(0xABB2BA, 1.0) forState:UIControlStateDisabled];
        
        self.smsBtn.enabled = NO;
        [smsView SetBordersWith:0.5 Color:ColorWithHex(0xABB2BA, 1.0)];
    }
    return self;
}
- (void)smsBtnClick{
    if (self.doneClick) {
        self.doneClick(baseCell_Click_type_one_Sendsms);
    }
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark----创建定时器
-(void)creatTimer
{
    self.num = 60;
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiRunning) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    self.smsBtn.enabled = NO;
    self.smsView.hidden = YES;
    [self.smsBtn setTitle:@"60s" forState:UIControlStateNormal];
}
#pragma mark----倒计时
-(void)daojishiRunning{
    self.num--;
    if (self.num == 0) {
        [self removeTimer];
    }else{
        [self.smsBtn setTitle:[NSString stringWithFormat:@"%lds",(long)self.num] forState:UIControlStateNormal];
    }
}
#pragma mark----移除定时器
-(void)removeTimer
{
    self.smsBtn.enabled = YES;
    self.smsView.hidden = NO;
    self.smsOK = nil;
    [self.smsView SetBordersWith:0.5 Color:COLOUR_TEXT_NORMALBLACK];
    [self.smsBtn setTitle:NSLocalizedString(@"获取验证码", @"") forState:UIControlStateNormal];
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}
- (void)dealloc{
    [self removeTimer];
}

- (void)setSmsOK:(NSString *)smsOK{
    _smsOK = smsOK;
    if ([smsOK isEqualToString:@"YES"]) {  //短信发送成功
        self.smsOK = nil;
        [self creatTimer];
        [self performSelector:@selector(delayOpenInView) withObject:nil afterDelay:1.0f];
    }else  if ([smsOK isEqualToString:@"eeee"]) {  //手机号码正确
        self.smsBtn.enabled = YES;
        self.smsView.hidden = NO;
        self.smsOK = nil;
    }
}

- (void)delayOpenInView{
    if ([self.input canBecomeFirstResponder]) {
        [self.input becomeFirstResponder];
    }
}
@end
