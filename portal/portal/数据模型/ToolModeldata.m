//
//  ToolModeldata.m
//  TourismT
//
//  Created by Store on 16/12/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolModeldata.h"
#import "MJExtension.h"
#import "ToolRequest+common.h"
#import "NSString+Add.h"
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
//+ (NSDictionary *)mj_replacedKeyFromPropertyName;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 从字典中取值用的key
 */
//+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName;


/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property;
//    if ([property.name isEqualToString:@"publisher"]) {
//        if (oldValue == nil) return @"";
//    } else if (property.type.typeClass == [NSDate class]) {
//        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//        fmt.dateFormat = @"yyyy-MM-dd";
//        return [fmt dateFromString:oldValue];
//    }  

//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
//    return @{
//             @"contentA" : @"content",
//             @"pageableD" : @"pageable",
//             };
//}
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{
//             @"contentA" : @"contentS",
//             };
//}




@implementation tpTreasurequeryPayMethod
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bankCards" : @"ThreeOkBankOne",
             };
}
@end

@implementation appIdAndSecret
MJExtensionCodingImplementation
@end

@implementation oneHomeData

@end

@implementation accessToken
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"expireTime"]) {
        if (oldValue && [oldValue isKindOfClass:[NSNumber class]]) {
            return [NSDate dateWithTimeIntervalSinceNow:[oldValue integerValue]];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end


@implementation outORINSuccess
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bankIcon"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end
@implementation ApplySuccessOKdata
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"bankNo" : @"cardNo"
             };
}



- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bankIcon"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation reApplySuccessOKdata
//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
//    return @{
//             @"bankNo" : @"cardNo"
//             };
//}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bankIcon"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end



@implementation UserInfo
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"headUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"payPasswordFlag"] || [property.name isEqualToString:@"gestureFlag"]){
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if ([tmp isEqualToString:STRING_1]) {
                return @YES;
            }else {
                return @NO;
            }
        } else {
            return @NO;
        }
    }
    return oldValue;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"fullMobile" : @"mobile",
             };
}
@end

@implementation graphicVerifyCodeUrlInfo

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"graphicVerifyCodeUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation HomeDataNew
MJExtensionCodingImplementation
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bannerInfos" : @"bannerInfosOne",
             @"prgInfos" : @"prgInfosOne",
             };
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"fundUrl"] || [property.name isEqualToString:@"loanUrl"] || [property.name isEqualToString:@"privateFundUrl"] || [property.name isEqualToString:@"topPicture"] || [property.name isEqualToString:@"topHref"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"incomeRatio"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                if ([tmp containsString:@"%"]) {
                    return tmp;
                } else {
                    return [NSString stringWithFormat:@"%@%%",tmp];
                }
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end
@implementation prgInfosOne
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"graphicVerifyCodeUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"prgRate"] || [property.name isEqualToString:@"increaseRate"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                if ([tmp containsString:@"%"]) {
                    return tmp;
                } else {
                    if ([property.name isEqualToString:@"increaseRate"]) {
                        return [NSString stringWithFormat:@"+%@%%",tmp];
                    } else {
                        return [NSString stringWithFormat:@"%@%%",tmp];
                    }
                }
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"period"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                if ([tmp containsString:@"个月"]) {
                    return tmp;
                } else {
                    return [NSString stringWithFormat:@"%@个月",tmp];
                }
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"repayMod"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                if ([tmp isEqualToString:@"0"]) {
                    return @"一次性还本付息";
                } else if ([tmp isEqualToString:@"1"]) {
                    return @"每月付息到期还本";
                } else if ([tmp isEqualToString:@"2"]) {
                    return @"等额本息";
                } else if ([tmp isEqualToString:@"4"]) {
                    return @"等额本金";
                } else if ([tmp isEqualToString:@"5"]) {
                    return  @"等本等息";
                }
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}


@end
@implementation bannerInfosOne
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"picture"] || [property.name isEqualToString:@"href"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end


@implementation AirInfo

@end

@implementation UMdeviceToken
MJExtensionCodingImplementation
@end



@implementation RechargeSuccess
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bankIcon"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation Successincashwithdrawal

@end

@implementation Conductfinancialtransactions
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bankIcon"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end


//@implementation BankList
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{
//             @"list" : @"bankCard",
//             };
//}
//@end


@implementation noticeData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"idd" : @"id",
             };
}
@end

