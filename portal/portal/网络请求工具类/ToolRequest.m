//
//  ToolRequest.m
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolRequest.h"
#import "HeaderAll.h"
#import "OpenUDID.h"


#define  RETSTATUSSUCCESS   @"0"
#define  RETSTATUFAILURE   @"-1"

#define REAUESRTIMEOUT      60.f    //网络请求超时时间


#define PROMPT_FAIL         NSLocalizedString(@"加载失败", @"加载失败")
#define PROMPT_NOTJSON      NSLocalizedString(@"数据有误", @"数据有误")
#define PROMPT_NOTCONNECT   NSLocalizedString(@"网络连接异常，请检查网络", @"网络连接异常，请检查网络")


@interface ToolRequest ()
@property (strong, nonatomic) NSString *baseURLStr;
@property (strong, nonatomic) AFNetworkReachabilityManager *manger;
@end
//AFNetworkReachabilityStatus Netstatus;
@implementation ToolRequest
+ (ToolRequest *)sharedInstance
{
    static ToolRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
#ifdef DEBUG
    NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
    if (!strles) {
        [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
        strles = tesetURLAddress;
    }else{
        strles = strles;
    }
    instance.baseURLStr = strles;
#else
    instance.baseURLStr = URLBASIC;
#endif
    return instance;
}

- (void)postJsonWithPath:(NSString *)path
              parameters:(NSMutableDictionary *)parameters
                 success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock
{
    if (![PortalHelper sharedInstance].isReachable && [PortalHelper sharedInstance].initreachable) {
        failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
    }else{
        NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
        [parameters setObject:PORTALCHANNEL forKey:@"channel"];
        [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
        [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
        
        if ([path isEqualToString:URLBASIC_tpurseusermyInfo]) {
            [parameters setObject:@"2.0" forKey:@"version"];
        } else {
            [parameters setObject:PORTALVERSION forKey:@"version"];
        }
        
        NSString *userId = [[PortalHelper sharedInstance]get_userInfo].userId;
        if (userId && userId.length) {
            [parameters setObject:userId forKey:@"userId"];
        }
        
        if ((accessToken && ![[NSDate date]isLaterThanOrEqualTo:[[PortalHelper sharedInstance]get_accessToken].expireTime]) || [path isEqualToString:URLBASIC_tpurseappappIdApply] || [path isEqualToString:URLBASIC_apptokenApply]) {
            if (accessToken) {
                [parameters setObject:accessToken forKey:@"accessToken"];
            }
            NSString *urlStr = [NSString stringWithFormat:@"%@%@", self.baseURLStr, path];
            urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json",@"text/html", nil];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-zip-compressed"];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
            manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
            
#ifdef DEBUG
            NSLog(@"strTmp=%@  path=%@",[parameters DicToJsonstr],urlStr);
#endif
            
//            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//            manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
//            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
//            //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
//            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json",@"text/html", nil];
            
            [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject) {
                    id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                    [self parseResponseData:result WithPath:path parameters:parameters success:successBlock failure:failureBlock ifRespondDataEncrypted:NO];
                }else{
                    failureBlock(KRespondCodeNone, @"服务器返回数据为空");
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef DEBUG
                NSLog(@"strTmp=%@  path=%@",[error description],urlStr);
#endif
                if (![PortalHelper sharedInstance].isReachable) {
                    failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
                }else{
                    NSDictionary *tmp = error.userInfo;
                    NSString *tmpStr = tmp[@"NSLocalizedDescription"];
                    failureBlock(KRespondCodeFail, tmpStr);
                }
            }];
        }else{ //没有token  去申请
            if (![[PortalHelper sharedInstance] get_appIdAndSecret]) {
                kWeakSelf(self);
                [self tpurseappappIdApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
                    appIdAndSecret *appid =[appIdAndSecret mj_objectWithKeyValues:dataDict];
                    [[PortalHelper sharedInstance] set_appIdAndSecret:appid];
                    [weakself askforTokenWithPath:path parameters:parameters success:successBlock failure:failureBlock];
                } failure:^(NSInteger errorCode, NSString *msg) {
                    failureBlock(errorCode,msg);
                }];
            } else {
                if (![[PortalHelper sharedInstance] get_accessToken]) {
                    [self askforTokenWithPath:path parameters:parameters success:successBlock failure:failureBlock];
                } else {
                    if ([[NSDate date]isLaterThanOrEqualTo:[[PortalHelper sharedInstance]get_accessToken].expireTime]) { //过期了
                        [self RefreshTokenWithPath:path parameters:parameters success:successBlock failure:failureBlock];
                    }
                }
            }
        }
    }
}
- (void)askforTokenWithPath:(NSString *)path
                 parameters:(NSMutableDictionary *)parameters
                    success:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock{
    kWeakSelf(self);
    [self apptokenApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        accessToken *token =[accessToken mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance] set_accessToken:token];
        
        NSNotification *notification =[NSNotification notificationWithName:GET_NEW_TOKEN_NOTIFICATION object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [weakself postJsonWithPath:path parameters:parameters success:successBlock failure:failureBlock];
    } failure:^(NSInteger errorCode, NSString *msg) {
        failureBlock(errorCode,msg);
    }];
}

