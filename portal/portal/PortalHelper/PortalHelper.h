//
//  PortalHelper.h
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolModeldata.h"
#import "SuPhotoManager.h"

typedef void (^UnLockSuccess)();
typedef void (^UnLockFail)();

typedef void (^photoSHouquanSuccess)();
typedef void (^photoSHouquanFailure)();

@interface PortalHelper : NSObject
@property (nonatomic, assign, getter = isReachable) BOOL reachable;
@property (nonatomic, assign, getter = isInitReachable) BOOL initreachable;

+ (PortalHelper *)sharedInstance;

- (appIdAndSecret *)get_appIdAndSecret;
- (void)set_appIdAndSecret:(appIdAndSecret *)data;

- (HomeDataNew *)get_HomeDataNew;
- (void)set_HomeDataNew:(HomeDataNew *)data;

- (accessToken *)get_accessToken;
- (void)set_accessToken:(accessToken *)data;

- (UserInfo *)get_userInfo;
- (void)set_userInfo:(UserInfo *)data;

- (UserInfoDeatil *)get_userInfoDeatil;
- (void)set_userInfoDeatil:(UserInfoDeatil *)dataDeatil;

- (setUp *)get_setUpWith:(NSString *)phone;
- (void)delete_setUpWith:(NSString *)phone;
- (void)set_setUp:(setUp *)setUpData;

- (GlobalParameter *)get_Globaldata;
- (void)set_Globaldata:(GlobalParameter *)Globaldata;

- (setUpAll *)get_setUpAlldata;
- (void)set_setUpAlldata:(setUpAll *)setUpAlldata;

- (setUpdatePre *)get_setupdatePre;
- (void)set_setupdatePre:(setUpdatePre *)setupdatePre;



- (bankList *)get_bankListdata;
- (void)set_bankListdata:(bankList *)bankListdata;

- (UMdeviceToken *)get_deviceToken;
- (void)set_deviceToken:(UMdeviceToken *)deviceToken;

//@property (nonatomic,strong) GlobalParameter *globalParameter;
//@property (nonatomic,strong) HomeData *homeData;
//@property (nonatomic,strong) UserInfo *userInfo;

//- (void)photoSHouquanOKsuccess:(photoSHouquanSuccess)successBlock failure:(photoSHouquanFailure)failureBlock;
//- (void)photoSHouquan;
//
//- (setUp *)getsetUp;
//- (void)setsetUp:(setUp *)data;

//指纹解锁
- (void)evaluateAuthenticateWith:(UnLockSuccess)succes With:(UnLockFail)Fail;
@end