@implementation UserInfoDeatil
MJExtensionCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_list" : @"list",
             @"mynewUserFlag" : @"newUserFlag",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_list" : @"bankCard",
             };
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"integralUrl"] || [property.name isEqualToString:@"headUrl"] || [property.name isEqualToString:@"loanUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"fundBal"] || [property.name isEqualToString:@"loanDueRepayAmt"] || [property.name isEqualToString:@"loanCnt"]){
        if (oldValue && [oldValue isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%.2f",[oldValue doubleValue]];
        } else {
            return @"0.00";
        }
    }else if ([property.name isEqualToString:@"mynewUserFlag"] || [property.name isEqualToString:@"receiveExpMoneyFlag"]){
        NSString *tmp = oldValue;
        if (oldValue && [oldValue isKindOfClass:[NSString class]] && tmp.length) {
            return oldValue;
        } else {
            return @"0";
        }
    }
//    else  if ([property.name isEqualToString:@"userName"]) {
//        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
//            NSString *tmp = oldValue;
//            if (tmp.length >1) {
//                NSString *tmpTwo = @"";
//                for (NSInteger index = 0; index<tmp.length-1; index++) {
//                    tmpTwo = [tmpTwo stringByAppendingString:@"*"];
//                }
//                return [NSString stringWithFormat:@"%@%@",[tmp substringToIndex:1],tmpTwo];
//            }
//        } else {
//            return nil;
//        }
//    }
    
    
    return oldValue;
}
@end


@implementation QRcode
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"codeUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end




@implementation bankCard
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bankIcon"] || [property.name isEqualToString:@"bigBankIcon"] || [property.name isEqualToString:@"airLogo"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    else if ([property.name isEqualToString:@"cardNo"] ){
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
//            if ([tmp rangeOfString:@" "].location == NSNotFound) {
//                return [tmp formatterBankCardNum];
//            } else
            if(tmp.length == 4){
                return [tmp formatterBankCardNumTwo];
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation bankList
MJExtensionCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_list" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_list" : @"bankCard",
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"cardNo"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if ([tmp hasPrefix:@"*"]) {
                return oldValue;
            } else if(tmp.length){
                return [NSString stringWithFormat:@"****  ****  ****  %@",tmp];
            }else{
                return oldValue;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end
@implementation GlobalParameter
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"totalAssetUrl"] || [property.name isEqualToString:@"balUrl"] || [property.name isEqualToString:@"privacyAgreementUrl"] || [property.name isEqualToString:@"myFinUrl"] || [property.name isEqualToString:@"finUrl"] || [property.name isEqualToString:@"registAgreementUrl"]|| [property.name isEqualToString:@"myBillUrl"] || [property.name isEqualToString:@"myReceivableUrl"]|| [property.name isEqualToString:@"finCalendarUrl"] || [property.name isEqualToString:@"finBillUrl"] || [property.name isEqualToString:@"tpurseServicetAgreementUrl"] || [property.name isEqualToString:@"vcServiceAgreementUrl"] || [property.name isEqualToString:@"vcPrivacyAgreementUrl"] || [property.name isEqualToString:@"tpursePayAgreementUrl"]|| [property.name isEqualToString:@"fundUrl"] || [property.name isEqualToString:@"fundQaUrl"] || [property.name isEqualToString:@"fundBillUrl"] || [property.name isEqualToString:@"myLoanUrl"]|| [property.name isEqualToString:@"myLoanRecordUrl"]|| [property.name isEqualToString:@"tpurseServiceRechargeAgreementUrl"]|| [property.name isEqualToString:@"tpurseServiceCustomerAgreementUrl"] || [property.name isEqualToString:@"fundAcctPayAgreementUrl"]) {

        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
//            NSString *tmp = oldValue;
//            if ([property.name isEqualToString:@"myBillUrl"] && ![tmp hasSuffix:@"?t=2"]) {
//                return [NSURL URLWithString:[NSString stringWithFormat:@"%@?t=2",oldValue]];
//            } else {
//                return [NSURL URLWithString:oldValue];
//            }
            
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation MaldivesPushcontent

@end

@implementation MaldivesPush

@end

@implementation scanQRCodeOk
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bankCardArray" : @"scanQRCodeBankOne",
             };
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"payeeLogo"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation ximengOK
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"redirectUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation ThreeOk
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"bankCardsArray" : @"bankCards",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bankCardsArray" : @"ThreeOkBankOne",
             };
}
@end

@implementation ThreeOkBankOne
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bigBankIcon"] || [property.name isEqualToString:@"bankIcon"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end


@implementation noticationData
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"content"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end



@implementation scanQRCodeDone

@end

@implementation scanQRCodeBankOne
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"bankIcon"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end


@implementation HomeData
MJExtensionCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_merchList" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_merchList" : @"HomeDataOne",
             };
}
@end


@implementation HomeDataOne
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"merchIcon"] || [property.name isEqualToString:@"merchLink"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"needLogin"]) {
        if ([oldValue isKindOfClass:[NSString class]]) {
            if ([oldValue isEqualToString:@"1"]) {
                return @YES;
            } else if ([oldValue isEqualToString:@"0"]) {
                return @NO;
            }else{
                return @YES;
            }
        } else {
            return @YES;
        }
    }
    return oldValue;
}
@end

