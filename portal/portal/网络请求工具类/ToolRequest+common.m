//
//  ToolRequest+common.m
//  TourismT
//
//  Created by Store on 16/11/21.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolRequest+common.h"
#import "MACRO_URL.h"
#import "MACRO_PORTAL.h"
#import "ToolModeldata.h"
#import "PortalHelper.h"
#import "DateTools.h"
#import "Cryptor.h"
#import "OpenUDID.h"
@implementation ToolRequest (common)



- (void)appgetGlobalParamssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_appgetGlobalParams parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_userqueryWithfilterFlag:(NSString *)filterFlag
                        Bankssuccess:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (filterFlag) {
        [params setObject:filterFlag forKey:@"filterFlag"];
    }else{
        [params setObject:@"0" forKey:@"filterFlag"];
    }
    [self postJsonWithPath:URLBASIC_userqueryBank parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_userresetPayPasswordWithpayPassword:(NSString *)payPassword
                            Bankssuccess:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_userresetPayPassword parameters:params success:successBlock failure:failureBlock];
}






- (void)URLBASIC_userbindBankCardWithrealName:(NSString *)realName
                                     certNo:(NSString *)certNo
                                     cardNo:(NSString *)cardNo
                                     bankCode:(NSString *)bankCode
                                     bankMobile:(NSString *)bankMobile
                                     verifyCode:(NSString *)verifyCode
                                     operType:(NSString *)operType
                                   finaFlag:(NSString *)finaFlag
                                     useBindId:(NSNumber *)useBindId
                                      success:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (realName) {
        [params setObject:realName forKey:@"realName"];
    }
    if (certNo) {
        [params setObject:certNo forKey:@"certNo"];
    }
    if (cardNo) {
        [params setObject:cardNo forKey:@"cardNo"];
    }
    if (bankCode) {
        [params setObject:bankCode forKey:@"bankCode"];
    }
    if (bankMobile) {
        [params setObject:bankMobile forKey:@"bankMobile"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    if (operType) {
        [params setObject:operType forKey:@"operType"];
    }
    if (finaFlag) {
        [params setObject:finaFlag forKey:@"finaFlag"];
    }
    if (useBindId) {
        [params setObject:useBindId forKey:@"useBindId"];
    }
    [self postJsonWithPath:URLBASIC_userbindBankCard parameters:params success:successBlock failure:failureBlock];
}

///  7-17
- (void)systemsendVerifyCodeForBindCardWithmobile:(NSString *)mobile
                                             type:(NSString *)type
                                        useBindId:(NSNumber *)useBindId
                                         realName:(NSString *)realName
                                           certNo:(NSString *)certNo
                                           cardNo:(NSString *)cardNo
                                         bankCode:(NSString *)bankCode
                                          success:(RequestSuccess)successBlock
                                          failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    if (useBindId) {
        [params setObject:useBindId forKey:@"useBindId"];
    }
    if (realName) {
        [params setObject:realName forKey:@"realName"];
    }
    if (certNo) {
        [params setObject:certNo forKey:@"certNo"];
    }
    if (cardNo) {
        [params setObject:cardNo forKey:@"cardNo"];
    }
    if (bankCode) {
        [params setObject:bankCode forKey:@"bankCode"];
    }
    [self postJsonWithPath:URLBASIC_systemsendVerifyCode parameters:params success:successBlock failure:failureBlock];
}
///

- (void)systemsendVerifyCodeWithmobile:(NSString *)mobile
                                  type:(NSString *)type
                               success:(RequestSuccess)successBlock
                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    [self postJsonWithPath:URLBASIC_systemsendVerifyCode parameters:params success:successBlock failure:failureBlock];
}



