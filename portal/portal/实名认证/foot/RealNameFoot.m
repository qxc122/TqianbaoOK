//
//  RealNameFoot.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RealNameFoot.h"


@interface RealNameFoot ()

@end

@implementation RealNameFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        YYLabel *label = [YYLabel new];
//        [self addSubview:label];
//        self.label = label;
//
//        [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@50);
//            make.centerY.equalTo(self);
//            make.left.equalTo(self).offset(30);
//            make.right.equalTo(self).offset(-30);
//        }];
//
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.btn.mas_bottom).offset(19);
//            make.left.equalTo(self.btn).offset(0);
//            make.right.equalTo(self.btn).offset(0);
//        }];

        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"我已阅读并同意 ", @"")];
        one.yy_font = PingFangSC_Regular(12);
        one.yy_color = COLOUR_TEXT_NORMALGRAY;
//        one.yy_lineSpacing = 10;
        [text appendAttributedString:one];
        
        
        {
            NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《相关协议》", @"")];
            two.yy_font = PingFangSC_Regular(12);
            //        two.yy_lineSpacing = 10;
            two.yy_underlineStyle = NSUnderlineStyleSingle;
            kWeakSelf(self);
            [two yy_setTextHighlightRange:two.yy_rangeOfAll
                                    color:ColorWithHex(0x5E81FF, 1.0)
                          backgroundColor:[UIColor clearColor]
                                tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                    if (weakself.openWkWebVc) {
                                        weakself.openWkWebVc(weakself.url);
                                    }
                                    NSLog(@"%s",__func__);
                                }];
            [text appendAttributedString:two];
        }
        
        
        /*
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
                                    weakself.openWkWebVc(weakself.url);
                                }
                                NSLog(@"%s",__func__);
        }];
        [text appendAttributedString:two];
        
        
        NSMutableAttributedString *Three = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《平安大华快取协议》", @"")];
        Three.yy_font = PingFangSC_Regular(12);
//        Three.yy_lineSpacing = 10;
        Three.yy_underlineStyle = NSUnderlineStyleSingle;
        [Three yy_setTextHighlightRange:Three.yy_rangeOfAll
                                color:COLOUR_TEXT_NORMALGRAY
                      backgroundColor:[UIColor clearColor]
                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                if (weakself.openWkWebVc) {
                                    weakself.openWkWebVc([[PortalHelper sharedInstance]get_Globaldata].tpurseServiceRechargeAgreementUrl);
                                }
                                NSLog(@"%s",__func__);
                            }];
        [text appendAttributedString:Three];
        
        {
            NSMutableAttributedString *Three = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《平安大华客户协议》", @"")];
            Three.yy_font = PingFangSC_Regular(12);
//            Three.yy_lineSpacing = 10;
            Three.yy_underlineStyle = NSUnderlineStyleSingle;
            [Three yy_setTextHighlightRange:Three.yy_rangeOfAll
                                      color:COLOUR_TEXT_NORMALGRAY
                            backgroundColor:[UIColor clearColor]
                                  tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                      if (weakself.openWkWebVc) {
                                    weakself.openWkWebVc([[PortalHelper sharedInstance]get_Globaldata].tpurseServiceCustomerAgreementUrl);
                                      }
                                      NSLog(@"%s",__func__);
                                  }];
            [text appendAttributedString:Three];
        }
        
        {
            NSMutableAttributedString *Three = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《平安付科技电子支付账户协议》", @"")];
            Three.yy_font = PingFangSC_Regular(12);
            //            Three.yy_lineSpacing = 10;
            Three.yy_underlineStyle = NSUnderlineStyleSingle;
            [Three yy_setTextHighlightRange:Three.yy_rangeOfAll
                                      color:COLOUR_TEXT_NORMALGRAY
                            backgroundColor:[UIColor clearColor]
                                  tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                      if (weakself.openWkWebVc) {
                                          weakself.openWkWebVc([[PortalHelper sharedInstance]get_Globaldata].fundAcctPayAgreementUrl);
                                      }
                                      NSLog(@"%s",__func__);
                                  }];
            [text appendAttributedString:Three];
        }
        */

//        text.yy_lineSpacing = 10;
        self.label.numberOfLines = 0;  //设置多行显示
        self.label.preferredMaxLayoutWidth = SCREENWIDTH - 60; //设置最大的宽度
        self.label.attributedText = text;
    }
    return self;
}
@end
