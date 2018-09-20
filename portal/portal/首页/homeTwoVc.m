//
//  homeTwoVc.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVc.h"
#import "UIScrollView+YLSpringHeader.h"
#import "YLSpringHeaderView.h"
#import "homeTwoVcOne.h"
#import "homeTwoVcTwo.h"
#import "homeTwoVcThree.h"
#import "homeTwoVcFour.h"
#import "homeTwoVcFive.h"
#import "homeTwoVcSix.h"
#import "homeTwoVcThreeNew.h"
#import "homeTwoVcFourHead.h"
#import "homeTwoVcFoot.h"
#import "homeHead.h"
#import "EachWkVc.h"
#import "CardCouponsVc.h"
#import "RealNameVc.h"
#import "MyBorrowList.h"
#import "Tempusbaohome.h"
#import "EmployeeLoanVc.h"
#import "SignInVc.h"
#import "MaldivesPayVc.h"
//#import "ThirdpartypaymentindesignVc.h"
//#import "ApplySuccessVc.h"
@interface homeTwoVc ()
//UIScrollViewDelegate
@property (nonatomic, strong) YLSpringHeaderView *headerView;
@property (nonatomic, strong) homeTwoVcFoot *foot;
@property (nonatomic,strong) homeHead *Head;
@property (nonatomic,strong) HomeDataNew *dataNew;
@property (nonatomic,assign) BOOL ShowexpMoneyIncomeFlag;
@end

@implementation homeTwoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.hidesBarsOnSwipe = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
    self.registerClasss = @[[homeTwoVcOne class],[homeTwoVcTwo class],[homeTwoVcThree class],[homeTwoVcFour class],[homeTwoVcFive class],[homeTwoVcSix class],[homeTwoVcThreeNew class]];
    
    
    [self appgetGlobalParamssuccess:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadNewDataFucnC:)
                                                 name:@"loadNewData"
                                               object:nil];
    
    self.dataNew = [[PortalHelper sharedInstance]get_HomeDataNew];
    if (self.dataNew) {
        self.empty_type = kRespondCodeSuccess;
        self.header.hidden = NO;
        if (self.dataNew.topPicture) {
            self.tableView.tableHeaderView = self.Head;
            self.Head.hidden = NO;
            self.Head.dataNew = self.dataNew;
        }
        self.tableView.tableFooterView = self.foot;
        self.foot.hidden = NO;
        [self loadNewData];
    }else{
        [self.header beginRefreshing];
    }
}



- (void)loadNewDataFucnC:(NSNotification *)user{
    [self loadNewData];
}
- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
    [self appgetGlobalParamssuccess:nil];
}
#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    [self loadNewData];
}
#pragma --mark<网络从无连接到连接的通知>
- (void)NETWORK_FROM_CONNECTION_TO_CONNECTION_NOTIFICATIONFunC:(NSNotification *)user{
    [self loadNewData];
}
- (void)loadNewData{
    if (self.header.tag == 100) {
        return;
    }
    self.header.tag = 100;
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_appqueryHomesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.dataNew = [HomeDataNew mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance]set_HomeDataNew:weakself.dataNew];
        weakself.header.tag = 0;
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        
        //            weakself.dataNew.topPicture = nil;
        if (weakself.dataNew.topPicture) {
            weakself.tableView.tableHeaderView = weakself.Head;
            weakself.Head.hidden = NO;
            weakself.Head.dataNew = weakself.dataNew;
        }
        
        weakself.tableView.tableFooterView = weakself.foot;
        weakself.foot.hidden = NO;
        weakself.header.hidden = NO;
    } failure:^(NSInteger errorCode, NSString *msg) {
        weakself.header.tag = 0;
        if (errorCode == KRespondCodeNotConnect) {
            [weakself.header endRefreshing];
            if (!weakself.dataNew) {
                
                
                weakself.dataNew = [HomeDataNew new];
                {
                    NSMutableArray *tmpArry = [NSMutableArray new];
                    {
                        prgInfosOne *one = [prgInfosOne new];
                        one.prgRate = @"--";
                        //                            one.increaseRate = @"--";
                        one.period = @"--";
                        one.repayMod = @"每月付息，到期还本";
                        [tmpArry addObject:one];
                    }
                    {
                        prgInfosOne *one = [prgInfosOne new];
                        one.prgRate = @"--";
                        //                            one.increaseRate = @"--";
                        one.period = @"--";
                        one.repayMod = @"每月付息，到期还本";
                        [tmpArry addObject:one];
                    }
                    weakself.dataNew.prgInfos = tmpArry;
                }
                weakself.tableView.tableHeaderView = weakself.Head;
                weakself.Head.hidden = NO;
                weakself.Head.backPng.image =[UIImage imageNamed:@"T banner"];
                
                weakself.tableView.tableFooterView = weakself.foot;
                weakself.foot.hidden = NO;
                
                weakself.empty_type = succes_empty_num;
                [weakself.tableView reloadData];
            }
        } else {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
            weakself.Head.hidden = YES;
            weakself.foot.hidden = YES;
        }
    }];
}

