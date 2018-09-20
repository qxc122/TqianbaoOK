//
//  mainTableVc.m
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "mainTableVc.h"
#import "homeVc.h"
#import "manageMoneyVc.h"
#import "mineVc.h"
#import "SignInVc.h"
#import "homeTwoVc.h"
#import "LeadMoneyActivities.h"
#import "AppTools.h"
#import "RealNameVc.h"
#import "noneNetForH5.h"
#define TITLEHEADONE @"T钱包"
#define TITLEHEADTWO @"理财"
#define TITLEHEADTHREE @"我的"


#define TITLEFOOTONE @"T钱包"
#define TITLEFOOTTWO @"理财"
#define TITLEFOOTTHREE @"我的"


#define IMAGE_ONE_DEFAULT   PIC_HOME_PAGE_NOT_SELECTED
#define IMAGE_ONE_SELECT    PIC_T_WALLET
#define IMAGE_TWO_DEFAULT   PIC_CONDUCT_FINANCIAL_TRANSACTIONSHOME
#define IMAGE_TWO_SELECT    PIC_FINANCIAL_SELECTION
#define IMAGE_THREE_DEFAULT  PIC_I_WASN_T_SELECTED
#define IMAGE_THREE_SELECT    PIC_MY_CHOICE

@interface mainTableVc ()<UITabBarControllerDelegate>
@property (nonatomic,strong) UserInfoDeatil *userData;

@property (nonatomic,strong) homeTwoVc *homePagevc;
@property (nonatomic,strong) mineVc *minevc;

@property (nonatomic,weak) LeadMoneyActivities *Activitiesview;
@property (nonatomic,strong) CheckApp *data;

@property (nonatomic,assign) BOOL netStaue;
@end

@implementation mainTableVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate =self;
    self.netStaue = [PortalHelper sharedInstance].reachable;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(LOGIN_EXIT_NOTIFICATIONFunC:)
                                                 name:LOGIN_EXIT_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotolicai_NOTIFICATIONFunC:)
                                                 name:gotolicai_NOTIFICATION
                                               object:nil];
    
    
    if (![[PortalHelper sharedInstance]get_Globaldata]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(GET_NEW_TOKEN_NOTIFICATIONFunc:)
                                                     name:GET_NEW_TOKEN_NOTIFICATION
                                                   object:nil];
    } else {
        [self setVc];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moneyyyyyyFunc:) name:@"moneyyyyyy" object:nil];
    
    //        1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //        开启监听，记得开启，不然不走block
    //        2.监听改变
    kWeakSelf(self);
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"status=%ld 网络状态",status);
        [PortalHelper sharedInstance].initreachable = YES;
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [PortalHelper sharedInstance].reachable = YES;
        }else{
            [PortalHelper sharedInstance].reachable = NO;
        }
        if (!weakself.netStaue && [PortalHelper sharedInstance].reachable) {
            NSNotification *notification =[NSNotification notificationWithName:NETWORK_FROM_CONNECTION_TO_CONNECTION_NOTIFICATION object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        weakself.netStaue = [PortalHelper sharedInstance].reachable;
    }];
    [manger startMonitoring];
    
    [self checkAppVer];
}
- (void)setVc{
    self.fd_prefersNavigationBarHidden = YES;
    homeTwoVc *homePagevc = [[homeTwoVc alloc]init];
    self.homePagevc = homePagevc;
    homePagevc.title = TITLEHEADONE;
    UINavigationController *navhomePagevc = [[UINavigationController alloc] initWithRootViewController:homePagevc];
    
    
    manageMoneyVc *manageMoneyvc = [[manageMoneyVc alloc]init];
    manageMoneyvc.title = TITLEHEADTWO;
    UINavigationController *navmanageMoneyvc = [[UINavigationController alloc] initWithRootViewController:manageMoneyvc];
    
    
    mineVc *minevc = [[mineVc alloc]init];
    self.minevc = minevc;
    minevc.title = TITLEHEADTHREE;
    UINavigationController *navminevc = [[UINavigationController alloc] initWithRootViewController:minevc];
    
    
    UIImage * normalImage1 = [[UIImage imageNamed:IMAGE_ONE_DEFAULT] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage1 = [[UIImage imageNamed:IMAGE_ONE_SELECT] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navhomePagevc.tabBarItem = [[UITabBarItem alloc] initWithTitle:TITLEFOOTONE image:normalImage1 selectedImage:selectImage1];
    
    //    nav1.tabBarItem.imageInsets = UIEdgeInsetsMake(0,0,0,0);
    //    [nav1.tabBarItem setTitlePositionAdjustment: UIOffsetMake(0,0)];
    
    UIImage * normalImage2 = [[UIImage imageNamed:IMAGE_TWO_DEFAULT] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage2 = [[UIImage imageNamed:IMAGE_TWO_SELECT] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navmanageMoneyvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:TITLEFOOTTWO image:normalImage2 selectedImage:selectImage2];
    navmanageMoneyvc.title = TITLEFOOTTWO;
    
    UIImage * normalImage3 = [[UIImage imageNamed:IMAGE_THREE_DEFAULT] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage3 = [[UIImage imageNamed:IMAGE_THREE_SELECT] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navminevc.tabBarItem = [[UITabBarItem alloc] initWithTitle:TITLEFOOTTHREE image:normalImage3 selectedImage:selectImage3];
    
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        self.minevc.userData = self.userData;
        self.homePagevc.userData = self.userData;
    }
    
    //    self.viewControllers = [NSArray arrayWithObjects:navhomePagevc,navminevc, nil];
    if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
        self.viewControllers = [NSArray arrayWithObjects:navhomePagevc,navminevc, nil];
    }else{
        self.viewControllers = [NSArray arrayWithObjects:navhomePagevc,navmanageMoneyvc,navminevc, nil];
    }
    
    self.tabBar.backgroundImage = [ColorWithHex(0x1E2E47,1.0) imageWithColor];
    [self.tabBar setTintColor:ColorWithHex(0xE3BF7C, 1.0)];
    if (@available(iOS 11.0, *)) {
        [self.tabBar setUnselectedItemTintColor:ColorWithHex(0xE3BF7C, 1.0)];
    }else if (@available(iOS 10.0, *)) {
        [self.tabBar setUnselectedItemTintColor:ColorWithHex(0xE3BF7C, 1.0)];
    }
    
}
- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]appgetGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        GlobalParameter *Globaldata = [GlobalParameter mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance] set_Globaldata:Globaldata];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself setVc];
        [weakself setLingqu];
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"msg");
        [weakself GET_NEW_TOKEN_NOTIFICATIONFunc:nil];
    }];
}

