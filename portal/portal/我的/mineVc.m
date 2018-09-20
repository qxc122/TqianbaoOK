//
//  mineVc.m
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "mineVc.h"
#import "SetUpVc.h"
#import "mineVcCell.h"
#import "headMineCell.h"
#import "newsListVc.h"
#import "BasicInfoVc.h"
#import "myBankCardVc.h"
#import "AirTicketsAndBankCardsShow.h"
#import "BankCardDisplay.h"
#import "TicketDisplay.h"
#import "SignInVc.h"
#import "EmployeeLoanVc.h"
#import "SetpaymentpasswordVc.h"
#import "AuthenticationVc.h"
#import "GesturecipherVc.h"
#import "VenturecapitalRealNameVc.h"
#import "RechargeandcashwithdrawalVc.h"
#import "Myfinancialmanagement.h"
#import "ChatViewController.h"
#import "Tempusbaohome.h"
#import "CardCouponsVc.h"
#import "BorrowingBillNotOut.h"
#import "BorrowingBillNot.h"
#import "BorrowingBillOverdue.h"
#import "BorrowingBillNotOverdue.h"
#import "BorrowingBillPayOff.h"
#import "MyBorrowList.h"
@interface mineVc ()
@property (nonatomic,strong) NSMutableArray *Arry_data;
@end

@implementation mineVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.bounces = NO;
    //    self.title = NSLocalizedString(@"我的", @"");
    self.view.backgroundColor = COLOUR_BACK_NORMAL;
    self.registerClasss = @[[mineVcCell class],[headMineCell class],[BorrowingBillNotOut class],[BorrowingBillNot class],[BorrowingBillOverdue class],[BorrowingBillNotOverdue class],[BorrowingBillPayOff class]];
    
    if (![[PortalHelper sharedInstance] get_userInfo] || self.userData) {
        self.header.hidden = YES;
        self.empty_type = succes_empty_num;
        [self.tableView reloadData];
    }else{
        self.header.hidden = NO;
        self.empty_type = In_loading_empty_num;
        [self.header beginRefreshing];
    }
}