- (homeTwoVcFoot *)foot{
    if (!_foot) {
        _foot = [homeTwoVcFoot new];
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"1"]) {
                _foot.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-85-159-175*PROPORTION_HEIGHT-50);
            }else{
                _foot.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-85-222-175*PROPORTION_HEIGHT-50);
            }
        } else {
            _foot.frame = CGRectMake(0, 0, SCREENWIDTH, 113);
        }
    }
    return _foot;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 10.0;
    } else {
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section >= 2) {
        if (section == 3) {
            return 56.0;
        } else {
            return 10.0;
        }
    } else {
        return 0.01;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        homeTwoVcFourHead *view = [[homeTwoVcFourHead alloc] init];
        view.moreViewClick = ^{
            NSNotification *notification =[NSNotification notificationWithName:gotolicai_NOTIFICATION object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        };
        return view;
    } else {
        return [[UIView alloc] init];
    }
}
- (void)Receivenewuserfinancialmoney{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:@"领取中..." toView:self.view];
    [[ToolRequest sharedInstance]URLBASIC_userreceiveExpMoneysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:@"领取成功" toView:weakself.view];
        UserInfoDeatil *tmp = [[PortalHelper sharedInstance]get_userInfoDeatil];
        tmp.receiveExpMoneyFlag = @"1";
        [[PortalHelper sharedInstance]set_userInfoDeatil:tmp];
        [weakself loadNewData];
        [weakself ReceivenewuserfinancialmoneySuccess:dataDict[@"incomeDate"]];
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
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            if ([[PortalHelper sharedInstance]get_userInfo]) {
                [self loginDoing];
            } else {
                SignInVc *losgin = [[SignInVc alloc]init];
                kWeakSelf(self);
                losgin.block = ^{
                    [weakself loginDoing];
                };
                [self.navigationController pushViewController:losgin animated:YES];
                //            [self openLoginView:nil];
            }
        }
    } else if (indexPath.section == 2) {
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            [self loginDoing];
            //            if ([[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:@"1"]) {
            //                if ([[[PortalHelper sharedInstance]get_userInfoDeatil].mynewUserFlag isEqualToString:@"1"]) {
            //                    if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"0"]) {
            //                        [self Receivenewuserfinancialmoney];
            //                    }else if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"1"]) {
            //                        [MBProgressHUD showPrompt:@"您已经领取" toView:self.view];
            //                    }
            //                }else{
            //                    [MBProgressHUD showPrompt:@"只针对新用户开放，快邀请好友参与吧！" toView:self.view];
            //                }
            //            } else {
            //                [self OPenVc:[RealNameVc new]];
            //            }
        } else {
            SignInVc *losgin = [[SignInVc alloc]init];
            kWeakSelf(self);
            losgin.block = ^{
                [weakself loginDoing];
            };
            [self.navigationController pushViewController:losgin animated:YES];
            //            [self openLoginView:nil];
        }
    } else if (indexPath.section == 3) {
        prgInfosOne *one = self.dataNew.prgInfos[indexPath.row];
        EachWkVc *vc = [EachWkVc new];
        vc.url = one.prgDetailHref;
        [self OPenVc:vc];
    } else if (indexPath.section == 4) {
        [self OPenTempusbaohomeVc];
    }  else if (indexPath.section == 5) {
        EmployeeLoanVc *vc = [EmployeeLoanVc new];
        vc.url = self.dataNew.loanUrl;
        [self OPenVc:vc];
        //        [self openEachWkVcWithId:self.dataNew.loanUrl];
    }
}

