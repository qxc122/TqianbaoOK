//
//  Passwordpaymentbox.h
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"
#import "SYPasswordView.h"
@interface Passwordpaymentbox : windosView
@property (nonatomic,weak) SYPasswordView *input;
@property (nonatomic,weak) UIButton *RightBtn;
- (void)windosViewshowWithsubView:(UIView *)subView;
@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *inText);

@property (nonatomic, copy) void (^changePassWord)();


@property (nonatomic, copy) void (^cannelPay)();


- (void)firstINput;
- (void)ResignfirstINput;
@end