- (void)setLingqu{
    if ([self.navigationController.topViewController isEqual:self]) {
        kWeakSelf(self);
        [AppTools onFirstStart:^(BOOL isFirstStart) {
            if (isFirstStart) {
                LeadMoneyActivities *Activitiesview = [LeadMoneyActivities new];
                weakself.Activitiesview = Activitiesview;
                Activitiesview.ActivitiespngdoneClick = ^{
                    if ([[PortalHelper sharedInstance]get_userInfo]) {
                        [weakself loginDoing];
                    } else {
                        [weakself.Activitiesview closeClisck];
                        if (![weakself.navigationController.topViewController isKindOfClass:[SignInVc class]]){
                            SignInVc *losgin = [[SignInVc alloc]init];
                            losgin.block = ^{
                                [weakself loginDoing];
                            };
                            [weakself.navigationController pushViewController:losgin animated:YES];
                        }
                    }
                };
                [Activitiesview windosViewshow];
            }
        }];
    }
}

#pragma --mark< 检查更新 >
- (void)checkAppVer{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_appappUpdatesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.data = [CheckApp mj_objectWithKeyValues:dataDict];
        [weakself shoAlertWith:weakself.data];
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"检查更新失败：%@",msg);
    }];
}
- (void)shoAlertWith:(CheckApp *)data{
    if ([data.updateType isEqualToString:@"1"] || [data.updateType isEqualToString:@"2"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:self.data.updateInfo preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"去升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:PORTALAPPID];
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
        }]];
        if ([self.data.updateType isEqualToString:@"1"]) { //1 建议
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            self.data = nil;
        }
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (UserInfoDeatil *)userData{
    if (!_userData) {
        _userData = [[PortalHelper sharedInstance]get_userInfoDeatil];
    }
    return _userData;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSLog(@"%s",__FUNCTION__);
    [self LoadData];
    if (self.data) {
        [self shoAlertWith:self.data];
    }
    //    //        1.创建网络状态监测管理者
    //    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //    //        开启监听，记得开启，不然不走block
    //    [manger startMonitoring];
    //    //        2.监听改变
    //    kWeakSelf(self);
    //    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //        if (status != AFNetworkReachabilityStatusReachableViaWWAN && status != AFNetworkReachabilityStatusReachableViaWiFi) {
    //            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请检查您的网络设置" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //            }]];
    //            [weakself presentViewController:alert animated:YES completion:nil];
    //        }
    //    }];
}

