//
//  ToolRequest.h
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MACRO_ENUM.h"
#import "MACRO_URL.h"
#import "NSUserDefaults+storage.h"
#import "NSDictionary+Add.h"
#import "MACRO_PORTAL.h"
#import "PortalHelper.h"
#import "NSDictionary+toData.h"


typedef void (^RequestSuccess)(id dataDict, NSString *msg, NSInteger code);
typedef void (^RequestFailure)(NSInteger errorCode, NSString *msg);
typedef void (^RequestProgress)(NSProgress *uploadProgress);



@interface ToolRequest : NSObject
+ (ToolRequest *)sharedInstance;
//- (BOOL)netStaue;
- (void)postJsonWithPath:(NSString *)path
              parameters:(NSMutableDictionary *)parameters
                 success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock;

//更新个人资料
- (void)appuserupdateWithAvtor:(UIImage *)avtor
                      progress:(RequestProgress)progressBlock
                       success:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock;

- (void)appuserupdateWithImages:(NSArray *)Images
                        content:(NSString *)content
                  contactMethod:(NSString *)contactMethod
                       progress:(RequestProgress)progressBlock
                        success:(RequestSuccess)successBlock
                        failure:(RequestFailure)failureBlock;

//- (void)tpurseappappIdApplysuccess:(RequestSuccess)successBlock
//                           failure:(RequestFailure)failureBlock;
//
//- (void)apptokenApplysuccess:(RequestSuccess)successBlock
//                     failure:(RequestFailure)failureBlock;
//
//- (void)URLBASIC_userrefreshLoginWithnisssuccess:(RequestSuccess)successBlock
//                                         failure:(RequestFailure)failureBlock;
@end
