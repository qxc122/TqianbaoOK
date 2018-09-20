//
//  ToolRequest+common.h
//  TourismT
//
//  Created by Store on 16/11/21.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolRequest.h"

#define  LOGIN_TYPE @"01"

#define   PASSENGER_TYPE_NI @"NI" //身份证
#define   PASSENGER_TYPE_P @"P"    //护照
#define   PASSENGER_TYPE_ID @"ID"  //其他证件

#define   SEX_WOMAN @"F" //性别女
#define   SEX_MAN @"M"    //性别男

#define   SYSTEMSENDVERIFYCODEWITHMOBILETYPE_LOGIN  @"01"   // 登录验证码
#define   SYSTEMSENDVERIFYCODEWITHMOBILETYPE_BING  @"02"   
#define   STRING_0 @"0"
#define   STRING_1 @"1"


@interface ToolRequest (common)


/////7-17
- (void)systemsendVerifyCodeForBindCardWithmobile:(NSString *)mobile
                                             type:(NSString *)type
                                        useBindId:(NSNumber *)useBindId
                                         realName:(NSString *)realName
                                           certNo:(NSString *)certNo
                                           cardNo:(NSString *)cardNo
                                         bankCode:(NSString *)bankCode
                                          success:(RequestSuccess)successBlock
                                          failure:(RequestFailure)failureBlock;
////

////////////////////////////////////////T钱包新的//////////////////////////////////////////////////////
- (void)URLBASIC_qrCodescanQRCodeWithpayPassword:(NSString *)payPassword
                                         success:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock;

- (void)URLBASIC_qrCodecheckPayQRCodeStatussuccess:(RequestSuccess)successBlock
                                           failure:(RequestFailure)failureBlock;

- (void)URLBASIC_qrCodegeneratePayQRCodeWithpayMethod:(NSString *)payMethod
                                         devicesToken:(NSString  *)devicesToken
                                              success:(RequestSuccess)successBlock
                                              failure:(RequestFailure)failureBlock;

- (void)URLBASIC_userresetPayPasswordWithpayPassword:(NSString *)payPassword
                                        Bankssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;

- (void)URLBASIC_qrCodecheckPayPasswordWithpayPassword:(NSString *)payPassword
                                               orderId:(NSString *)orderId
                                               success:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock;
//
- (void)URLBASIC_loanloanApplyWithparams:(NSMutableDictionary *)params
                             payPassword:(NSString *)payPassword
                                 success:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_tpTreasurewithdrawWithmoney:(NSNumber *)money
                                      bindId:(NSNumber *)bindId
                                 payPassword:(NSString *)payPassword
                                     success:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock;

- (void)URLBASIC_loanloanRepayWithamt:(NSNumber *)amt
                               bindId:(NSNumber *)bindId
                               acctId:(NSNumber *)acctId
                          payPassword:(NSString *)payPassword
                            payMethod:(NSString *)payMethod
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_loanloanRepayWithamt:(NSNumber *)amt
                               bindId:(NSNumber *)bindId
                          payPassword:(NSString *)payPassword
                            payMethod:(NSString *)payMethod
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_userfinishExpMoneyIncomesuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_loanloanApplyWithloanAmt:(NSNumber *)loanAmt
                               loanPeriod:(NSInteger)loanPeriod
                              payPassword:(NSString *)payPassword
                                  success:(RequestSuccess)successBlock
                                  failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_tpTreasurerechargeWithmoney:(NSNumber *)money
                                      bindId:(NSNumber *)bindId
                                        type:(NSString *)type
                                 payPassword:(NSString *)payPassword
                                     success:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_tpTreasurequeryPayMethodWith:(NSString *)type
                                      success:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpTreasuresendVerifyCodeWithverifyCode:(NSString *)verifyCode
                                                success:(RequestSuccess)successBlock
                                                failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_appqueryHomesuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;

- (void)URLBASIC_userreceiveExpMoneysuccess:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_tpurseuserqueryMyFlightsuccess:(RequestSuccess)successBlock
                                        failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpursetpursesystemapplyAuthCodesuccess:(RequestSuccess)successBlock
                                                failure:(RequestFailure)failureBlock;