#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    if ([[PortalHelper sharedInstance] get_userInfo]) {
        //        self.header.hidden = NO;
        //        [self.header beginRefreshing];
        self.isNeedRefreth = YES;
    }else{
        [self.tableView reloadData];
        [self NOneNewsButton];
    }
}
- (void)setNewsBtn{
    if ([self.userData.hasUnreadNews isEqualToString:STRING_1]) {
        [self NewsButton];
    } else {
        [self NOneNewsButton];
    }
}
- (void)loadNewData{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_tpurseusermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.userData = [UserInfoDeatil mj_objectWithKeyValues:dataDict];
            [[PortalHelper sharedInstance] set_userInfoDeatil:weakself.userData];
            [weakself setNewsBtn];
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        } failure:^(NSInteger errorCode, NSString *msg) {
            if (!weakself.userData) {
                [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
            }
        }];
    } else {
        self.empty_type = succes_empty_num;
        self.header.hidden = YES;
    }
}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        NSArray *tmp = self.Arry_data[indexPath.section];
        id one = tmp[indexPath.row];
        if ([one isKindOfClass:[NSString class]]) {
            BasicInfoVc *vc = [BasicInfoVc new];
            [self OPenVc:vc];
        }else{
            setUpData *one = tmp[indexPath.row];
            UIViewController *vc;
            if ([one.title isEqualToString:NSLocalizedString(@"账单", @"")]) {
                //                GlobalParameter *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
                //                [self openEachWkVcWithId:data.loanUrl];
                [self openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].myBillUrl];
            } else if ([one.title isEqualToString:NSLocalizedString(@"总资产", @"")]) {
                //                [self OPenVc:[AddBankCardVc new]];
                [self openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].totalAssetUrl];
            } else if ([one.title isEqualToString:NSLocalizedString(@"我的零钱", @"")]) {
                [self openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].balUrl];
            } else if ([one.title isEqualToString:NSLocalizedString(@"我的定期", @"")]) {
                Myfinancialmanagement *tmp = [Myfinancialmanagement new];
                tmp.url = [[PortalHelper sharedInstance] get_Globaldata].myFinUrl;
                vc = tmp;
                //                [self openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].myFinUrl];
            } else if ([one.title isEqualToString:NSLocalizedString(@"我的T币", @"")]) {
                [self openEachWkVcWithId:self.userData.integralUrl];
            } else if ([one.title isEqualToString:NSLocalizedString(@"我的白条", @"")]) {
                
            } else if ([one.title isEqualToString:NSLocalizedString(@"我的银行卡", @"")]) {
                myBankCardVc *tmpVc = [myBankCardVc new];
                //                tmpVc.userData = self.userData;
                vc = (UIViewController *)tmpVc;
            } else if ([one.title isEqualToString:NSLocalizedString(@"联系客服", @"")]) {
                [self callKefu];
            } else if ([one.title isEqualToString:NSLocalizedString(@"腾邦宝", @"")]) {
                Tempusbaohome *vc = [Tempusbaohome new];
                vc.url = [[PortalHelper sharedInstance]get_Globaldata].fundUrl;
                [self OPenVc:vc];
            } else if ([one.title isEqualToString:NSLocalizedString(@"我的借款", @"")]) {
                if (![self.userData.loanStatus isEqualToString:@"0"]) {
                    EmployeeLoanVc *vc = [EmployeeLoanVc new];
                    vc.url = self.userData.loanUrl;
                    [self OPenVc:vc];
                }
            } else if ([one.title isEqualToString:NSLocalizedString(@"我的票券", @"")]) {
                [self OPenVc:[CardCouponsVc new]];
            }
            if(vc){
                [self OPenVc:vc];
            }
        }
    }else{
        if (indexPath.section != 2) {
            [self openLoginView:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)callKefu{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([PortalHelper sharedInstance].isReachable) {
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    EMError *error = [[EMClient sharedClient] loginWithUsername:[[PortalHelper sharedInstance]get_userInfo].easemobId password:@"111111"];
                    NSLog(@"sdf");
                });
            }
            ChatViewController *tmpVc = [[ChatViewController alloc]initWithConversationChatter:@"kefu" conversationType:EMConversationTypeChat];
            [weakself OPenVc:tmpVc];
        } else {
            [MBProgressHUD showError:@"网络连接异常，请检查网络"];
        }
    }]];
    
    if ([[PortalHelper sharedInstance]get_Globaldata].customerServicePhone.length == 18) {
        NSString *title = @"客服热线";
        NSString *des = @" 分机号:";
        title = [title stringByAppendingString:[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringToIndex:13]];
        des= [des stringByAppendingString:[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringFromIndex:14]];
        
        [alert addAction:[UIAlertAction actionWithTitle:[title stringByAppendingString:des] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringToIndex:13]];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *tmp = self.Arry_data[indexPath.section];
    id one = tmp[indexPath.row];
    if ([one isKindOfClass:[NSString class]]) {
        headMineCell *cell = [headMineCell returnCellWith:tableView];
        [self configureheadMineCell:cell atIndexPath:indexPath];
        return  cell;
    }else{
        NSArray *tmp = self.Arry_data[indexPath.section];
        setUpData *one = tmp[indexPath.row];
        if ([one.title isEqualToString:@"我的借款"]) {
            if ([self.userData.loanStatus isEqualToString:@"1"]) {
                BorrowingBillNotOverdue *cell = [BorrowingBillNotOverdue returnCellWith:tableView];
                [self configureBorrowingBillNotOverdue:cell atIndexPath:indexPath];
                return  cell;
            } else if ([self.userData.loanStatus isEqualToString:@"2"]) {
                BorrowingBillNotOut *cell = [BorrowingBillNotOut returnCellWith:tableView];
                [self configureBorrowingBillNotOut:cell atIndexPath:indexPath];
                return  cell;
            } else if ([self.userData.loanStatus isEqualToString:@"3"]) {
                BorrowingBillOverdue *cell = [BorrowingBillOverdue returnCellWith:tableView];
                [self configureBorrowingBillOverdue:cell atIndexPath:indexPath];
                return  cell;
            } else if ([self.userData.loanStatus isEqualToString:@"4"]) {
                BorrowingBillPayOff *cell = [BorrowingBillPayOff returnCellWith:tableView];
                [self configureBorrowingBillPayOff:cell atIndexPath:indexPath];
                return  cell;
            }else{
                BorrowingBillNot *cell = [BorrowingBillNot returnCellWith:tableView];
                [self configureBorrowingBillNot:cell atIndexPath:indexPath];
                return  cell;
            }
        } else {
            mineVcCell *cell = [mineVcCell returnCellWith:tableView];
            [self configuremineVcCell:cell atIndexPath:indexPath];
            return  cell;
        }
    }
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configuremineVcCell:(mineVcCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *tmp = self.Arry_data[indexPath.section];
    setUpData *one = tmp[indexPath.row];
    cell.data = one;
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        if ([one.title isEqualToString:NSLocalizedString(@"账单", @"")]) {
            cell.des.text = nil;
        } else if ([one.title isEqualToString:NSLocalizedString(@"总资产", @"")]) {
            cell.des.text = [NSString stringWithFormat:@"%.2f元",[self.userData.totalAsset doubleValue]];
        } else if ([one.title isEqualToString:NSLocalizedString(@"我的零钱", @"")]) {
            cell.des.text = [NSString stringWithFormat:@"%.2f元",[self.userData.acctBal doubleValue]];
        } else if ([one.title isEqualToString:NSLocalizedString(@"我的定期", @"")]) {
            cell.des.text = [NSString stringWithFormat:@"%.2f元",[self.userData.finaAsset doubleValue]];
        } else if ([one.title isEqualToString:NSLocalizedString(@"我的T币", @"")]) {
            cell.des.text = [NSString stringWithFormat:@"%.0f个",[self.userData.integral doubleValue]];
        } else if ([one.title isEqualToString:NSLocalizedString(@"我的白条", @"")]) {
            cell.des.text = nil;
        } else if ([one.title isEqualToString:NSLocalizedString(@"我的银行卡", @"")]) {
            cell.des.text = nil;
        } else if ([one.title isEqualToString:NSLocalizedString(@"腾邦宝", @"")]) {
            cell.des.text = [NSString stringWithFormat:@"%@元",self.userData.fundBal];
        }
    } else {
        cell.des.text = nil;
    }
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    if (self.header.isRefreshing) {
        [self.header endRefreshing];
    }
    [self setNewsBtn];
    [self.tableView reloadData];
}