- (void)moneyyyyyyFunc:(NSNotification *)user{
    if ([self.navigationController.topViewController isEqual:self]) {
        //        kWeakSelf(self);
        //        [AppTools onFirstStart:^(BOOL isFirstStart) {
        //            if (isFirstStart) {
        LeadMoneyActivities *Activitiesview = [LeadMoneyActivities new];
        self.Activitiesview = Activitiesview;
        Activitiesview.ActivitiespngdoneClick = ^{
            if ([[PortalHelper sharedInstance]get_userInfo]) {
                [self loginDoing];
            } else {
                [self.Activitiesview closeClisck];
                if (![self.navigationController.topViewController isKindOfClass:[SignInVc class]]){
                    SignInVc *losgin = [[SignInVc alloc]init];
                    losgin.block = ^{
                        [self loginDoing];
                    };
                    [self.navigationController pushViewController:losgin animated:YES];
                }
            }
        };
        [Activitiesview windosViewshow];
        //            }
        //        }];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loginDoing{
    if ([[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:@"1"]) {
        if ([[[PortalHelper sharedInstance]get_userInfoDeatil].mynewUserFlag isEqualToString:@"1"]) {
            if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"0"]) {
                [self Receivenewuserfinancialmoney];
            }else if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"1"]) {
                [MBProgressHUD showPrompt:@"您已经领取" toView:self.Activitiesview];
            }
        }else{
            [MBProgressHUD showPrompt:@"只针对新用户开放，快邀请好友参与吧！" toView:self.Activitiesview];
        }
    } else {
        [self.Activitiesview closeClisck];
        if (![self.navigationController.topViewController isKindOfClass:[RealNameVc class]]){
            RealNameVc *losgin = [[RealNameVc alloc]init];
            kWeakSelf(self);
            losgin.block = ^{
                [weakself Receivenewuserfinancialmoney];
            };
            [self.navigationController pushViewController:losgin animated:YES];
        }
    }
}

- (void)Receivenewuserfinancialmoney{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:@"领取中..." toView:self.Activitiesview];
    [[ToolRequest sharedInstance]URLBASIC_userreceiveExpMoneysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [weakself.Activitiesview closeClisck];
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:@"领取成功" toView:weakself.view];
        UserInfoDeatil *tmp = [[PortalHelper sharedInstance]get_userInfoDeatil];
        tmp.receiveExpMoneyFlag = @"1";
        [[PortalHelper sharedInstance]set_userInfoDeatil:tmp];
        
        //刷新首页数据
        NSNotification *notification =[NSNotification notificationWithName:@"loadNewData" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}

- (void)ReceivenewuserfinancialmoneySuccess:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"体验金领取成功！" message:[NSString stringWithFormat:@"收益7天后（%@）到账，可至零钱页面免费提现哦~",msg] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    NSLog(@"%s",__FUNCTION__);
//}


#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    [self LoadDataWithNSNotification];
}
#pragma --mark<登录退出的通知>
- (void)gotolicai_NOTIFICATIONFunC:(NSNotification *)user{
    if ([PortalHelper sharedInstance].isReachable) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.selectedIndex = 1;
    } else {
        [self.navigationController pushViewController:[noneNetForH5 new] animated:NO];
    }
}

- (void)LoadDataWithNSNotification{
    if (![[PortalHelper sharedInstance]get_userInfo]) {
        self.minevc.userData = nil;
        self.homePagevc.userData = nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)LoadData{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_tpurseusermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.userData = [UserInfoDeatil mj_objectWithKeyValues:dataDict];
            [[PortalHelper sharedInstance] set_userInfoDeatil:weakself.userData];
            weakself.minevc.userData = weakself.userData;
            weakself.homePagevc.userData = weakself.userData;
            //            if ([weakself.userData.expMoneyIncomeFlag isEqualToString:@"1"]) {
            //                [weakself Experiencegoldreminding];
            //            }
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            NSLog(@"strTmp=%@",msg);
        }];
    }else{
        self.minevc.userData = nil;
        self.homePagevc.userData = nil;
    }
}

- (void)Experiencegoldreminding{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您在平台领取的888元体验金收益到账啦~收益共计1.70元，快来查看吧！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself Experiencegoldincometoaccountremindercompletion];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//体验金收益到账提醒完成
- (void)Experiencegoldincometoaccountremindercompletion{
    [[ToolRequest sharedInstance]URLBASIC_userfinishExpMoneyIncomesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        NSLog(@"体验金收益到账提醒完成");
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"体验金收益到账提醒完成 失败");
    }];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (![PortalHelper sharedInstance].isReachable && [viewController.title isEqualToString:@"理财"]) {
        [self.navigationController pushViewController:[noneNetForH5 new] animated:NO];
        return NO;
    } else {
        return YES;
    }
}
@end
