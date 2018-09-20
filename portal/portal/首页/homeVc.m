//
//  homeVc.m
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "homeVc.h"
#import "homeTopCell.h"
#import "homeBottomCell.h"
#import "RechargeandcashwithdrawalVc.h"
#import "AirTicketsAndBankCardsShow.h"
#import "popSelecetView.h"
#import "MOTMutablePopView.h"
#import "consumptionVc.h"
#import "OpenScancodepaymentVc.h"
#import "AddBankCardVc.h"
#import "ScancodepaymentVc.h"
#import "PaymentcodeVc.h"
#import "RealNameVc.h"
#import "Myfinancialmanagement.h"
#import "RechargeVc.h"
#import "WithdrawCashVc.h"
#import "MyBorrowList.h"
@interface homeVc ()
@property (weak, nonatomic) UIView *targetView;

@property (strong, nonatomic) CheckApp *data;
@property (weak, nonatomic) popSelecetView *popselecetView;
@end

@implementation homeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userData = [[PortalHelper sharedInstance]get_userInfoDeatil];
    self.registerClasss = @[[homeTopCell class],[homeBottomCell class]];
    self.fd_prefersNavigationBarHidden = YES;

    self.view.backgroundColor = COLOUR_BACK_NORMAL;

    [self appgetGlobalParamssuccess:nil];
    [self loadBankList:nil failure:nil];
    [self checkAppVer];

    if (![[PortalHelper sharedInstance] get_userInfo] || self.userData) {
        
        self.empty_type = succes_empty_num;
        [self.tableView reloadData];
        if (self.userData) {
            [self LoadList];
        }
        [self.tableView reloadData];
        if (self.userData) {
            self.header.hidden = NO;
        }else{
            self.header.hidden = YES;
        }
    }else{
        self.header.hidden = NO;
        self.empty_type = In_loading_empty_num;
        [self.header beginRefreshing];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadNewDataFucnC:)
                                                 name:@"loadNewData"
                                               object:nil];
}
- (void)loadNewDataFucnC:(NSNotification *)user{
    [self loadNewData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    self.userDataList = nil;
    if ([[PortalHelper sharedInstance] get_userInfo]) {
//        self.header.hidden = NO;
//        [self.header beginRefreshing];
        self.isNeedRefreth = YES;
    }
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    if (self.header.isRefreshing) {
        [self.header endRefreshing];
    }
    if (self.userData && self.userDataList.Arry_list) {
        self.userData.Arry_list = self.userDataList.Arry_list;
    }
    [self.tableView reloadData];
}
- (void)loadNewData{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_tpurseusermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.userData = [UserInfoDeatil mj_objectWithKeyValues:dataDict];
            if (weakself.userDataList.Arry_list) {
                weakself.userData.Arry_list = weakself.userDataList.Arry_list;
            }
            [[PortalHelper sharedInstance] set_userInfoDeatil:weakself.userData];
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
            [weakself LoadList];
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
            weakself.header.hidden = NO;
        } failure:^(NSInteger errorCode, NSString *msg) {
            if (!weakself.userData) {
                [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
            }
        }];
    } else {
        self.header.hidden = YES;
        self.userData = nil;
        self.empty_type = succes_empty_num;
        [self.tableView reloadData];
    }
}
- (void)LoadList{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpurseusermyCardInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.userDataList = [UserInfoDeatil mj_objectWithKeyValues:dataDict];
//        if (!weakself.userData.Arry_list.count) {
            weakself.userData.Arry_list = weakself.userDataList.Arry_list;
            [[PortalHelper sharedInstance] set_userInfoDeatil:weakself.userData];
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
//        }
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        weakself.header.hidden = NO;
    } failure:^(NSInteger errorCode, NSString *msg) {
        if (!self.userDataList.Arry_list.count) {
            [weakself performSelector:@selector(LoadList) withObject:nil afterDelay:1];
        }
    }];
}

- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
    [self appgetGlobalParamssuccess:nil];
    [self loadBankList:nil failure:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        homeTopCell *cell = [homeTopCell returnCellWith:tableView];
        [self configurehomeTopCell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        homeBottomCell *cell = [homeBottomCell returnCellWith:tableView];
        [self configurehomeBottomCell:cell atIndexPath:indexPath];
        return  cell;
    }
}
#pragma --mark< 配置homeTopCell 的数据>
- (void)configurehomeTopCell:(homeTopCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf(self);
    cell.userData = self.userData;
    cell.ClicBtnTag = ^(homeTopCellType type) {
        NSLog(@"%s %d",__FUNCTION__,type);
        if (type == homeTopCellType_Immediate_investment) {
            NSNotification *notification =[NSNotification notificationWithName:gotolicai_NOTIFICATION object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }else{
            UIViewController *vc;
            if ([[PortalHelper sharedInstance]get_userInfo]) {
                if (type == homeTopCellType_Recharge || type == homeTopCellType_WithdrawCash) {
                    //                [MBProgressHUD showPrompt:@"请先进行实名认证"];
                    //                RealNameVc *tmp =[RealNameVc new];
                    //                vc = tmp;
                    //                if (vc) {
                    //                    [weakself OPenVc:vc];
                    //                }
                    //                return ;
                    if ([[[PortalHelper sharedInstance]get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
                        //                    RechargeandcashwithdrawalVc *tmp = [RechargeandcashwithdrawalVc new];
                        //                    if (type == homeTopCellType_WithdrawCash) {
                        //                        tmp.stateMoney = RechargeandcashwithdrawalVcState_WithdrawCash;
                        //                    }
                        //                    vc = tmp;
                        if (type == homeTopCellType_WithdrawCash) {
                            WithdrawCashVc *tmp = [WithdrawCashVc new];
                            tmp.stateMoney = RechargeandcashwithdrawalVcState_WithdrawCash;
                            vc = tmp;
                        } else {
                            RechargeVc *tmp = [RechargeVc new];
                            vc = tmp;
                        }
                    }else{
                        [MBProgressHUD showPrompt:@"请先进行实名认证"];
                        RealNameVc *tmp =[RealNameVc new];
                        vc = tmp;
                    }
                } else if (type == homeTopCellType_consumption) {
                    [weakself popselecetPopView];
                } else if (type == homeTopCellType_balance) {
                    [weakself openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].balUrl];
                } else if (type == homeTopCellType_Financial_gold) {
                    Myfinancialmanagement *vc = [Myfinancialmanagement new];
                    vc.url = [[PortalHelper sharedInstance] get_Globaldata].myFinUrl;
                    [self OPenVc:vc];
                }
            } else {
                [weakself openLoginView:nil];
            }
            if (vc) {
                [weakself OPenVc:vc];
            }
        }
    };
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self shoAle];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.popselecetView) {
        [self.popselecetView closeClisck];
    }
}
- (void)popselecetPopView{
    if (self.popselecetView) {
        [self.popselecetView windosViewshow];
    }else{
//        popSelecetView *popselecetView = [popSelecetView new];
//        self.popselecetView = popselecetView;
//        [self.popselecetView windosViewshow];
        
        CGFloat tmp = 20;
        if (IPoneX) {
            tmp += 20;
        }
        UIView *targetView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH-44-20, tmp, 44, 44)];
        self.targetView = targetView;
        
        MOTPopConfig *config = [MOTPopConfig new];
        config.size = CGSizeMake(130, 128.4);
        config.targetView = self.targetView;
        config.isAuto = NO;
        config.tabColor = [UIColor whiteColor];
        config.isAuto = NO;
        config.vX = SCREENWIDTH-30;
        
        UIButton *Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 128.4*0.5)];
        [Btn1 setWithNormalColor:0x1E2E47 NormalAlpha:1 NormalTitle:NSLocalizedString(@"    扫码付", @"") NormalImage:PIC_HOME_SCAN_CODE NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [config addView:Btn1];

        UIButton *Btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 128.4*0.5)];
        [Btn2 setWithNormalColor:0x1E2E47 NormalAlpha:1 NormalTitle:NSLocalizedString(@"    收款码", @"") NormalImage:PIC_HOME_PAYMENT_CODE NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [config addView:Btn2];
        
        kWeakSelf(self);
        [MOTMutablePopView popWithConfig:config  ClickIndexBlock:^(NSUInteger index) {
            NSLog(@"%s",__func__); //100
            [weakself.popselecetView closeClisck];
            if (index<100) {
//                consumptionVc *vc = [consumptionVc new];
//                if (index == 0) {
//                    vc.state = consumptionVcState_Scancodepayment;
//                } else if (index == 1) {
//                    vc.state = consumptionVcState_Paymentcode;
//                }
//                [self OPenVc:vc];
//#ifdef  DEBUG
//                UIViewController *vc;
//                if (index == 0) {
//                    ScancodepaymentVc *tmp = [ScancodepaymentVc new];
//                    vc = tmp;
//                } else if (index == 1) {
//                    PaymentcodeVc *tmp = [PaymentcodeVc new];
//                    vc = tmp;
//                }
//#else
                UIViewController *vc;
                if ([[[PortalHelper sharedInstance]get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
                    if (index == 0) {
                        ScancodepaymentVc *tmp = [ScancodepaymentVc new];
                        vc = tmp;
                    } else if (index == 1) {
                        PaymentcodeVc *tmp = [PaymentcodeVc new];
                        vc = tmp;
                    }
                }else{
                    [MBProgressHUD showPrompt:@"请先进行实名认证"];
                    RealNameVc *tmp =[RealNameVc new];
                    vc = tmp;
                }
//#endif
                if (vc) {
                    [self OPenVc:vc]; 
                }
            }
//            OpenScancodepaymentVc *vc = [OpenScancodepaymentVc new];
//            [self OPenVc:vc]; 
        }];
    }
}
#pragma --mark< 配置homeBottomCell 的数据>
- (void)configurehomeBottomCell:(homeBottomCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.userData = self.userData;
    kWeakSelf(self);
    cell.ClicBtn = ^(bankCard *data, NSInteger tag) {
        NSLog(@"tag=%ld",tag);
        AirTicketsAndBankCardsShow *view = [AirTicketsAndBankCardsShow new];
        view.userData = weakself.userData;
        view.indexx = tag;
        [view windosViewshow];
    };
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[PortalHelper sharedInstance] get_userInfo] && !self.userData) {
        return 0;
    }else{
        return 2;
    }
}



- (void)hideBottomBarWhenPush
{
}
- (void)customBackButton
{
}
#pragma --mark< 检查更新 >
- (void)checkAppVer{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_appappUpdatesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        CheckApp *data = [CheckApp mj_objectWithKeyValues:dataDict];
        weakself.data  =data;
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself shoAle];
    } failure:^(NSInteger errorCode, NSString *msg) {
    }];
}

- (void)shoAle{
    if (self.data) {
        if (self.data.updateType && ![self.data.updateType isEqualToString:@"0"]) {
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
            }else if ([self.data.updateType isEqualToString:@"2"]) {
                
            }
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
@end