- (void)RefreshTokenWithPath:(NSString *)path
      parameters:(NSMutableDictionary *)parameters
         success:(RequestSuccess)successBlock
         failure:(RequestFailure)failureBlock{
    kWeakSelf(self);
    [self apptokenApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        accessToken *token =[accessToken mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance] set_accessToken:token];
        
        NSNotification *notification =[NSNotification notificationWithName:GET_NEW_TOKEN_NOTIFICATION object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            [weakself RefreshTiketWithPath:path parameters:parameters success:successBlock failure:failureBlock];
        } else {
            [weakself postJsonWithPath:path parameters:parameters success:successBlock failure:failureBlock];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        failureBlock(errorCode,msg);
    }];
}

- (void)RefreshTiketWithPath:(NSString *)path
                  parameters:(NSMutableDictionary *)parameters
                     success:(RequestSuccess)successBlock
                     failure:(RequestFailure)failureBlock{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_userrefreshLoginWithnisssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [[PortalHelper sharedInstance]get_userInfo];
        UserInfo *now = [UserInfo mj_objectWithKeyValues:dataDict];
        if (now.authenTicket.length) {
            tmp.authenTicket = now.authenTicket;
        }
        if (now.authenUserId.length) {
            tmp.authenUserId = now.authenUserId;
        }
        if (now.userId.length) {
            tmp.userId = now.userId;
        }
        NSNotification *notification =[NSNotification notificationWithName:@"loadNewData" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        
        [weakself postJsonWithPath:path parameters:parameters success:successBlock failure:failureBlock];
    } failure:^(NSInteger errorCode, NSString *msg) {
        failureBlock(errorCode,msg);
    }];
}
    
