//
//  SignInFoot.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SignInFoot.h"


@interface SignInFoot ()

@end

@implementation SignInFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(60);
            make.bottom.equalTo(self).offset(-42);
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
        }];
        
        UIButton *reSend = [UIButton new];
        self.reSend = reSend;
        [self addSubview:reSend];
        
        UILabel *error = [UILabel new];
        self.error = error;
        [self addSubview:error];
        
        [error mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self.btn);
        }];
        
        [reSend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self.btn);
            make.height.equalTo(@(12+20));
        }];
        
        [reSend setWithNormalColor:0xCBCED3 NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"换一个", @"") NormalImage:PIC_REFRESH NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [reSend addTarget:self action:@selector(reSendClick) forControlEvents:UIControlEventTouchUpInside];
        

        NSMutableAttributedString *text = [NSMutableAttributedString new];
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"我已阅读并同意", @"")];
        one.yy_font = PingFangSC_Regular(12);
        one.yy_color = COLOUR_TEXT_NORMALGRAY;
        [text appendAttributedString:one];
        
        
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《服务协议》", @"")];
        two.yy_font = PingFangSC_Regular(12);
        two.yy_underlineStyle = NSUnderlineStyleSingle;
        kWeakSelf(self);
        [two yy_setTextHighlightRange:two.yy_rangeOfAll
                                color:COLOUR_TEXT_NORMALGRAY
                      backgroundColor:[UIColor clearColor]
                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                if (weakself.openWkWebVc) {
                                    weakself.openWkWebVc(weakself.url);
                                }
                                NSLog(@"%s",__func__);
                            }];
        [text appendAttributedString:two];
        
        
        self.label.attributedText = text;
        
        [error setWithColor:0xF4333C Alpha:1.0 Font:12 ROrM:@"r"];
        error.text = NSLocalizedString(@"图形验证码错误，请重新输入", @"");
    }
    return self;
}

- (void)reSendClick{
    NSLog(@"%s",__func__);
    if(self.ReSendBtn){
        self.ReSendBtn();
    }
}

@end