- (void)URLBASIC_orderqueryOrderInfoWithSysId:(NSString *)sysId
                                         Sign:(NSString *)sign
                                    Timestamp:(NSString *)timestamp
                                            V:(NSString *)v
                                      OrderId:(NSString *)orderId
                                      success:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpurseuserqueryMyBanksuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;

- (void)systemsendVerifyCodeWithmobile:(NSString *)mobile
                                  type:(NSString *)type
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock;

- (void)userloginWithmobile:(NSString *)mobile
                 verifyCode:(NSString *)verifyCode
          graphicVerifyCode:(NSString *)graphicVerifyCode
                    success:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock;

- (void)URLBASIC_useraddPayPasswordWithpayPassword:(NSString *)payPassword
                                           success:(RequestSuccess)successBlock
                                           failure:(RequestFailure)failureBlock;

- (void)tpursesystemgetGraphicVerifyCodesuccess:(RequestSuccess)successBlock
                                        failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpurseusermyInfosuccess:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpurseusermodifyNicknameWithnickname:(NSString *)nickname
                                            sssuccess:(RequestSuccess)successBlock
                                              failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpurseuserlogoutsssuccess:(RequestSuccess)successBlock
                                   failure:(RequestFailure)failureBlock;

- (void)appgetGlobalParamssuccess:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock;

- (void)URLBASIC_userqueryWithfilterFlag:(NSString *)filterFlag
                            Bankssuccess:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock;

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
                                      failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpTreasurenoticeWith:(NSString *)type
                              success:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_flightqueryGssFlightDynamicWithdepDate:(NSString *)depDate
                                               flightNo:(NSString *)flightNo
                                                depTime:(NSString *)depTime
                                                arrTime:(NSString *)arrTime
                                                success:(RequestSuccess)successBlock
                                                failure:(RequestFailure)failureBlock;

- (void)moneySystemsendVerifyCodeWithmobile:(NSString *)mobile
                                       type:(NSString *)type
                                     bindId:(NSInteger )bindId
                                      money:(double )money
                                     codeId:(NSString *)codeId
                                    success:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock;

- (void)URLBASIC_userwithdrawWithmoney:(double )money
                                bindId:(double )bindId
                           payPassword:(NSString *)payPassword
                            verifyCode:(NSString  *)verifyCode
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock;

- (void)URLBASIC_userrechargeWithmoney:(double )money  
                                bindId:(double )bindId
                           payPassword:(NSString *)payPassword
                            verifyCode:(NSString  *)verifyCode
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock;

- (void)URLBASIC_qrCodegenerateQRCodeWithdevicesToken:(NSString *)devicesToken
                                              success:(RequestSuccess)successBlock
                                              failure:(RequestFailure)failureBlock;

- (void)URLBASIC_qrCodescanQRCodeWithcodeId:(NSString *)codeId
                                    success:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock;

- (void)URLBASIC_qrCodeunifiedPayWithcodeId:(NSString *)codeId
                                      money:(NSNumber *)money
                                     bindId:(NSNumber *)bindId
                                  payMethod:(NSString *)payMethod
                                payPassword:(NSString *)payPassword
                                 verifyCode:(NSString  *)verifyCode
                                    success:(RequestSuccess)successBlock
                                    failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpurseuserqueryPayMethodsuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock;

- (void)URLBASIC_orderpayThirdOrderWithorderId:(NSString *)orderId
                                     payMethod:(NSString *)payMethod
                                        bindId:(NSNumber *)bindId
                                    orderPrice:(NSNumber *)orderPrice
                                     tcoinFlag:(NSString *)tcoinFlag
                                   payPassword:(NSString *)payPassword
                                    verifyCode:(NSString  *)verifyCode
                                       success:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock;

- (void)URLBASIC_usercheckVerifyCodeWithverifyCode:(NSString *)verifyCode
                                           success:(RequestSuccess)successBlock
                                           failure:(RequestFailure)failureBlock;

- (void)URLBASIC_usercheckPayPasswordWithpayPassword:(NSString *)payPassword
                                             success:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;