- (void)moneySystemsendVerifyCodeWithmobile:(NSString *)mobile
                                  type:(NSString *)type
                                     bindId:(NSInteger )bindId
                                      money:(double )money
                                     codeId:(NSString *)codeId
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    if (bindId>0) {
        [params setObject:[NSDecimalNumber numberWithInteger:bindId] forKey:@"bindId"];
    }
    if (money>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",money];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"money"];
        
//        [params setObject:[NSDecimalNumber numberWithDouble:money] forKey:@"money"];
    }
    if (codeId) {
        [params setObject:codeId forKey:@"codeId"];
    }
    [self postJsonWithPath:URLBASIC_systemsendVerifyCode parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_usercheckVerifyCodeWithverifyCode:(NSString *)verifyCode
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    [self postJsonWithPath:URLBASIC_usercheckVerifyCode parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_tpTreasuresendVerifyCodeWithverifyCode:(NSString *)verifyCode
                                                success:(RequestSuccess)successBlock
                                                failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    [self postJsonWithPath:URLBASIC_tpTreasuresendVerifyCode parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_qrCodecheckPayPasswordWithpayPassword:(NSString *)payPassword
                                               orderId:(NSString *)orderId
                                               success:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    if (orderId) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [self postJsonWithPath:URLBASIC_qrCodecheckPayPassword parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_usercheckPayPasswordWithpayPassword:(NSString *)payPassword
                                           success:(RequestSuccess)successBlock
                                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_usercheckPayPassword parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_regularFintpurseRechargeWithpayPassword:(NSString *)payPassword
                                             orderId:(NSString *)orderId
                                           orderDesc:(NSString *)orderDesc
                                          orderPrice:(double)orderPrice
                                             success:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    if (orderId) {
        [params setObject:orderId forKey:@"orderId"];
    }
    if (orderDesc && orderDesc.length) {
        [params setObject:orderDesc forKey:@"orderDesc"];
    }else{
        [params setObject:@"NULL" forKey:@"orderDesc"];
    }
    if (orderPrice>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",orderPrice];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"orderPrice"];
    }
    [self postJsonWithPath:URLBASIC_regularFintpurseRecharge parameters:params success:successBlock failure:failureBlock];
}



- (void)URLBASIC_flightqueryGssFlightDynamicWithdepDate:(NSString *)depDate
                                               flightNo:(NSString *)flightNo
                                               depTime:(NSString *)depTime
                                               arrTime:(NSString *)arrTime
                                                success:(RequestSuccess)successBlock
                                                failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (depDate) {
        [params setObject:depDate forKey:@"depDate"];
    }
    if (flightNo) {
        [params setObject:flightNo forKey:@"flightNo"];
    }
    if (depTime) {
        [params setObject:depTime forKey:@"depTime"];
    }
    if (arrTime) {
        [params setObject:arrTime forKey:@"arrTime"];
    }
    [self postJsonWithPath:URLBASIC_flightqueryGssFlightDynamic parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_userwithdrawWithmoney:(double )money
                                bindId:(double )bindId
                           payPassword:(NSString *)payPassword
                            verifyCode:(NSString  *)verifyCode
                    success:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (money>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",money];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"money"];
    }
    if (bindId>0) {
        [params setObject:[NSNumber numberWithLong:bindId] forKey:@"bindId"];
    }
    if (payPassword) {
        [params setObject:payPassword forKey:@"payPassword"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    
    [self postJsonWithPath:URLBASIC_userwithdraw parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_orderpayThirdOrderWithorderId:(NSString *)orderId
                               payMethod:(NSString *)payMethod
                                  bindId:(NSNumber *)bindId
                              orderPrice:(NSNumber *)orderPrice
                               tcoinFlag:(NSString *)tcoinFlag
                           payPassword:(NSString *)payPassword
                                    verifyCode:(NSString  *)verifyCode
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (orderId) {
        [params setObject:orderId forKey:@"orderId"];
    }
    if (payMethod) {
        [params setObject:payMethod forKey:@"payMethod"];
    }
    if (bindId) {
        [params setObject:bindId forKey:@"bindId"];
    }
    if (orderPrice) {
        [params setObject:orderPrice forKey:@"orderPrice"];
    }
    if (tcoinFlag) {
        [params setObject:tcoinFlag forKey:@"tcoinFlag"];
    }
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        [params setObject:passDes forKey:@"payPassword"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    [self postJsonWithPath:URLBASIC_orderpayThirdOrder parameters:params success:successBlock failure:failureBlock];
}




- (void)URLBASIC_qrCodegenerateQRCodeWithdevicesToken:(NSString *)devicesToken
                                  success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (devicesToken) {
        [params setObject:devicesToken forKey:@"devicesToken"];
    }
    [self postJsonWithPath:URLBASIC_qrCodegenerateQRCode parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_tpursesystemcheckVerifyCodeWithtype:(NSString *)type
                                          verifyCode:(NSString *)verifyCode
                                    success:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    [self postJsonWithPath:URLBASIC_tpursesystemcheckVerifyCode parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_qrCodescanQRCodeWithcodeId:(NSString *)codeId
                                              success:(RequestSuccess)successBlock
                                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (codeId) {
        [params setObject:codeId forKey:@"codeId"];
    }
    [self postJsonWithPath:URLBASIC_qrCodescanQRCode parameters:params success:successBlock failure:failureBlock];
}
//deviceId:(NSString *)deviceId
- (void)URLBASIC_qrCodescanQRCodeWithpayPassword:(NSString *)payPassword
                                    success:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock{
    ///
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *deviceId = [OpenUDID value];
    if (deviceId) {
        [params setObject:deviceId forKey:@"deviceId"];
    }
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_qrCodeopenPayQRCode parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_qrCodecheckPayQRCodeStatussuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *deviceId = [OpenUDID value];
    if (deviceId) {
        [params setObject:deviceId forKey:@"deviceId"];
    }
    [self postJsonWithPath:URLBASIC_qrCodecheckPayQRCodeStatus parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_qrCodecancelUnifiedPayWithcodeId:(NSString *)codeId
                                       verifyCode:(NSString  *)verifyCode
                                    success:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (codeId) {
        [params setObject:codeId forKey:@"codeId"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }

    [self postJsonWithPath:URLBASIC_qrCodecancelUnifiedPay parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_qrCodegeneratePayQRCodeWithpayMethod:(NSString *)payMethod
                                       devicesToken:(NSString  *)devicesToken
                                          success:(RequestSuccess)successBlock
                                          failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (payMethod) {
        [params setObject:payMethod forKey:@"payMethod"];
    }else{
        [params setObject:@"BAL" forKey:@"payMethod"];
    }
#ifdef DEBUG
    // 如果是模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        if (!devicesToken.length) {
            [params setObject:@"TARGET_IPHONE_SIMULATOR0000001" forKey:@"devicesToken"];
        }
    }
#endif
    if (devicesToken) {
        [params setObject:devicesToken forKey:@"devicesToken"];
    }
    
    NSString *deviceId = [OpenUDID value];
    if (deviceId) {
        [params setObject:deviceId forKey:@"deviceId"];
    }
    [self postJsonWithPath:URLBASIC_qrCodegeneratePayQRCode parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_qrCodeunifiedPayWithcodeId:(NSString *)codeId
                                      money:(NSNumber *)money
                                     bindId:(NSNumber *)bindId
                                  payMethod:(NSString *)payMethod
                                payPassword:(NSString *)payPassword
                                 verifyCode:(NSString  *)verifyCode
                                    success:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (codeId) {
        [params setObject:codeId forKey:@"codeId"];
    }
    if (money) {
        [params setObject:money forKey:@"money"];
    }
    if (bindId) {
        [params setObject:bindId forKey:@"bindId"];
    }
    if (payMethod) {
        [params setObject:payMethod forKey:@"payMethod"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_qrCodeunifiedPay parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_userrechargeWithmoney:(double )money
                                bindId:(double )bindId
                           payPassword:(NSString *)payPassword
                            verifyCode:(NSString  *)verifyCode
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (money>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",money];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"money"];
    }
    if (bindId>0) {
        [params setObject:[NSNumber numberWithInt:bindId] forKey:@"bindId"];
    }
    if (payPassword) {
        [params setObject:payPassword forKey:@"payPassword"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
#ifdef DEBUG
//    NSLog(@"strTmp=%@",[params DicToJsonstr]);
//    NSString *ttt = [NSString stringWithFormat:@"%f",money];
//    NSLog(@"sdf");
#endif
    
    [self postJsonWithPath:URLBASIC_userrecharge parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_regularFinrechargeWithmoney:(double )money
                                bindId:(double )bindId
                                rechargeType:(NSString *)rechargeType
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (money>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",money];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"money"];
    }
    if (bindId>0) {
        [params setObject:[NSNumber numberWithInt:bindId] forKey:@"bindId"];
    }
    if (rechargeType) {
        [params setObject:rechargeType forKey:@"rechargeType"];
    }
    [self postJsonWithPath:URLBASIC_regularFinrecharge parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_regularFinwithdrawWithmoney:(double )money
                                      bindId:(double )bindId
                                     success:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (money>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",money];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"money"];
    }
    if (bindId>0) {
        [params setObject:[NSNumber numberWithInt:bindId] forKey:@"bindId"];
    }
    [self postJsonWithPath:URLBASIC_regularFinwithdraw parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_regularFinmyRegularFinsuccess:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_regularFinmyRegularFin parameters:params success:successBlock failure:failureBlock];
}



- (void)userloginWithmobile:(NSString *)mobile
                                  verifyCode:(NSString *)verifyCode
          graphicVerifyCode:(NSString *)graphicVerifyCode
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"]; 
    }
    if (graphicVerifyCode) {
        [params setObject:graphicVerifyCode forKey:@"graphicVerifyCode"];
    }
    [self postJsonWithPath:URLBASIC_userlogin parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_useraddPayPasswordWithpayPassword:(NSString *)payPassword
                    success:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (payPassword) {
        [params setObject:payPassword forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_useraddPayPassword parameters:params success:successBlock failure:failureBlock];
}
- (void)tpursesystemgetGraphicVerifyCodesuccess:(RequestSuccess)successBlock
                                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpursesystemgetGraphicVerifyCode parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_tpurseusermyInfosuccess:(RequestSuccess)successBlock
                                        failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpurseusermyInfo parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_userfinishExpMoneyIncomesuccess:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_userfinishExpMoneyIncome parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_loanloanRepayWithamt:(NSNumber *)amt
                               bindId:(NSNumber *)bindId
                          payPassword:(NSString *)payPassword
                            payMethod:(NSString *)payMethod
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (amt>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",[amt doubleValue]];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"amt"];
    }
    if (bindId>0) {
        [params setObject:[NSDecimalNumber numberWithDouble:[bindId doubleValue]] forKey:@"bindId"];
    }
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    if (payMethod) {
        [params setObject:payMethod forKey:@"payMethod"];
    }
    [self postJsonWithPath:URLBASIC_loanloanRepay parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_loanloanRepayWithamt:(NSNumber *)amt
                               bindId:(NSNumber *)bindId
                               acctId:(NSNumber *)acctId
                          payPassword:(NSString *)payPassword
                            payMethod:(NSString *)payMethod
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (amt>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",[amt doubleValue]];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"amt"];
    }
    if (bindId>0) {
        [params setObject:[NSDecimalNumber numberWithDouble:[bindId doubleValue]] forKey:@"bindId"];
    }
    if (acctId>0) {
        [params setObject:[NSDecimalNumber numberWithDouble:[acctId doubleValue]] forKey:@"acctId"];
    }
    
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    if (payMethod) {
        [params setObject:payMethod forKey:@"payMethod"];
    }
    [self postJsonWithPath:URLBASIC_loanloanSettle parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_tpurseusermyCardInfosuccess:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpurseusermyCardInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_orderqueryOrderInfoWithSysId:(NSString *)sysId
                                         Sign:(NSString *)sign
                                    Timestamp:(NSString *)timestamp
                                            V:(NSString *)v
                                      OrderId:(NSString *)orderId
                                      success:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (sysId) {
        [params setObject:sysId forKey:@"sysId"];
    }
    if (sign) {
        [params setObject:sign forKey:@"sign"];
    }
    if (timestamp) {
        [params setObject:timestamp forKey:@"timestamp"];
    }
    if (v) {
        [params setObject:v forKey:@"v"];
    }
    if (orderId) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [self postJsonWithPath:URLBASIC_orderqueryOrderInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_tpursetpursesystemapplyAuthCodesuccess:(RequestSuccess)successBlock
                                                failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpursetpursesystemapplyAuthCode parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_tpurseuserqueryMyBanksuccess:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpurseuserqueryMyBank parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_tpurseuserqueryMyFlightsuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpurseuserqueryMyFlight parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_tpurseuserqueryPayMethodsuccess:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpurseuserqueryPayMethod parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_tpTreasurequeryPayMethodWith:(NSString *)type
                                      success:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    [self postJsonWithPath:URLBASIC_tpTreasurequeryPayMethod parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_tpTreasurenoticeWith:(NSString *)type
                                      success:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    [self postJsonWithPath:URLBASIC_tpTreasurenotice parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_tpTreasurewithdrawWithmoney:(NSNumber *)money
                                      bindId:(NSNumber *)bindId
                                 payPassword:(NSString *)payPassword
                                      success:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (money>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",[money doubleValue]];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"money"];
    }
    if (bindId>0) {
        [params setObject:[NSDecimalNumber numberWithDouble:[bindId doubleValue]] forKey:@"bindId"];
    }
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_tpTreasurerecharge parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_loanloanApplyWithloanAmt:(NSNumber *)loanAmt
                                      loanPeriod:(NSInteger)loanPeriod
                                 payPassword:(NSString *)payPassword
                                     success:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (loanAmt>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",[loanAmt doubleValue]];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"loanAmt"];
    }
    if (loanPeriod>0) {
        [params setObject:[NSDecimalNumber numberWithInt:loanPeriod] forKey:@"loanPeriod"];
    }
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_loanloanApply parameters:params success:successBlock failure:failureBlock];
}


- (void)URLBASIC_loanloanApplyWithparams:(NSMutableDictionary *)params
                              payPassword:(NSString *)payPassword
                                  success:(RequestSuccess)successBlock
                                  failure:(RequestFailure)failureBlock{
    if (!params) {
        params = [[NSMutableDictionary alloc] init];
    }
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_loanloanApply parameters:params success:successBlock failure:failureBlock];
}




- (void)URLBASIC_tpTreasurerechargeWithmoney:(NSNumber *)money
                                      bindId:(NSNumber *)bindId
                                        type:(NSString *)type
                                 payPassword:(NSString *)payPassword
                                     success:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (money>0) {
        NSString *tmp = [NSString stringWithFormat:@"%.2f",[money doubleValue]];
        [params setObject:[NSDecimalNumber decimalNumberWithString:tmp] forKey:@"money"];
        
//        [params setObject:[NSDecimalNumber numberWithDouble:[money doubleValue]] forKey:@"money"];
    }
    if (bindId>0) {
        [params setObject:[NSDecimalNumber numberWithDouble:[bindId doubleValue]] forKey:@"bindId"];
    }
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    if (payPassword) {
        NSString *key = [[[PortalHelper sharedInstance] get_accessToken].sessionKey substringWithRange:NSMakeRange(8, 8)];
        NSString *iv = [[[PortalHelper sharedInstance] get_accessToken].sessionSecret substringWithRange:NSMakeRange(16, 8)];
        NSString *passDes = [Cryptor encryptUseDES:payPassword key:key iv:iv];
        
        [params setObject:passDes forKey:@"payPassword"];
    }
    [self postJsonWithPath:URLBASIC_tpTreasurewithdraw parameters:params success:successBlock failure:failureBlock];
}


- (void)usermyInfosuccess:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_usermyInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_userreceiveExpMoneysuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_userreceiveExpMoney parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_appqueryHomesuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_appqueryHome parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_appappUpdatesuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *verCode = APP_BUILD;
    if (verCode) {
//        if (verCode.length >3) {
//            verCode = [verCode substringToIndex:3];
//        }
        [params setObject:[NSNumber numberWithDouble:[verCode doubleValue]] forKey:@"verCode"];
    }
    [self postJsonWithPath:URLBASIC_appappUpdate parameters:params success:successBlock failure:failureBlock];
}

- (void)portalusermyNewWithPageNum:(NSInteger)pageNum
                   ssuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalusermyNews parameters:params success:successBlock failure:failureBlock];
}

/*************************************************************************************************/
//联系人  增 删 该 查
//name	姓名
//mobile	手机号
//email	邮箱
//selfFlag	是否本人  @"0" 否   @"1"-是
- (void)portalcommonInfoaddContactInfoWithname:(NSString *)name
                           mobile:(NSString *)mobile
                           email:(NSString *)email
                           selfFlag:(NSString *)selfFlag
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (name) {
        [params setObject:name forKey:@"name"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (email) {
        [params setObject:email forKey:@"email"];
    }
    if (selfFlag  && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoaddContactInfo parameters:params success:successBlock failure:failureBlock];
}
//contactId	联系人编号
- (void)portalcommonInfodeleteContactInfoWithcontactId:(NSInteger)contactId
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (contactId>0) {
        [params setObject:@(contactId) forKey:@"contactId"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfodeleteContactInfo parameters:params success:successBlock failure:failureBlock];
}
//contactId	联系人编号
//name	姓名
//mobile	手机号
//email	邮箱
//selfFlag	是否本人
- (void)portalcommonInfoeditContactInfoWithcontactId:(NSInteger )contactId
                                                name:(NSString *)name
                                        mobile:(NSString *)mobile
                                         email:(NSString *)email
                                      selfFlag:(NSString *)selfFlag
                                      ssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (contactId>0) {
        [params setObject:@(contactId) forKey:@"contactId"];
    }
    if (name) {
        [params setObject:name forKey:@"name"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (email) {
        [params setObject:email forKey:@"email"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoeditContactInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)portalcommonInfoqueryContactInfosWithPageNum:(NSInteger)pageNum
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoqueryContactInfos parameters:params success:successBlock failure:failureBlock];
}
//END联系人  增 删 该 查
/*************************************************************************************************/

/*************************************************************************************************/
//地址  增 删 该 查
//receiverName	收件人姓名
//receiverMobile	收件号码
//province	省
//city	市
//area	区
//detailAddress	详细地址
//selfFlag	本人标志   @"0" 否   @"1"-是
- (void)portalcommonInfoaddAddressInfoWithreceiverName:(NSString *)receiverName
                                        receiverMobile:(NSString *)receiverMobile
                                         province:(NSString *)province
                                                  city:(NSString *)city
                                                  area:(NSString *)area
                                         detailAddress:(NSString *)detailAddress
                                              postCode:(NSString *)postCode
                                      selfFlag:(NSString *)selfFlag
                                      ssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (receiverName) {
        [params setObject:receiverName forKey:@"receiverName"];
    }
    if (receiverMobile) {
        [params setObject:receiverMobile forKey:@"receiverMobile"];
    }
    if (province) {
        [params setObject:province forKey:@"province"];
    }
    if (city) {
        [params setObject:city forKey:@"city"];
    }
    if (area) {
        [params setObject:area forKey:@"area"];
    }
    if (detailAddress) {
        [params setObject:detailAddress forKey:@"detailAddress"];
    }
    if (postCode) {
        [params setObject:postCode forKey:@"postCode"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoaddAddressInfo parameters:params success:successBlock failure:failureBlock];
}
//addressId	地址编号
- (void)portalcommonInfodeleteAddressInfoWithaddressId:(NSInteger)addressId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (addressId>0) {
        [params setObject:@(addressId) forKey:@"addressId"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfodeleteAddressInfo parameters:params success:successBlock failure:failureBlock];
}
//addressId	地址编号
//receiverName	收件人姓名
//receiverMobile	收件号码
//province	省
//city	市
//area	区
//detailAddress	详细地址
//selfFlag	本人标志
- (void)portalcommonInfoeditAddressInfoWithaddressId:(NSInteger )addressId
                                        receiverName:(NSString *)receiverName
                                      receiverMobile:(NSString *)receiverMobile
                                            province:(NSString *)province
                                                city:(NSString *)city
                                                area:(NSString *)area
                                       detailAddress:(NSString *)detailAddress
                                            postCode:(NSString *)postCode
                                            selfFlag:(NSString *)selfFlag
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (addressId>0) {
        [params setObject:@(addressId) forKey:@"addressId"];
    }
    if (receiverName) {
        [params setObject:receiverName forKey:@"receiverName"];
    }
    if (receiverMobile) {
        [params setObject:receiverMobile forKey:@"receiverMobile"];
    }
    if (province) {
        [params setObject:province forKey:@"province"];
    }
    if (city) {
        [params setObject:city forKey:@"city"];
    }
    if (area) {
        [params setObject:area forKey:@"area"];
    }
    if (detailAddress) {
        [params setObject:detailAddress forKey:@"detailAddress"];
    }
    if (postCode) {
        [params setObject:postCode forKey:@"postCode"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoeditAddressInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)portalcommonInfoqueryAddressInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoqueryAddressInfos parameters:params success:successBlock failure:failureBlock];
}
//END地址  增 删 该 查
/*************************************************************************************************/

/*************************************************************************************************/
//旅游  增 删 该 查
//name	姓名
//surname	英文姓  Must
//enName	英文名  Must
//mobile	电话
//sex	性别
//birthday	出生日期
//selfFlag	本人标志
//nationality	国籍
//certType	证件类型
//certNo	证件号码
//expireDate	证件有效期
- (void)commonInfoaddPassengerInfoWithname:(NSString *)name
                                   surname:(NSString *)surname
                                    enName:(NSString *)enName
                                    mobile:(NSString *)mobile
                                       sex:(NSString *)sex
                                  birthday:(NSString *)birthday
                                  selfFlag:(NSString *)selfFlag
                               nationality:(NSString *)nationality
                                  certType:(NSString *)certType
                                    certNo:(NSString *)certNo
                                expireDate:(NSString *)expireDate
                                  ssuccess:(RequestSuccess)successBlock
                                   failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (name) {
        [params setObject:name forKey:@"name"];
    }
    if (surname) {
        [params setObject:surname forKey:@"surname"];
    }
    if (enName) {
        [params setObject:enName forKey:@"enName"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (sex) {
        [params setObject:sex forKey:@"sex"];
    }
    if (birthday) {
        [params setObject:birthday forKey:@"birthday"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    if (nationality) {
        [params setObject:nationality forKey:@"nationality"];
    }
    if (certType) {
        [params setObject:certType forKey:@"certType"];
    }
    if (certNo) {
        [params setObject:certNo forKey:@"certNo"];
    }
    if (expireDate) {
        [params setObject:expireDate forKey:@"expireDate"];
    }
    [self postJsonWithPath:URLBASIC_commonInfoaddPassengerInfo parameters:params success:successBlock failure:failureBlock];
}
//passengerId	编号
- (void)commonInfodeletePassengerInfoWithpassengerId:(NSInteger)passengerId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (passengerId>0) {
        [params setObject:@(passengerId) forKey:@"passengerId"];
    }
    [self postJsonWithPath:URLBASIC_commonInfodeletePassengerInfo parameters:params success:successBlock failure:failureBlock];
}
//passengerId	编号
//name	姓名
//surname	英文姓  Must
//enName	英文名  Must
//mobile	电话
//sex	性别
//birthday	出生日期
//selfFlag	本人标志
//nationality	国籍
//certType	证件类型
//certNo	证件号码
//expireDate	证件有效期
- (void)commonInfoeditPassengerInfoWithpassengerId:(NSInteger)passengerId
                                              name:(NSString *)name
                                           surname:(NSString *)surname
                                            enName:(NSString *)enName
                                            mobile:(NSString *)mobile
                                               sex:(NSString *)sex
                                          birthday:(NSString *)birthday
                                          selfFlag:(NSString *)selfFlag
                                       nationality:(NSString *)nationality
                                          certType:(NSString *)certType
                                            certNo:(NSString *)certNo
                                        expireDate:(NSString *)expireDate
                                          ssuccess:(RequestSuccess)successBlock
                                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (passengerId>0) {
        [params setObject:@(passengerId) forKey:@"passengerId"];
    }
    if (name && name.length) {
        [params setObject:name forKey:@"name"];
    }
    if (surname && surname.length) {
        [params setObject:surname forKey:@"surname"];
    }
    if (enName && enName.length) {
        [params setObject:enName forKey:@"enName"];
    }
    if (mobile && mobile.length) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (sex && sex.length) {
        [params setObject:sex forKey:@"sex"];
    }
    if (birthday && birthday.length) {
        [params setObject:birthday forKey:@"birthday"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    if (nationality && nationality.length) {
        [params setObject:nationality forKey:@"nationality"];
    }
    if (certType && certType.length) {
        [params setObject:certType forKey:@"certType"];
    }
    if (certNo && certNo.length) {
        [params setObject:certNo forKey:@"certNo"];
    }
    if (expireDate && expireDate.length) {
        [params setObject:expireDate forKey:@"expireDate"];
    }
    [self postJsonWithPath:URLBASIC_commonInfoeditPassengerInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)portalcommonInfoqueryPassengerInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoqueryPassengerInfos parameters:params success:successBlock failure:failureBlock];
}
//END旅游  增 删 该 查
/*************************************************************************************************/

//chlType	登陆渠道类型
//nickname	昵称
//province	省份
//city	城市
//gender	性别
//avatar	头像
//country	国家
//openId
//unionid
- (void)userthirdUserLoginWithchlType:(NSString *)chlType
                             nickname:(NSString *)nickname
                             province:(NSString *)province
                                 city:(NSString *)city
                               gender:(NSString *)gender
                               avatar:(NSString *)avatar
                              country:(NSString *)country
                               openId:(NSString *)openId
                              unionid:(NSString *)unionid
                             ssuccess:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (chlType) {
        [params setObject:chlType forKey:@"chlType"];
    }
    if (nickname) {
        [params setObject:nickname forKey:@"nickname"];
    }
    if (province) {
        [params setObject:province forKey:@"province"];
    }
    if (city) {
        [params setObject:city forKey:@"city"];
    }
    if (gender) {
        [params setObject:gender forKey:@"gender"];
    }
    if (avatar) {
        [params setObject:avatar forKey:@"avatar"];
    }
    if (country) {
        [params setObject:country forKey:@"country"];
    }
    if (openId) {
        [params setObject:openId forKey:@"openId"];
    }
    if (unionid) {
        [params setObject:unionid forKey:@"unionid"];
    }
    [self postJsonWithPath:URLBASIC_userthirdUserLogin parameters:params success:successBlock failure:failureBlock];
}
//unionId	unionId
//mobile	手机号
//verifyCode	验证码
- (void)userthirdUserBindWithunionId:(NSString *)unionId
                             mobile:(NSString *)mobile
                             verifyCode:(NSString *)verifyCode
                             ssuccess:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (unionId) {
        [params setObject:unionId forKey:@"unionId"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    [self postJsonWithPath:URLBASIC_userthirdUserBind parameters:params success:successBlock failure:failureBlock];
}

- (void)appsubmitFeedbackWithcontent:(NSString *)content
                            ssuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (content) {
        [params setObject:content forKey:@"content"];
    }
    [self postJsonWithPath:URLBASIC_appsubmitFeedback parameters:params success:successBlock failure:failureBlock];
}

- (void)userlogoutssuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_userlogout parameters:params success:successBlock failure:failureBlock];
}

- (void)portalqueryFinaProductsssuccess:(RequestSuccess)successBlock
                   failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_portalqueryFinaProducts parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_tpurseusermodifyNicknameWithnickname:(NSString *)nickname
                                      sssuccess:(RequestSuccess)successBlock
                                failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (nickname) {
        [params setObject:nickname forKey:@"nickname"];
    }
    [self postJsonWithPath:URLBASIC_tpurseusermodifyNickname parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_tpurseuserlogoutsssuccess:(RequestSuccess)successBlock
                                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_tpurseuserlogout parameters:params success:successBlock failure:failureBlock];
}



- (void)URLBASIC_portalqueryOrderInfoWithsysId:(NSString *)sysId
                                          sign:(NSString *)sign
                                     timestamp:(NSString *)timestamp
                                             v:(NSString *)v
                                       orderId:(NSString *)orderId
                                     sssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (sysId) {
        [params setObject:sysId forKey:@"sysId"];
    }
    if (sign) {
        [params setObject:sign forKey:@"sign"];
    }
    if (timestamp) {
        [params setObject:timestamp forKey:@"timestamp"];
    }
    if (v) {
        [params setObject:v forKey:@"v"];
    }
    if (orderId) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [self postJsonWithPath:URLBASIC_portalqueryOrderInfo parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_portaladdFavoriteWithmerchId:(NSString *)merchId
                                          title:(NSString *)title
                                     url:(NSURL *)url
                                     sssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (merchId) {
        [params setObject:merchId forKey:@"merchId"];
    }
    if (title) {
        [params setObject:title forKey:@"title"];
    }
    if (url) {
        [params setObject:[url absoluteString] forKey:@"url"];
    }
    [self postJsonWithPath:URLBASIC_portaladdFavorite parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_portalqueryFavoritesWithPageNum:(NSInteger)pageNum
                                    sssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalqueryFavorites parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_portalcancelFavoriteWithlist:(NSArray *)list
                                       sssuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (list) {
        [params setObject:list forKey:@"list"];
    }
    [self postJsonWithPath:URLBASIC_portalcancelFavorite parameters:params success:successBlock failure:failureBlock];
}

@end
