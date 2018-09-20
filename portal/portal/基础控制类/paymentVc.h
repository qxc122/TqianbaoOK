//
//  paymentVc.h
//  portal
//
//  Created by Store on 2017/10/24.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"
#import "Passwordpaymentbox.h"
#import "VerificationCodeBox.h"

@interface paymentVc : basicUiTableView
@property (nonatomic,strong) NSString *smsSendOKFlag; //验证码发送成功标志
@property (nonatomic,strong) NSString *smsCode;
@property (nonatomic,strong) NSString *smsCodetype;


@property (nonatomic,weak) Passwordpaymentbox *boxview;
@property (nonatomic,weak) VerificationCodeBox *Verificationbox;

- (void)payFailWith:(NSInteger)errorCode :(NSString *)msg;

- (void)PasswordRetrieval;

- (void)retryPay;
- (void)cannelPay;
- (void)OpenVerificationCodeBox;
- (void)OpenPasswordpaymentbox;
- (void)checkVerifyCodeWithtype;
- (void)Passwordinputsuccessful:(NSString *)inText;

- (void)sendSmsCodebindId:(NSInteger )bindId Money:(double)money codeId:(NSString *)codeId;
@end
