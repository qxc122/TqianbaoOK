//
//  PortalHelper.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "PortalHelper.h"
#import "MACRO_PORTAL.h"
#import "XAlertView.h"
#import "HeaderAll.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface PortalHelper ()
@property (nonatomic,strong) appIdAndSecret *appid;
@property (nonatomic,strong) accessToken *token;
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,strong) UserInfoDeatil *userInfoDeatil;
@property (nonatomic,strong) GlobalParameter *Globaldata;
@property (nonatomic,strong) setUpAll *setUpAlldata;
@property (nonatomic,strong) bankList *bankListdata;
@property (nonatomic,strong) UMdeviceToken *deviceToken;
@property (nonatomic,strong) setUpdatePre *setupdatePre;
@property (nonatomic,strong) HomeDataNew *homeDataNew;
@end


@implementation PortalHelper
+ (PortalHelper *)sharedInstance
{
    static PortalHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reachable = NO;
        self.initreachable = NO;
        self.appid = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPIDANDSECRET];
        self.token = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_TOKEN];
        self.Globaldata = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
        self.userInfoDeatil = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HOMEDATA];
        self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_USERINFO];
        self.setUpAlldata = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_SET_UP];
        self.bankListdata = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_BANK_PATH];
        self.deviceToken = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_deviceToken];
        self.setupdatePre = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_timePre];
        self.homeDataNew = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HOMEDATATWO];
    }
    return self;
}

- (setUpdatePre *)get_setupdatePre{
    return self.setupdatePre;
}
- (void)set_setupdatePre:(setUpdatePre *)setupdatePre{
    if (setupdatePre) {
        [NSKeyedArchiver archiveRootObject:setupdatePre toFile:PATH_timePre];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_timePre error:nil];
    }
    self.setupdatePre = setupdatePre;
}


- (accessToken *)get_accessToken{
    return self.token;
//    accessToken *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_TOKEN];
//    return data;
}
- (void)set_accessToken:(accessToken *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_TOKEN];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_TOKEN error:nil];
    }
    self.token = data;
}

- (appIdAndSecret *)get_appIdAndSecret{
    return self.appid;
//    appIdAndSecret *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPIDANDSECRET];
//    return data;
}
- (void)set_appIdAndSecret:(appIdAndSecret *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_APPIDANDSECRET];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_APPIDANDSECRET error:nil];
    }
    self.appid = data;
}

- (UserInfo *)get_userInfo{
    return self.userInfo;
//    UserInfo *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_USERINFO];
//    return data;
}
- (void)set_userInfo:(UserInfo *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_USERINFO];
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:PATH_USERINFO error:nil];
            EMError *error = [[EMClient sharedClient] logout:YES];
            if (!error) {
                NSLog(@"退出成功");
            }
        });
    }
    self.userInfo = data;
}

- (setUpAll *)get_setUpAlldata{
   return self.setUpAlldata;
}
- (void)set_setUpAlldata:(setUpAll *)setUpAlldata{
    if (setUpAlldata) {
        [NSKeyedArchiver archiveRootObject:setUpAlldata toFile:PATH_SET_UP];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_SET_UP error:nil];
    }
    self.setUpAlldata = setUpAlldata;
}


- (UserInfoDeatil *)get_userInfoDeatil{
    return self.userInfoDeatil;
//    UserInfoDeatil *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HOMEDATA];
//    return data;
}

- (void)set_userInfoDeatil:(UserInfoDeatil *)dataDeatil{
    if (dataDeatil) {
        if (self.userInfoDeatil.Arry_list.count) {
            dataDeatil.Arry_list = self.userInfoDeatil.Arry_list;
        }
        [NSKeyedArchiver archiveRootObject:dataDeatil toFile:PATH_HOMEDATA];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_HOMEDATA error:nil];
    }
    self.userInfoDeatil = dataDeatil;
}

- (setUp *)get_setUpWith:(NSString *)phone{
    for (setUp *one in self.setUpAlldata.Arry_all) {
        if ([one.phone isEqualToString:phone]) {
            return one;
            break;
        }
    }
    setUp *tmp = [setUp new];
    tmp.phone = phone;
    tmp.staue = @"1";
    tmp.ScavengingType = @"BAL";
    tmp.GestureCipher = @"0";
    tmp.FingerprintPassword = @"0";
    return tmp;
}
- (void)delete_setUpWith:(NSString *)phone{
    for (setUp *one in self.setUpAlldata.Arry_all) {
        if ([one.phone isEqualToString:phone]) {
            [self.setUpAlldata.Arry_all removeObject:one];
            if (self.setUpAlldata.Arry_all.count) {
                [NSKeyedArchiver archiveRootObject:self.setUpAlldata toFile:PATH_SET_UP];
            } else {
                NSFileManager *manager = [NSFileManager defaultManager];
                [manager removeItemAtPath:PATH_SET_UP error:nil];
            }
            NSLog(@"%@",self.setUpAlldata);
            break;
        }
    }
}
- (void)set_setUp:(setUp *)setUpData{
    if (setUpData) {
        [self.setUpAlldata.Arry_all addObject:setUpData];
        [NSKeyedArchiver archiveRootObject:self.setUpAlldata toFile:PATH_SET_UP];
    }
}
- (HomeDataNew *)get_HomeDataNew{
    return self.homeDataNew;
}
- (void)set_HomeDataNew:(HomeDataNew *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_HOMEDATATWO];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_HOMEDATATWO error:nil];
    }
    self.homeDataNew = data;
}
- (GlobalParameter *)get_Globaldata{
    return self.Globaldata;
//    GlobalParameter *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
//    return data;
}
- (void)set_Globaldata:(GlobalParameter *)Globaldata{
    if (Globaldata) {
        [NSKeyedArchiver archiveRootObject:Globaldata toFile:PATH_APPCOMMONGLOBAL];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_APPCOMMONGLOBAL error:nil];
    }
    self.Globaldata = Globaldata;
}

