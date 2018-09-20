//
//  AppDelegate.m
//  portal
//
//  Created by Store on 2017/8/30.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AppDelegate.h"
#import "HeaderAll.h"
#import "MACRO_PIC.h"
#import "MACRO_PORTAL.h"
#import "UIColor+Add.h"
//#import "AppDelegate+Umeng.h"
#import "THIRD_PARTY.h"
#import "LaunchIntroductionView.h"
#import "AppTools.h"
#import "applyAuthCodeVc.h"
#import "GesturecipherVc.h"
#import "YHGesturePasswordView.h"
#import "payTwoVc.h"
#import "PaymentcodeVc.h"
#import "teachingPage.h"
#import "SignInVc.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "NSDate+DateTools.h"
#import "AppDelegate+EaseMob.h"
#import "ChatDemoHelper.h"
//#import "appidVc.h"
#import "MaldivesPayVc.h"
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>        // 统计组件
//#import <UMShare/UMShare.h>    // 分享组件
#import <UMPush/UMessage.h>             // Push组件
#import <UserNotifications/UserNotifications.h>  // Push组件必须的系统库



@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property (nonatomic,weak) LaunchIntroductionView *bootPage;
@property (nonatomic,assign) BOOL isbefore;  //从后台进来的
@end

@implementation AppDelegate
- (void)setMainddd{
    self.MainVc = [[mainTableVc alloc] init];
    UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:self.MainVc];
    self.window.rootViewController = nnvc;
    [self.window makeKeyAndVisible];
    
//    [nnvc pushViewController:[payTwoVc new] animated:YES];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //        1.创建网络状态监测管理者
    self.isbefore = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    
    [self setMainddd];
    
//    [self setupUMeng];
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions appkey:EaseMobAppKey apnsCertName:EaseMobapnsCertName otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    if ([PHONEVERSION floatValue] >= 7.0) {
        [[UINavigationBar appearance] setBackgroundImage:[ColorWithHex(0x1E2E47, 1.0) imageWithColor] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[ColorWithHex(0x1E2E47, 1.0) imageWithColor]];
    }
//    [self setNotificationWithOptions:launchOptions];

    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    //    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self setUM:launchOptions];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startOKFUNC:)
                                                 name:@"startOK"
                                               object:nil];
    return YES;
}

- (void)setUM:(NSDictionary *)launchOptions{
    [UMConfigure initWithAppkey:UmengPushAppKey channel:@"App Store"];
    /* appkey: 开发者在友盟后台申请的应用获得（可在统计后台的 “统计分析->设置->应用信息” 页面查看）*/
    
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    // [MobClick setScenarioType:E_UM_GAME];  // optional: 游戏场景设置
    
    // Push组件基本功能配置
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标等
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 用户选择了接收Push消息
        }else{
            // 用户拒绝接收Push消息
        }
    }];
    [UMessage setAutoAlert:NO];
}

- (void)startOKFUNC:(NSNotification *)user{
    [self BootPage];
    [self setGesturecipherVc];
}