- (void)loginDoing{
    if ([[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:@"1"]) {
        if ([[[PortalHelper sharedInstance]get_userInfoDeatil].mynewUserFlag isEqualToString:@"1"]) {
            if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"0"]) {
                [self Receivenewuserfinancialmoney];
            }else if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"1"]) {
                [MBProgressHUD showPrompt:@"您已经领取" toView:self.view];
            }
        }else{
            [MBProgressHUD showPrompt:@"只针对新用户开放，快邀请好友参与吧！" toView:self.view];
        }
    } else {
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.userData.expMoneyIncomeFlag isEqualToString:@"1"] && !self.ShowexpMoneyIncomeFlag) {
        self.ShowexpMoneyIncomeFlag = YES;
        [self Experiencegoldreminding];
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

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        homeTwoVcOne *cell = [homeTwoVcOne returnCellWith:tableView];
        [self configurehomeTwoVcOne:cell atIndexPath:indexPath];
        return  cell;
    } else if (indexPath.section == 1) {
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"1"]) {
                homeTwoVcThree *cell = [homeTwoVcThree returnCellWith:tableView];
                [self configurehomeTwoVcThree:cell atIndexPath:indexPath];
                return  cell;
            }else{
                homeTwoVcThreeNew *cell = [homeTwoVcThreeNew returnCellWith:tableView];
                [self configurehomeTwoVcThreeNew:cell atIndexPath:indexPath];
                return  cell;
            }
        } else {
            homeTwoVcTwo *cell = [homeTwoVcTwo returnCellWith:tableView];
            [self configurehomeTwoVcTwo:cell atIndexPath:indexPath];
            return  cell;
        }
    } else if (indexPath.section == 2) {
        if ([[[PortalHelper sharedInstance]get_userInfoDeatil].receiveExpMoneyFlag isEqualToString:@"1"]) {
            homeTwoVcThree *cell = [homeTwoVcThree returnCellWith:tableView];
            [self configurehomeTwoVcThree:cell atIndexPath:indexPath];
            return  cell;
        }else{
            homeTwoVcThreeNew *cell = [homeTwoVcThreeNew returnCellWith:tableView];
            [self configurehomeTwoVcThreeNew:cell atIndexPath:indexPath];
            return  cell;
        }
    } else if (indexPath.section == 3) {
        homeTwoVcFour *cell = [homeTwoVcFour returnCellWith:tableView];
        [self configurehomeTwoVcFour:cell atIndexPath:indexPath];
        return  cell;
    } else if (indexPath.section == 4) {
        homeTwoVcFive *cell = [homeTwoVcFive returnCellWith:tableView];
        [self configurehomeTwoVcFive:cell atIndexPath:indexPath];
        return  cell;
    } else {
        homeTwoVcSix *cell = [homeTwoVcSix returnCellWith:tableView];
        [self configurehomeTwoVcSix:cell atIndexPath:indexPath];
        return  cell;
    }
}
- (void)OPenTempusbaohomeVc{
    Tempusbaohome *vc = [Tempusbaohome new];
    vc.url = self.dataNew.fundUrl;
    [self OPenVc:vc];
}