- (bankList *)get_bankListdata{
    return self.bankListdata;
}
- (void)set_bankListdata:(bankList *)bankListdata{
    if (bankListdata) {
        [NSKeyedArchiver archiveRootObject:bankListdata toFile:PATH_BANK_PATH];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_BANK_PATH error:nil];
    }
    self.bankListdata = bankListdata;
}

- (UMdeviceToken *)get_deviceToken{
    return self.deviceToken;
}
- (void)set_deviceToken:(UMdeviceToken *)deviceToken{
    if (deviceToken) {
        [NSKeyedArchiver archiveRootObject:deviceToken toFile:PATH_deviceToken];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_deviceToken error:nil];
    }
    self.deviceToken = deviceToken;
}

//- (void)setAppid:(appIdAndSecret *)appid{
//    _appid = appid;
//    [NSKeyedArchiver archiveRootObject:appid toFile:PATH_APPIDANDSECRET];
//}
//- (void)setToken:(accessToken *)token{
//    _token = token;
//    [NSKeyedArchiver archiveRootObject:token toFile:PATH_TOKEN];
//}
//- (void)setGlobalParameter:(GlobalParameter *)globalParameter{
//    _globalParameter = globalParameter;
//    [NSKeyedArchiver archiveRootObject:globalParameter toFile:PATH_APPCOMMONGLOBAL];
//}
//
//- (void)setHomeData:(HomeData *)homeData{
//    _homeData = homeData;
//    [NSKeyedArchiver archiveRootObject:homeData toFile:PATH_HOMEDATA];
//}

//
//- (void)photoSHouquanOKsuccess:(photoSHouquanSuccess)successBlock failure:(photoSHouquanFailure)failureBlock{
//    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
//    if (authoriation == PHAuthorizationStatusNotDetermined) {
//        kWeakSelf(self);
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            //这里非主线程，选择完成后会出发相册变化代理方法
//            if (status == PHAuthorizationStatusAuthorized) {
//                successBlock();
//            } else {
//                [weakself SetWithfailure:failureBlock];
//            }
//        }];
//    }else if (authoriation == PHAuthorizationStatusAuthorized) {
//        successBlock();
//    }else {
//        [self SetWithfailure:failureBlock];
//    }
//}
//
//- (void)SetWithfailure:(photoSHouquanFailure)failureBlock{
//    XAlertView *tmp = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"Cannot preview pictures", @"Cannot preview pictures") message:NSLocalizedString(@"The application has no access to photo permissions", @"The application has no access to photo permissions") clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
//        if (canceled) {
//            failureBlock();
//        } else {
//            // 去设置权限
//            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//            if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        }
//    } cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel") otherButtonTitles:NSLocalizedString(@"Go setup", @"Go setup"), nil];
//    [tmp show];
//}
//
//- (void)photoSHouquan{
//    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
//    if (authoriation == PHAuthorizationStatusNotDetermined) {
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            //这里非主线程，选择完成后会出发相册变化代理方法
//        }];
//    }
//}

//- (setUp *)getsetUp{
//    setUp *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_SET_UP];
//    if (!data) {
//        data = [setUp new];
//        data.ReceiveNotification = YES;
//        data.ReceiveNotification = YES;
//        [NSKeyedArchiver archiveRootObject:data toFile:PATH_SET_UP];
//    }
//    return data;
//}
//- (void)setsetUp:(setUp *)data{
//    if (data) {
//        [NSKeyedArchiver archiveRootObject:data toFile:PATH_SET_UP];
//    }else{
//        NSFileManager *manager = [NSFileManager defaultManager];
//        [manager removeItemAtPath:PATH_SET_UP error:nil];
//    }
//}
- (setUpAll *)setUpAlldata{
    if (!_setUpAlldata) {
        _setUpAlldata = [setUpAll new];
        _setUpAlldata.Arry_all = [NSMutableArray array];
        _setUpAlldata.Arry_allPhone = [NSMutableArray array];
    }
    return _setUpAlldata;
}

//指纹解锁
- (void)evaluateAuthenticateWith:(UnLockSuccess)succes With:(UnLockFail)Fail
{
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    context.localizedFallbackTitle = @"";
    NSString* result = @"请验证已有指纹";
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (success) {
                    if (succes) {
                        succes();
                    }
                }else{
                    if (Fail) {
                        Fail(error.code);
                    }
                }
            }];
        }];
    }else{
        [MBProgressHUD showPrompt:@"指纹暂时不可用"];
    }
}
@end