//验证返回数据是否正确
- (void)parseResponseData:(id)responseData
                 WithPath:(NSString *)path
               parameters:(NSMutableDictionary *)parameters
                  success:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock
   ifRespondDataEncrypted:(BOOL)encryptedReponse
{
    NSDictionary *jsonRootObject = (NSDictionary *)responseData;
    if (jsonRootObject == nil) {
        failureBlock(kRespondCodeNotJson, PROMPT_NOTJSON);
    }else {
        NSString *code = [jsonRootObject valueForKeyPath:@"retStatus"];
        NSString *msg = [jsonRootObject valueForKeyPath:@"errorMsg"];
        if ([code isEqualToString:RETSTATUSSUCCESS]) {
            successBlock(jsonRootObject, msg, [RETSTATUSSUCCESS integerValue]);
        } else if ([code isEqualToString:RETSTATUFAILURE]) {
            NSInteger errorCode = [[jsonRootObject valueForKeyPath:@"errorCode"] integerValue];
            failureBlock(errorCode, msg);
            if (errorCode == kRespondCodeExoipDateAccessToken) {    /** Token无效 */
                [self askforTokenWithPath:path parameters:parameters success:successBlock failure:failureBlock];
            }else if (errorCode == kRespondCodeuserdoesnotexist) {
//                [[PortalHelper sharedInstance]set_userInfo:nil];
//                [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
//                NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
                if ([[PortalHelper sharedInstance]get_userInfo]) {
                    [[ToolRequest sharedInstance]URLBASIC_userrefreshLoginWithnisssuccess:^(id dataDict, NSString *msg, NSInteger code) {
                        UserInfo *userInfo =[UserInfo mj_objectWithKeyValues:dataDict];
                        UserInfo *tmp = [[PortalHelper sharedInstance] get_userInfo];
                        tmp.authenTicket = userInfo.authenTicket;
                        tmp.authenUserId = userInfo.authenUserId;
                        [[PortalHelper sharedInstance] set_userInfo:tmp];
                    } failure:^(NSInteger errorCode, NSString *msg) {
                        NSLog(@"sdf");
                        failureBlock(KRespondCodeFail, msg);
                    }];
                }
            }
        } else {
            failureBlock(KRespondCodeFail, msg);
        }
    }
}

//更新个人资料
- (void)appuserupdateWithAvtor:(UIImage *)avtor
                      progress:(RequestProgress)progressBlock
                       success:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].userId;
    if (userId && userId.length) {
        [parameters setObject:userId forKey:@"userId"];
    }
    if (accessToken) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }
    NSDictionary *appRequest = @{
                                 @"sessionContext":[parameters dictionaryToJsonStr],
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
#ifdef DEBUG
    NSLog(@"strTmp=%@  path=%@",[parameters DicToJsonstr],[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_userheadUpload]);
#endif
    //2.上传文件
    [manager POST:[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_userheadUpload] parameters:appRequest constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *tmp = avtor;
        //            UIImage *tmp = [UIImage imageNamed:@"1"];
        NSData *imageData = UIImageJPEGRepresentation(tmp,1.0);//进行图片压缩
        CGFloat yasou=0.99;
        while (imageData.length > 1024*1024) {
            tmp = avtor;
            NSLog(@"太大了 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
            imageData = UIImageJPEGRepresentation(tmp, yasou);
            if (imageData.length > 10*1024*1024) {
                yasou *=0.1;
            } else if (imageData.length > 5*1024*1024){
                yasou *=0.2;
            } else if (imageData.length > 4*1024*1024){
                yasou *=0.6;
            } else if (imageData.length > 3*1024*1024){
                yasou *=0.7;
            } else if (imageData.length > 2*1024*1024){
                yasou *=0.8;
            } else if (imageData.length > 1*1024*1024){
                yasou *=0.9;
            }
            NSLog(@"压小后 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
        }
        NSLog(@"imageData.leng=%ld k",imageData.length/1024);
        
        if (imageData.length) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"files.png" mimeType:@"image/png"];
        }else{
            failureBlock(-1,NSLocalizedString(@"The picture is empty", @"The picture is empty"));
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            [self parseResponseData:result WithPath:nil parameters:parameters success:successBlock failure:failureBlock ifRespondDataEncrypted:NO];
        }else{
            failureBlock(KRespondCodeNone, NSLocalizedString(@"The server returns the data blank", @"The server returns the data blank"));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![PortalHelper sharedInstance].isReachable) {
            failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
        }else{
            NSDictionary *tmp = error.userInfo;
            NSString *tmpStr = tmp[@"NSLocalizedDescription"];
            failureBlock(KRespondCodeFail, tmpStr);
        }
    }];
}