@implementation leftData


@end

@implementation MyNewsData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_newsList" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_newsList" : @"MyNewsData_One",
             };
}
@end

@implementation MyNewsData_One
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"newsLink"] || [property.name isEqualToString:@"newsImg"]  ) {  
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation MyCollecData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_List" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_List" : @"MyCollecData_One",
             };
}
@end

@implementation MyCollecData_One
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"url"] || [property.name isEqualToString:@"logo"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end



@implementation FinanceVcData
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"fundProductPicture"] || [property.name isEqualToString:@"fundProductLink"]  || [property.name isEqualToString:@"vcProductLink"] || [property.name isEqualToString:@"vcProductPicture"]  ) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_insuranceProductList" : @"insuranceProductList",
             @"Arry_tourProductList" : @"tourProductList",
             @"Arry_tpurseProductList" : @"tpurseProductList",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_insuranceProductList" : @"FinanceVcData_One",
             @"Arry_tourProductList" : @"FinanceVcData_One",
             @"Arry_tpurseProductList" : @"FinanceVcData_One",
             };
}
@end

@implementation FinanceVcData_One
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"productLink"] || [property.name isEqualToString:@"productPicture"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"needLogin"]) {
        if ([oldValue isKindOfClass:[NSString class]]) {
            if ([oldValue isEqualToString:@"1"]) {
                return @YES;
            } else if ([oldValue isEqualToString:@"0"]) {
                return @NO;
            }else{
                return @YES;
            }
        } else {
            return @YES;
        }
    }
    return oldValue;
}
@end

@implementation passengerInfos
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_passengerInfos" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_passengerInfos" : @"passengerInfos_one",
             };
}
@end

@implementation passengerInfos_one
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_certInfos" : @"certInfos",
             @"nationalityCode" : @"nationality",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_certInfos" : @"certInfos_one",
             };
}
- (id)copyWithZone:(NSZone *)zone
{
    passengerInfos_one *cpyPerson = [[passengerInfos_one allocWithZone:zone] init];
    cpyPerson.enName = self.enName;
    cpyPerson.mobile = self.mobile;
    cpyPerson.passengerId = self.passengerId;
    cpyPerson.selfFlag = self.selfFlag;
    cpyPerson.surname = self.surname;
    cpyPerson.birthday = self.birthday;
    cpyPerson.sex = self.sex;
    cpyPerson.name = self.name;
    cpyPerson.Arry_certInfos = [self.Arry_certInfos mutableCopy];
    return cpyPerson;
}
@end

@implementation certInfos_one
- (id)copyWithZone:(NSZone *)zone
{
    certInfos_one *cpyPerson = [[certInfos_one allocWithZone:zone] init];
    cpyPerson.certNo = self.certNo;
    cpyPerson.nationality = self.nationality;
    cpyPerson.certType = self.certType;
    cpyPerson.certId = self.certId;
    cpyPerson.expireDate = self.expireDate;
    return cpyPerson;
}
@end




@implementation contactInfos
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_contactInfos" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_contactInfos" : @"contactInfos_one",
             };
}
@end


@implementation addressInfos
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_addressInfos" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_addressInfos" : @"addressInfos_one",
             };
}
@end

@implementation contactInfos_one
- (id)copyWithZone:(NSZone *)zone
{
    contactInfos_one *cpyPerson = [[contactInfos_one allocWithZone:zone] init];
    cpyPerson.email = self.email;
    cpyPerson.contactId = self.contactId;
    cpyPerson.mobile = self.mobile;
    cpyPerson.name = self.name;
    cpyPerson.userId = self.userId;
    cpyPerson.selfFlag = self.selfFlag;
    return cpyPerson;
}
@end
@implementation addressInfos_one
- (id)copyWithZone:(NSZone *)zone
{
    addressInfos_one *cpyPerson = [[addressInfos_one allocWithZone:zone] init];
    cpyPerson.receiverMobile = self.receiverMobile;
    cpyPerson.area = self.area;
    cpyPerson.city = self.city;
    cpyPerson.addressId = self.addressId;
    cpyPerson.receiverName = self.receiverName;
    cpyPerson.selfFlag = self.selfFlag;
    cpyPerson.userId = self.userId;
    cpyPerson.detailAddress = self.detailAddress;
    cpyPerson.province = self.province;
    cpyPerson.postCode = self.postCode;
    return cpyPerson;
}
@end
@implementation CheckApp
@end

@implementation setUp
MJExtensionCodingImplementation
@end

@implementation setUpdatePre
MJExtensionCodingImplementation
@end



@implementation setUpAll
MJExtensionCodingImplementation
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_all" : @"setUp",
             };
}
@end

@implementation payPre

@end

@implementation payData

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation setUpData

@end
