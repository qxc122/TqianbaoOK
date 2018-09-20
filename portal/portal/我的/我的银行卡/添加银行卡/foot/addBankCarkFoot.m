//
//  addBankCarkFoot.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "addBankCarkFoot.h"



@interface addBankCarkFoot ()

@end


@implementation addBankCarkFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        self.btn = btn;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];

        YYLabel *label = [YYLabel new];
        [self addSubview:label];
        self.label = label;

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn.mas_bottom).offset(19);
            make.left.equalTo(self.btn).offset(0);
            make.right.equalTo(self.btn).offset(0);
        }];

        
        [btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"确定", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x5E7FFF backAlpha:1.0];
        [btn setBackgroundImage:[ColorWithHex(0xE9EBEE, 1.0) imageWithColor] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"我已阅读并同意 ", @"")];
        one.yy_font = PingFangSC_Regular(12);
        one.yy_color = COLOUR_TEXT_NORMALGRAY;
        //        one.yy_lineSpacing = 10;
        [text appendAttributedString:one];

         NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《T钱包快捷支付协议》", @"")];
         two.yy_font = PingFangSC_Regular(12);
         //        two.yy_lineSpacing = 10;
         two.yy_underlineStyle = NSUnderlineStyleSingle;
         kWeakSelf(self);
         [two yy_setTextHighlightRange:two.yy_rangeOfAll
         color:COLOUR_TEXT_NORMALGRAY
         backgroundColor:[UIColor clearColor]
         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
         if (weakself.openWkWebVc) {
             weakself.openWkWebVc([[PortalHelper sharedInstance]get_Globaldata].tpursePayAgreementUrl);
         }
         NSLog(@"%s",__func__);
         }];
         [text appendAttributedString:two];

        self.label.numberOfLines = 0;  //设置多行显示
        self.label.preferredMaxLayoutWidth = SCREENWIDTH - 60; //设置最大的宽度
        self.label.attributedText = text;
    }
    
    return self;
}
- (void)btnClick{
    NSLog(@"%s",__func__);
    if(self.doneBtn){
        self.doneBtn();
    }
}
@end
