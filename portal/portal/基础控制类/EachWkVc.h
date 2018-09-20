//
//  EachWkVc.h
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseWkVc.h"
#import "Passwordpaymentbox.h"
#import "VerificationCodeBox.h"

@interface EachWkVc : baseWkVc
@property (nonatomic,assign) BOOL isdisVIew;   //是否消失过

@property (nonatomic,strong) NSString *verifyCodetype;  //短信验证码类型   默认@“10”


@property (nonatomic,strong) NSString *merchName;
@property (nonatomic,strong) NSString *merchId;
@property (nonatomic,strong) NSString *Advance;   //主动还款还是提前结清

@property (nonatomic,assign) BOOL IsHaveRightBtn; //默认没有

- (void)Execute_the_JS_statementWith:(NSString *)str;
- (NSDictionary *)ProcessingJSdata:(NSDictionary *)body;
- (void)OpenPasswordpaymentbox;
- (void)OpenVerificationCodeBox;
- (void)sendSmsCodebindId:(NSInteger )bindId Money:(double)money codeId:(NSString *)codeId;
@property (nonatomic,weak) Passwordpaymentbox *boxview;
@property (nonatomic,weak) VerificationCodeBox *Verificationbox;
- (void)PasswordRetrieval;
@end


@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;


@end