- (void)URLBASIC_qrCodecancelUnifiedPayWithcodeId:(NSString *)codeId
                                       verifyCode:(NSString  *)verifyCode
                                          success:(RequestSuccess)successBlock
                                          failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpurseusermyCardInfosuccess:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock;

- (void)URLBASIC_regularFinmyRegularFinsuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock;

- (void)URLBASIC_regularFinrechargeWithmoney:(double )money
                                      bindId:(double )bindId
                                rechargeType:(NSString *)rechargeType
                                     success:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock;

- (void)URLBASIC_regularFintpurseRechargeWithpayPassword:(NSString *)payPassword
                                             orderId:(NSString *)orderId
                                           orderDesc:(NSString *)orderDesc
                                          orderPrice:(double )orderPrice
                                             success:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;

- (void)URLBASIC_tpursesystemcheckVerifyCodeWithtype:(NSString *)type
                                          verifyCode:(NSString *)verifyCode
                                             success:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;
    
- (void)URLBASIC_regularFinwithdrawWithmoney:(double )money
                                      bindId:(double )bindId
                                     success:(RequestSuccess)successBlock
                                     failure:(RequestFailure)failureBlock;
////////////////////////////////////////T钱包新的//////////////////////////////////////////////////////


- (void)URLBASIC_appappUpdatesuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;
    


- (void)usermyInfosuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock;

- (void)portalusermyNewWithPageNum:(NSInteger)pageNum
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock;


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
                                       failure:(RequestFailure)failureBlock;
//contactId	联系人编号
- (void)portalcommonInfodeleteContactInfoWithcontactId:(NSInteger)contactId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock;
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
                                             failure:(RequestFailure)failureBlock;
- (void)portalcommonInfoqueryContactInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;
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
                                               failure:(RequestFailure)failureBlock;
//addressId	地址编号
- (void)portalcommonInfodeleteAddressInfoWithaddressId:(NSInteger)addressId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock;
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
                                             failure:(RequestFailure)failureBlock;
- (void)portalcommonInfoqueryAddressInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;
//END地址  增 删 该 查
/*************************************************************************************************/

/*************************************************************************************************/
//旅客  增 删 该 查
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
                                   failure:(RequestFailure)failureBlock;
//passengerId	编号
- (void)commonInfodeletePassengerInfoWithpassengerId:(NSInteger)passengerId
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;
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
                                           failure:(RequestFailure)failureBlock;
- (void)portalcommonInfoqueryPassengerInfosWithPageNum:(NSInteger)pageNum
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock;
//END旅客   增 删 该 查
/*************************************************************************************************/

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
                              failure:(RequestFailure)failureBlock;

- (void)userthirdUserBindWithunionId:(NSString *)unionId
                              mobile:(NSString *)mobile
                          verifyCode:(NSString *)verifyCode
                            ssuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;

- (void)appsubmitFeedbackWithcontent:(NSString *)content
                                     ssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;

- (void)userlogoutssuccess:(RequestSuccess)successBlock
                   failure:(RequestFailure)failureBlock;

- (void)portalqueryFinaProductsssuccess:(RequestSuccess)successBlock
                                failure:(RequestFailure)failureBlock;

- (void)URLBASIC_usermodifyNicknameWithnickname:(NSString *)nickname
                                      sssuccess:(RequestSuccess)successBlock
                                        failure:(RequestFailure)failureBlock;



- (void)URLBASIC_portalqueryOrderInfoWithsysId:(NSString *)sysId
                                          sign:(NSString *)sign
                                     timestamp:(NSString *)timestamp
                                             v:(NSString *)v
                                       orderId:(NSString *)orderId
                                     sssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock;

- (void)URLBASIC_portaladdFavoriteWithmerchId:(NSString *)merchId
                                        title:(NSString *)title
                                          url:(NSURL *)url
                                    sssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;

- (void)URLBASIC_portalqueryFavoritesWithPageNum:(NSInteger)pageNum
                                       sssuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock;

- (void)URLBASIC_portalcancelFavoriteWithlist:(NSArray *)list
                                    sssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;
@end