//更新个人资料
- (void)appuserupdateWithImages:(NSArray *)Images
                        content:(NSString *)content
                  contactMethod:(NSString *)contactMethod
                      progress:(RequestProgress)progressBlock
                       success:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].userId;
    if (userId && userId.length) {
        [parameters setObject:userId forKey:@"userId"];
    }
    if (accessToken) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }
    NSDictionary *appRequest = @{
                                 @"sessionContext":[parameters dictionaryToJsonStr],
                                 @"content":content,
                                 @"contactMethod":contactMethod?contactMethod:@"",
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
#ifdef DEBUG
    NSLog(@"strTmp=%@  path=%@",[appRequest DicToJsonstr],[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_tpurseusersubmitFeedback]);
#endif
    //2.上传文件
    [manager POST:[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_tpurseusersubmitFeedback] parameters:appRequest constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *tmp in Images) {
            NSData *imageData = UIImageJPEGRepresentation(tmp,1.0);//进行图片压缩
            CGFloat yasou=0.99;
            while (imageData.length > 1024*1024) {
                NSLog(@"太大了 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                imageData = UIImageJPEGRepresentation(tmp, yasou);
                if (imageData.length > 10*1024*1024) {
                    yasou *=0.1;
                } else if (imageData.length > 5*1024*1024){
                    yasou *=0.2;
                } else if (imageData.length > 4*1024*1024){
                    yasou *=0.6;
                } else if (imageData.length > 3*1024*1024){
                    yasou *=0.7;
                } else if (imageData.length > 2*1024*1024){
                    yasou *=0.8;
                } else if (imageData.length > 1*1024*1024){
                    yasou *=0.9;
                }
                NSLog(@"压小后 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
            }
            NSLog(@"imageData.leng=%ld k",imageData.length/1024);
            
            if (imageData.length) {
                [formData appendPartWithFileData:imageData name:@"files" fileName:@"files.png" mimeType:@"image/png"];
            }else{
                failureBlock(-1,NSLocalizedString(@"The picture is empty", @"The picture is empty"));
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            [self parseResponseData:result WithPath:nil parameters:parameters success:successBlock failure:failureBlock ifRespondDataEncrypted:NO];
        }else{
            failureBlock(KRespondCodeNone, NSLocalizedString(@"The server returns the data blank", @"The server returns the data blank"));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![PortalHelper sharedInstance].isReachable) {
            failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
        }else{
            NSDictionary *tmp = error.userInfo;
            NSString *tmpStr = tmp[@"NSLocalizedDescription"];
            failureBlock(KRespondCodeFail, tmpStr);
        }
    }];
}

- (void)tpurseappappIdApplysuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *deviceId = [OpenUDID value];
    if (deviceId) {
        [params setObject:deviceId forKey:@"deviceId"];
    }
    [self postJsonWithPath:URLBASIC_tpurseappappIdApply parameters:params success:successBlock failure:failureBlock];
}
- (void)apptokenApplysuccess:(RequestSuccess)successBlock
                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    appIdAndSecret *data =  [[PortalHelper sharedInstance] get_appIdAndSecret];
    if (data.appId) {
        [params setObject:data.appId forKey:@"appId"];
    }
    NSString *deviceId = [OpenUDID value];
    if (deviceId) {
        [params setObject:deviceId forKey:@"deviceId"];
    }
    NSString *timestamp = TIMESTAMP;
    if (timestamp) {
        [params setObject:timestamp forKey:@"timestamp"];
    }
    NSString *sign = @"000";
    //    NSString *sign = [NSString stringWithFormat:@"%@%@%@",deviceId,data.appSecret,timestamp];
    if (sign) {
        [params setObject:sign forKey:@"sign"];
    }
    [self postJsonWithPath:URLBASIC_apptokenApply parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_userrefreshLoginWithnisssuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([[PortalHelper sharedInstance]get_userInfo].authenTicket) {
        [params setObject:[[PortalHelper sharedInstance]get_userInfo].authenTicket forKey:@"ticket"];
    }
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)[NSDate date].timeIntervalSince1970];
    if (timestamp) {
        [params setObject:timestamp forKey:@"timestamp"];
    }
    [self postJsonWithPath:URLBASIC_userrefreshLogin parameters:params success:successBlock failure:failureBlock];
}
@end