#pragma --mark<添加教学页>
//- (void)AddTeachingPage{
//    teachingPage *page = [teachingPage new];
//    [page windosViewshow];
//}
- (void)BootPage{
//    kWeakSelf(self);
    [AppTools onFirstStart:^(BOOL isFirstStart) {
        if (isFirstStart) {
//            [weakself AddTeachingPage];
            LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:@[@"launch0",@"launch1",@"launch2",@"launch3"] buttonImage:IMMEDIATE_EXPERIENCE_BTN buttonFrame:CGRectMake(kScreen_width/2 - 90/2, kScreen_height - 40-50, 90, 40) skipbuttonImage:SKIP_BTN skipbuttonFrame:CGRectMake(kScreen_width - 45-15, 51, 45, 25)];
            launch.currentColor = ColorWithHex(0x57A1ED, 1.0);
            launch.nomalColor = ColorWithHex(0x57A1ED, 0.2);
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //    minutesLaterThan
    //    if ([vc isKindOfClass:[payTwoVc class]] || [vc isKindOfClass:[applyAuthCodeVc class]]) {
    //        [self.MainVc.navigationController popViewControllerAnimated:NO];
    //    }
    
    
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        UIViewController *vc = self.MainVc.navigationController.topViewController;
        if (![vc isKindOfClass:[SignInVc class]] && ![vc isKindOfClass:[GesturecipherVc class]]) {
            setUpdatePre * tmp = [setUpdatePre new];
            tmp.datePre = [NSDate date];
            [[PortalHelper sharedInstance]set_setupdatePre:tmp];
#ifdef  DEBUG
            NSString *str2 = [[[PortalHelper sharedInstance]get_setupdatePre].datePre formattedDateWithFormat:@"YYYY-MM-dd hh:mm:ss"];
            NSLog(@"str2=%@",str2);
            NSLog(@"str2=%@",str2);
#endif
        }
    }
    //    for (UIViewController *vc in self.MainVc.navigationController.childViewControllers) {
    //        if ([vc isKindOfClass:[payTwoVc class]] || [vc isKindOfClass:[applyAuthCodeVc class]]) {
    //            [self.MainVc.navigationController popViewControllerAnimated:NO];
    //            return;
    //        }
    //    }
    self.isbefore = NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    self.isbefore = YES;
    [self setGesturecipherVc];
}

- (void)setGesturecipherVc{
    CGFloat tmp = 5.0*60;
#ifdef DEBUG
    NSString *str1 = [[NSDate date] formattedDateWithFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *str2 = [[[PortalHelper sharedInstance]get_setupdatePre].datePre formattedDateWithFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    long str3 = [NSDate date].second;
    long str4 = [[PortalHelper sharedInstance]get_setupdatePre].datePre.second;
    
    double str5 =  [[NSDate date] secondsFrom:[[PortalHelper sharedInstance]get_setupdatePre].datePre];
    
    //    NSLog(@"1==%@  2=%@   3=%ld 4=%ld %f",str1,str2,str3,str4,str5);
    //    CGFloat tmp2 = [[NSDate date]secondsLaterThan:[[PortalHelper sharedInstance]get_setupdatePre].datePre];
    //    tmp = 0.1*60;
#endif
    if ([[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1] || [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].GestureCipherStr) {
        
        if ([[PortalHelper sharedInstance]get_userInfo] && [[PortalHelper sharedInstance]get_setupdatePre] && [[NSDate date]secondsLaterThan:[[PortalHelper sharedInstance]get_setupdatePre].datePre] >=tmp) {
            if ( [[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1]) {
                
                SignInVc *losgin = [[SignInVc alloc]init];
                losgin.isUnlock = YES;
                [self.MainVc.navigationController pushViewController:losgin animated:NO];
                kWeakSelf(self);
                [[PortalHelper sharedInstance] evaluateAuthenticateWith:^{
                    [weakself.MainVc.navigationController popToRootViewControllerAnimated:NO];
                } With:^{
                    [MBProgressHUD showPrompt:@"请使用手机号登录"];
                }];
            }else if ( [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].GestureCipherStr) {
                GesturecipherVc *vc = self.MainVc.navigationController.topViewController;
                if (![vc isKindOfClass:[GesturecipherVc class]] || vc.state != GestureResultPassword) {
                    GesturecipherVc *vc = [GesturecipherVc new];
                    vc.state = GestureResultPassword;
                    [self.MainVc.navigationController pushViewController:vc animated:NO];
                }
            } else {
                if ([[PortalHelper sharedInstance] get_userInfo]) {
                    [[PortalHelper sharedInstance]set_userInfo:nil];
                    [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
                    NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
                
                SignInVc *losgin = [[SignInVc alloc]init];
                losgin.isUnlock = YES;
                [self.MainVc.navigationController pushViewController:losgin animated:NO];
            }
        }
    }
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    BOOL result = NO;
    if (!result) {
        // 其他如支付等SDK的回调
        result = [self Tpay:url];
    }
    if (!result) {
        // 其他如支付等SDK的回调
        result = [self TAuth:url]; //OAAuth
    }
    if (!result) {
        // 其他如支付等SDK的回调
        result = [self TOAPay:url]; //OAPay
    }
    return result;
}

- (BOOL)TOAPay:(NSURL *)url{  //T钱包授权
    BOOL tmp;
    if ([[url absoluteString] hasPrefix:@"TwalletPay"]) {
        
        //        hSysId:(NSString *)sysId Sign:(NSString *)sign Timestamp:(NSString *)timestamp V:(NSString *)v OrderId:(NSString *)orderId  completion:(WalletManagerblock)block{
        
        NSString *json = [url.absoluteString stringByReplacingOccurrencesOfString:@"TwalletPay://" withString:@""];
        NSRange range = [json rangeOfString:@"/"];
        NSString *sysId = [json substringWithRange:NSMakeRange(0, range.location)];
        
        json = [json substringFromIndex:range.location+range.length];
        range = [json rangeOfString:@"/"];
        NSString *sign = [json substringWithRange:NSMakeRange(0, range.location)];
        
        json = [json substringFromIndex:range.location+range.length];
        range = [json rangeOfString:@"/"];
        NSString *timestamp = [json substringWithRange:NSMakeRange(0, range.location)];
        
        json = [json substringFromIndex:range.location+range.length];
        range = [json rangeOfString:@"/"];
        NSString *v = [json substringWithRange:NSMakeRange(0, range.location)];
        
        json = [json substringFromIndex:range.location+range.length];
        NSString *orderId = @"";
        if (json.length) {
            orderId = json;
        }
        
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              sysId, @"sysId",
                              sign, @"sign",
                              timestamp, @"timestamp",
                              v, @"v",
                              orderId, @"orderId",nil];
        
        
//        for (UIViewController *vc in self.MainVc.navigationController.childViewControllers) {
//            if ([vc isKindOfClass:[payTwoVc class]] || [vc isKindOfClass:[applyAuthCodeVc class]]) {
//                break;
//            }
//        }
        [self.MainVc.navigationController popToRootViewControllerAnimated:NO];
        
        payTwoVc *Paymentcodevc = [payTwoVc new];
        Paymentcodevc.isOA = YES;
        Paymentcodevc.payIdForOA = data;
        [self.MainVc.navigationController pushViewController:Paymentcodevc animated:NO];
        return YES;
    }else{
        tmp = NO;
    }
    return  tmp;
}

- (BOOL)TAuth:(NSURL *)url{  //T钱包授权
    BOOL tmp;
    if ([[url absoluteString] hasPrefix:@"TwalletAuth"]) {
//        for (UIViewController *vc in self.MainVc.navigationController.childViewControllers) {
//            if ([vc isKindOfClass:[payTwoVc class]] || [vc isKindOfClass:[applyAuthCodeVc class]]) {
//                break;
//            }
//        }
        [self.MainVc.navigationController popToRootViewControllerAnimated:NO];
        
        UINavigationController *tmp = (UINavigationController *)self.window.rootViewController;
        if ([tmp isKindOfClass:[UINavigationController class]]) {
            [tmp pushViewController:[applyAuthCodeVc new] animated:NO];
        }
        return YES;
    }else{
        tmp = NO;
    }
    return  tmp;
}

- (BOOL)Tpay:(NSURL *)url{  //T钱包支付
    if ([[url absoluteString] hasPrefix:@"togetherTPay"] || [[url absoluteString] hasPrefix:@"testwalletTbi"]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSData *imageData = [pasteboard dataForPasteboardType:@"data"];
        if (imageData==nil) {
            return NO;
        }
        NSDictionary *data = [self returnDictionaryWithDataPath:imageData];
        [UIPasteboard removePasteboardWithName:@"data"];
        
        [self.MainVc.navigationController popToRootViewControllerAnimated:NO];
        
        payTwoVc *Paymentcodevc = [payTwoVc new];
        Paymentcodevc.pasteboarddata = data;
        [self.MainVc.navigationController pushViewController:Paymentcodevc animated:NO];
        
        return YES;
    }else if ([[url absoluteString] hasPrefix:@"ThirdPartyPay"]) {
        NSString *resUrl = [url absoluteString];
        resUrl = [resUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [self.MainVc.navigationController popToRootViewControllerAnimated:NO];
        
        payTwoVc *Paymentcodevc = [payTwoVc new];
        Paymentcodevc.pasteboarddata = [resUrl getURLParametersFromUrl];
        [self.MainVc.navigationController pushViewController:Paymentcodevc animated:NO];
        return YES;
    }
    return  NO;
}

-(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data
{
    //  NSData* data = [[NSMutableData alloc]initWithContentsOfFile:path]; 拿路径文件
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return myDictionary;
}


//- (void)setNotificationWithOptions:(NSDictionary *)launchOptions{
//    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
//
//    [UMessage startWithAppkey:UmengPushAppKey launchOptions:launchOptions];
//    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
//    [UMessage registerForRemoteNotifications];
//
//    //iOS10必须加下面这段代码。
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate=self;
//    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
//    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted) {
//            //点击允许
//            //这里可以添加一些自己的逻辑
//        } else {
//            //点击不允许
//            //这里可以添加一些自己的逻辑
//        }
//    }];
//    //打开日志，方便调试
//#ifdef DEBUG
//    [UMessage setLogEnabled:YES];
//#endif
//
//
//#ifdef DEBUG
//    [UMessage setChannel:@"App Test"];
//#else
//    [UMessage setChannel:@"App Store"];
//#endif
//    //关闭U-Push自带的弹出框
//    [UMessage setAutoAlert:NO];
//
//}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"%@",deviceToken.description);
    
    NSString *DeviceToken = deviceToken.description;
    DeviceToken = [DeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    DeviceToken = [DeviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    DeviceToken = [DeviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    //    NSString *DeviceToken = [[NSString alloc]initWithData:deviceToken encoding:NSUTF8StringEncoding];
    UMdeviceToken *token = [UMdeviceToken new];
    token.deviceToken = DeviceToken;
    [[PortalHelper sharedInstance] set_deviceToken:token];
    //下面这句代码只是在demo中，供页面传值使用。
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        [self setuserInfo:userInfo Isbefore:YES];
    }else{
        [self setuserInfo:userInfo  Isbefore:NO];
    }
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}

- (void)setuserInfo:(NSDictionary *)userInfo Isbefore:(BOOL)Isbefore{ //前台
    if ([[PortalHelper sharedInstance]get_userInfo]) {
//        noticationData *data = [noticationData mj_objectWithKeyValues:userInfo];
        
//        NSMutableArray *tmpArry = [self.MainVc.navigationController.viewControllers mutableCopy];
//        BOOL  ishabeJIE = NO;
//        PaymentcodeVc *Paymentcodevc;
//        if (Isbefore) {
//            if ([self.MainVc.navigationController.topViewController isKindOfClass:[PaymentcodeVc class]]) {
//                Paymentcodevc = (PaymentcodeVc *)self.MainVc.navigationController.topViewController;
//                Paymentcodevc.noticationdata = data;
//            }else{
//                //                Paymentcodevc = [PaymentcodeVc new];
//                //                Paymentcodevc.noticationdata = data;
//                //                [self.MainVc.navigationController pushViewController:Paymentcodevc animated:YES];
//            }
//        }
        MaldivesPayVc *Paymentcodevc;
        if ([self.MainVc.navigationController.topViewController isKindOfClass:[MaldivesPayVc class]]) {
            Paymentcodevc = (MaldivesPayVc *)self.MainVc.navigationController.topViewController;
            MaldivesPush *tmpAll = [MaldivesPush mj_objectWithKeyValues:userInfo];
            MaldivesPushcontent *tmp = [MaldivesPushcontent mj_objectWithKeyValues:userInfo[@"content"]];
            tmpAll.conten = tmp;
            Paymentcodevc.noticationdata = tmpAll;
        }
    }
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self setuserInfo:userInfo  Isbefore:YES];
    }else{
        
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self setuserInfo:userInfo Isbefore:NO];
    }else{
        
        //应用处于后台时的本地推送接受
    }
}
@end