#pragma --mark< 配置BorrowingBillNotOut 的数据>
- (void)configureBorrowingBillNot:(BorrowingBillNot *)cell atIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf(self);
    cell.BorrowingMoney = ^{
        //打开借款页面
        NSLog(@"%s",__FUNCTION__);
        EmployeeLoanVc *vc = [EmployeeLoanVc new];
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            vc.url = weakself.userData.loanUrl;
            //            [weakself openEachWkVcWithId:weakself.userData.loanUrl];
        } else {
            vc.url = [[PortalHelper sharedInstance]get_HomeDataNew].loanUrl;
            //            [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_HomeDataNew].loanUrl];
        }
        [self OPenVc:vc];
    };
}
#pragma --mark< 配置BorrowingBillNotOut 的数据>
- (void)configureBorrowingBillOverdue:(BorrowingBillOverdue *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.userData = self.userData;
}

#pragma --mark< 配置BorrowingBillNotOverdue 的数据>
- (void)configureBorrowingBillNotOverdue:(BorrowingBillNotOverdue *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.userData = self.userData;
}
#pragma --mark< 配置BorrowingBillPayOff 的数据>
- (void)configureBorrowingBillPayOff:(BorrowingBillPayOff *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma --mark< 配置BorrowingBillNotOut 的数据>
- (void)configureBorrowingBillNotOut:(BorrowingBillNotOut *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma --mark< 配置headMineCell 的数据>
- (void)configureheadMineCell:(headMineCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.userData = self.userData;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != self.Arry_data.count-1) {
        return 10.0;
    }else{
        return 0.01;
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *tmp = self.Arry_data[section];
    return tmp.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.empty_type == succes_empty_num) {
        return self.Arry_data.count;
    }else{
        return 0;
    }
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        
        NSMutableArray *one = [NSMutableArray array];
        //        setUpData *tmp11 = [setUpData new];
        //        tmp11.title = NSLocalizedString(@"账单", @"");
        //        tmp11.icon = PIC_BILL;
        //        [one addObject:tmp11];
        
        {
            setUpData *tmp12 = [setUpData new];
            tmp12.title = NSLocalizedString(@"账单", @"");
            tmp12.icon = @"账单";
            [one addObject:tmp12];
        }
        
        setUpData *tmp12 = [setUpData new];
        tmp12.title = NSLocalizedString(@"总资产", @"");
        tmp12.icon = PIC_TOTAL_ASSETS;
        [one addObject:tmp12];
        
        setUpData *tmp13 = [setUpData new];
        tmp13.title = NSLocalizedString(@"我的零钱", @"");
        tmp13.icon = PIC_BALANCE;
        [one addObject:tmp13];
        
        setUpData *tmp122 = [setUpData new];
        tmp122.title = NSLocalizedString(@"腾邦宝", nil);
        tmp122.icon = @"腾邦宝";
        [one addObject:tmp122];
        
        
        
        setUpData *tmp14 = [setUpData new];
        tmp14.title = NSLocalizedString(@"我的定期", @"");
        tmp14.icon = PIC_CONDUCT_FINANCIAL_TRANSACTIONS;
        [one addObject:tmp14];
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            [one removeObjectAtIndex:4];
            [one removeObjectAtIndex:1];
        }
        [_Arry_data addObject:one];
        
        
        
        {
            NSMutableArray *arry = [NSMutableArray array];
            setUpData *tmp14 = [setUpData new];
            tmp14.title = NSLocalizedString(@"我的借款", @"");
            [arry addObject:tmp14];
            [_Arry_data addObject:arry];
        }
        
        NSMutableArray *three = [NSMutableArray array];
        setUpData *tmp31 = [setUpData new];
        tmp31.title = NSLocalizedString(@"我的银行卡", @"");
        tmp31.icon = @"我的银行卡";
        [three addObject:tmp31];
        [_Arry_data addObject:three];
        
        NSMutableArray *two = [NSMutableArray array];
        {
            setUpData *tmp14 = [setUpData new];
            tmp14.title = NSLocalizedString(@"我的票券", @"");
            tmp14.icon = @"我的卡券";
            [two addObject:tmp14];
        }
        
        
        setUpData *tmp21 = [setUpData new];
        tmp21.title = NSLocalizedString(@"我的T币", @"");
        tmp21.icon = @"我的T币";
        [two addObject:tmp21];
        [_Arry_data addObject:two];
        
        
        NSMutableArray *four = [NSMutableArray array];
        setUpData *tmp41 = [setUpData new];
        tmp41.title = NSLocalizedString(@"联系客服", @"");
        tmp41.icon = @"客服";
        [four addObject:tmp41];
        
        [_Arry_data addObject:four];
        
        [_Arry_data insertObject:@[@"1"] atIndex:0];
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            [_Arry_data removeObjectAtIndex:2];
        }
    }
    return _Arry_data;
}

- (void)customBackButton
{
    [self NOneNewsButton];
    UIImage* imageRight = [[UIImage imageNamed:PIC_SET_UP]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* rightBarutton = [[UIBarButtonItem alloc] initWithImage:imageRight style:UIBarButtonItemStylePlain target:self action:@selector(setUpFUNc)];
    self.navigationItem.rightBarButtonItem = rightBarutton;
}

- (void)NewsButton{
    UIImage* image = [[UIImage imageNamed:PIC_MESSAGE_UNREAD]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(newsFUNc)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)NOneNewsButton{
    UIImage* image = [[UIImage imageNamed:PIC_NEWS] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(newsFUNc)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)newsFUNc{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [self openEachWkVcWithId:[[PortalHelper sharedInstance] get_Globaldata].myNewsUrl];
    } else {
        [self openLoginView:nil];
    }
}
- (void)setUpFUNc{
    SetUpVc *vc = [SetUpVc new];
    [self OPenVc:vc];
}
- (void)hideBottomBarWhenPush{}
@end