#pragma --mark< 配置homeTwoVcOne 的数据>
- (void)configurehomeTwoVcOne:(homeTwoVcOne *)cell atIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf(self);
    cell.doneONeClick = ^(oneHomeData *one) {
        if ([one.title isEqualToString:@"票券"] || [one.title isEqualToString:@"零钱"] || [one.title isEqualToString:@"付款"]) {
            if ([[PortalHelper sharedInstance]get_userInfo]) {
                if ([one.title isEqualToString:@"票券"]) {
                    [weakself OPenVc:[CardCouponsVc new]];
                } else if ([one.title isEqualToString:@"零钱"]) {
                    [weakself openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].balUrl];
                } else if ([one.title isEqualToString:@"付款"]) {
                    [self OPenVc:[MaldivesPayVc new]];
                    //                    [self OPenVc:[ThirdpartypaymentindesignVc new]];
                }
            }else{
                [self openLoginView:nil];
            }
        }else {
            if ([one.title isEqualToString:@"定期"]) {
                NSNotification *notification =[NSNotification notificationWithName:gotolicai_NOTIFICATION object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            } else if ([one.title isEqualToString:@"腾邦宝"]) {
                [weakself OPenTempusbaohomeVc];
            } else if ([one.title isEqualToString:@"员工福利"]) {
                EmployeeLoanVc *vc = [EmployeeLoanVc new];
                vc.url = self.dataNew.loanUrl;
                [self OPenVc:vc];
                
                //                [weakself openEachWkVcWithId:self.dataNew.loanUrl];
            } else if ([one.title isEqualToString:@"高端理财"]) {
                [weakself openEachWkVcWithId:self.dataNew.privateFundUrl];
            } else if ([one.title isEqualToString:@"票券"]) {
                [weakself OPenVc:[CardCouponsVc new]];
            } else if ([one.title isEqualToString:@"零钱"]) {
                [weakself openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].balUrl];
            }
        }
    };
}
#pragma --mark< 配置homeTwoVcTwo 的数据>
- (void)configurehomeTwoVcTwo:(homeTwoVcTwo *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.dataArry = self.dataNew.bannerInfos;
    kWeakSelf(self);
    cell.doneONeClick = ^(bannerInfosOne *one) {
        if ([one.openMode isEqualToString:@"3"]) {
            NSNotification *notification =[NSNotification notificationWithName:gotolicai_NOTIFICATION object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        } else {
            if (one.href) {
                if (([one.needLogin isEqualToString:@"1"] && [[PortalHelper sharedInstance]get_userInfo]) || ![one.needLogin isEqualToString:@"1"]) {
                    if ([one.openMode isEqualToString:@"1"]) {
                        if ([[UIApplication sharedApplication] canOpenURL:one.href]) {
                            [[UIApplication sharedApplication] openURL:one.href];
                        }
                    } else {
                        EachWkVc *vc = [EachWkVc new];
                        vc.url = one.href;
                        [weakself OPenVc:vc];
                    }
                } else {
                    [weakself openLoginView:nil];
                }
            } else {
                //                [MBProgressHUD showPrompt:@"没有链接～" toView:weakself.view];
            }
        }
    };
}
#pragma --mark< 配置homeTwoVcThree 的数据>
- (void)configurehomeTwoVcThree:(homeTwoVcThree *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma --mark< 配置homeTwoVcThreeNew 的数据>
- (void)configurehomeTwoVcThreeNew:(homeTwoVcThreeNew *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma --mark< 配置homeTwoVcFour 的数据>
- (void)configurehomeTwoVcFour:(homeTwoVcFour *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.one = self.dataNew.prgInfos[indexPath.row];
}
#pragma --mark< 配置homeTwoVcFive 的数据>
- (void)configurehomeTwoVcFive:(homeTwoVcFive *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.dataNew.incomeRatio.length) {
        cell.shouyi.text =self.dataNew.incomeRatio;
    } else {
        cell.shouyi.text = @"--";
    }
}
#pragma --mark< 配置homeTwoVcSix 的数据>
- (void)configurehomeTwoVcSix:(homeTwoVcSix *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return self.dataNew.prgInfos.count;
    } else {
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.empty_type == succes_empty_num) {
        //        NSInteger tmp1 = [[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue];
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            return 2;
        } else {
            return 6;
        }
    }
    return 0;
}


