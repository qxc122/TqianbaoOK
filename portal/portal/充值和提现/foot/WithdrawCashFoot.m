//
//  WithdrawCashFoot.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "WithdrawCashFoot.h"

@implementation WithdrawCashFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
        
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn.mas_bottom).offset(16);
            make.left.equalTo(self.btn).offset(0);
            make.right.equalTo(self.btn).offset(0);
        }];
        
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"点击确认即代表您已阅读并同意", @"")];
        one.yy_font = PingFangSC_Regular(12);
        one.yy_color = COLOUR_TEXT_NORMALGRAY;
        [text appendAttributedString:one];
        
        
        NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《T钱包快捷支付协议》", @"")];
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
        self.label.hidden = YES;
    }
    return self;
}

@end