//////////
-(void)dealloc
{
    [self.tableView removeObserver:self.tableView forKeyPath:@"contentOffset"];
    NSLog(@"释放监听者");
}


#pragma mark - Getter

-(YLSpringHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[YLSpringHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowWidth/2)];
        [self.view addSubview:_headerView];
    }
    
    return _headerView;
}


- (void)headerViewLoad
{
    //初始化header
    self.headerView.headerImage = [[UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0] imageWithColor];
    
    self.headerView.tittle = @"哈哈是个demo";
    self.headerView.isShowLeftButton = YES;
    self.headerView.isShowRightButton = YES;
    __weak typeof(self) weakSelf = self;
    self.headerView.leftClickBlock = ^(UIButton *btn){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.headerView.rightClickBlock  = ^(UIButton *btn){
        NSLog(@"点击了分享");
    };
    
    [self.tableView handleSpringHeadView:self.headerView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.empty_type == succes_empty_num) {
        CGFloat yy = scrollView.contentOffset.y;
        NSLog(@"yy=%f",yy);
        //        if (yy > 0) {
        //            self.Head.frame = CGRectMake(0, -yy, SCREENWIDTH, 175*PROPORTION_HEIGHT);
        //        } else if (yy < 0) {
        //            self.Head.frame = CGRectMake(0, 0, SCREENWIDTH, 175*PROPORTION_HEIGHT-yy);
        //        }
        
        if (yy > 175*PROPORTION_HEIGHT) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        } else  {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    
    //    - (void)scrollViewDidScroll:(UIScrollView *)scrollView
    //    {
    //        //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    //        UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    //        //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    //        CGFloat velocity = [pan velocityInView:scrollView].y;
    //
    //        if (velocity <- 5) {
    //            //向上拖动，隐藏导航栏
    //            [self.navigationController setNavigationBarHidden:YES animated:YES];
    //        }else if (velocity > 5) {
    //            //向下拖动，显示导航栏
    //            [self.navigationController setNavigationBarHidden:NO animated:YES];
    //        }else if(velocity == 0){
    //            //停止拖拽
    //        }
    //    }
}
- (homeHead *)Head{
    if (!_Head) {
        homeHead *head = [[homeHead alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 175*PROPORTION_HEIGHT)];
        [self.view addSubview:head];
        kWeakSelf(self);
        head.moreViewClick = ^{
            if (weakself.dataNew.topHref) {
                if (([weakself.dataNew.topNeedLogin isEqualToString:@"1"] && [[PortalHelper sharedInstance]get_userInfo]) || ![weakself.dataNew.topNeedLogin isEqualToString:@"1"]) {
                    if ([weakself.dataNew.topOpenMode isEqualToString:@"1"]) {
                        if ([[UIApplication sharedApplication] canOpenURL:weakself.dataNew.topPicture]) {
                            [[UIApplication sharedApplication] openURL:weakself.dataNew.topPicture];
                        }
                    } else {
                        EachWkVc *vc = [EachWkVc new];
                        vc.url = weakself.dataNew.topPicture;
                        [weakself OPenVc:vc];
                    }
                } else {
                    [weakself openLoginView:nil];
                }
            } else {
                //                [MBProgressHUD showPrompt:@"没有链接～" toView:weakself.view];
            }
        };
        _Head = head;
    }
    return _Head;
}
- (void)hideBottomBarWhenPush
{
}
- (void)customBackButton
{
}
@end
