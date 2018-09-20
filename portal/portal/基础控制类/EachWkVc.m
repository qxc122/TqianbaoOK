//
//  EachWkVc.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "EachWkVc.h"
#import "PortalHelper.h"
#import "Z_PopView.h"
//#import "shareTo.h"
#import "HeaderAll.h"
#import "NSDictionary+Add.h"
#import "RechargeVc.h"
#import "WithdrawCashVc.h"
#import "RealNameVc.h"
#import "ChatViewController.h"

#import "RealNameBaoVc.h"
#import "SmsVc.h"
#import "RiskManagementVc.h"
#import "turnOutVc.h"
#import "turnIntoVc.h"
#import "SignInVc.h"
#import "EmployeeLoanVc.h"
#import "popSelecetView.h"
#import "MOTMutablePopView.h"
#import "WithdrawCashVc.h"
#import "RechargeVc.h"




@interface EachWkVc ()<WKScriptMessageHandler>
@property (nonatomic,strong) NSString *smsSendOKFlag; //验证码发送成功标志
@property (nonatomic,strong) NSString *smsCode;

@property (strong, nonatomic) Z_PopView *popView;
//@property (nonatomic, assign) BOOL isSelected;
@property (weak, nonatomic) UIButton *btnRight;
//@property (weak, nonatomic) shareTo *shareToview;

@property (assign, nonatomic) BOOL isCollection;

@property (assign, nonatomic) BOOL isNeedRefresh;


@property (strong, nonatomic) NSDictionary *payData;

@property (nonatomic,strong) NSString *preMainurl;

@property (nonatomic,assign) BOOL H5jumplogin;
@property (nonatomic,assign) BOOL H5jumploginING;

@property (weak, nonatomic) UIView *targetView;
@property (weak, nonatomic) popSelecetView *popselecetView;


@property (nonatomic,assign) BOOL Loan;
@property (nonatomic,assign) BOOL MyLoanRecordList;
@property (nonatomic,assign) BOOL MyLoan;
@end


@implementation EachWkVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNeedRefresh = NO;
        self.IsHaveRightBtn = NO;
        self.H5jumplogin = NO;
        self.verifyCodetype = @"10";
    }
    return self;
}
//callThePasswordBox(orderId:'订单号'   ，orderPrice:'订单金额'    ，  orderDesc:''订单描述)
//callbackForThePasswordBox(staue:'1'：description:'支付成功' )    staue:  '1' 支付成功  ‘0’ 支付失败    -1 放弃支付       description  支付相关的详细描述，如‘支付成功’，‘取消支付’，'支付失败'
- (void)setCokie{
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"isDisplayFinancialBack"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"recharge"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"withdraw"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"login"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"hideWebBack"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"callThePasswordBox"];
    
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"backWeb"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"backRootWeb"];
    
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"finishWeb"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"displayFinancialButton"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"refreshBalance"];
    
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"Gototherealname"];  //去实名
    
    
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"OpenNewWkWebview"]; //打开新页面
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"jumpWebUrl"]; //打开新页面

    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"callPhone"]; //打电话
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"contactCustomerService"]; //客服
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"contactTpurseCustomerService"]; //客服
    
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"employeeLoanApply"]; //借
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"employeeLoanRepayment"]; //还
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"employeeLoanAdvanceRepayment"]; //还

    
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"turnIntoPage"]; //腾邦宝转入页面
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"turnOutPage"]; //腾邦宝转出页面

    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"MyLoanRecordList"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"MyLoan"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"TempustreasureBtn"];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].userId;
    if (userId && userId.length) {
        [parameters setObject:userId forKey:@"userId"];
    }else{
        [parameters setObject:@"" forKey:@"userId"];
    }
    
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    if (accessToken && accessToken.length) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }else{
        [parameters setObject:@"" forKey:@"accessToken"];
    }
    
    NSString *sessionContext = [parameters dictionaryToJsonForH5];;
    NSString *cookieStr = [NSString stringWithFormat:@"document.cookie = 'sessionContext=%@'",sessionContext];
    WKUserScript * cookieScript = [[WKUserScript alloc]
                                   initWithSource:cookieStr
                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    
    self.config = config;
    NSLog(@"sdf");
}
//- (void)popSelf{
//    if ([self.webView canGoBack]) {
//        [self.webView goBack];
//    } else {
//        [super popSelf];
//    }
//}
- (void)popSelf{
    if (self.isCloseBack && [self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad{
    [self setCokie];
    [super viewDidLoad];
    if (self.IsHaveRightBtn) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.btnRight = btn;
        [btn setImage:[UIImage imageNamed:SHARE_BLACK_PICTURES] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
#ifdef DEBUG
//    UIBarButtonItem* rightBarutton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", @"") style:UIBarButtonItemStylePlain target:self action:@selector(saveFUNc)];
//    self.navigationItem.rightBarButtonItem = rightBarutton;
#endif
}
#ifdef DEBUG
- (void)saveFUNc{
    //执行js
    [self.webView evaluateJavaScript:@"window.webkit.messageHandlers.finishWeb.postMessage('1')" completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        } else {
            NSLog(@"成功");
        }
    }];
}
#endif
- (void)rightBtn{
//    if (_popView) {
//        [self remove_popView];
//    } else {
//        if (!self.shareToview) {
//            [self CreatpopView];
//            [_popView showInView:self.view baseView:self.btnRight withPosition:ZShowBottom];
//        }
//    }
}
#pragma --mark< 去分享 >
- (void)remove_popView{
    kWeakSelf(self);
    [UIView animateWithDuration:.3 animations:^{
        [weakself.popView setAlpha:0];
    } completion:^(BOOL finished) {
        [weakself.popView removeFromSuperview];
        weakself.popView =  nil;
    }];
}





#pragma --mark< 去收藏 >
- (void)GOCollection{
    if (self.isCollection) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"You have already collected ~!", @"You have already collected ~!") toView:self.view];
    }else{
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"In collection...", @"In collection...") toView:self.view];
        [[ToolRequest sharedInstance]URLBASIC_portaladdFavoriteWithmerchId:self.merchId title:self.merchName url:self.url sssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:NSLocalizedString(@"Successful collection", @"Successful collection") toView:weakself.view];
            weakself.isCollection = YES;
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //接受传过来的消息从而决定app调用的方法
    NSString *method = message.name;
    NSLog(@"method=%@",method);
    if ([method isEqualToString:@"recharge"]) {
        [self jumprecharge:message.body];
    }else if ([method isEqualToString:@"withdraw"]){
        [self jumpwithdraw:message.body];
    }else if ([method isEqualToString:@"isDisplayFinancialBack"]){
        [self jumpisDisplayFinancialBack:message.body];
    }else if ([method isEqualToString:@"login"]){
        self.H5jumplogin = YES;
        [self jumplogin:message.body];
    }else if ([method isEqualToString:@"OpenNewWkWebview"] || [method isEqualToString:@"jumpWebUrl"]){
        [self OpenNewWkWebview:message.body];
    }else if ([method isEqualToString:@"callPhone"]){
        if ([message.body isKindOfClass:[NSString class]]) {
            NSString *Tel=[[NSMutableString alloc] initWithFormat:@"tel:%@",message.body];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:Tel]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Tel]];
            }
        }
    }else if ([method isEqualToString:@"finishWeb"]){
        [self jumpfinishWeb:message.body];
    }else if ([method isEqualToString:@"backWeb"]){
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }
    }else if ([method isEqualToString:@"displayFinancialButton"]){
//        [self jumpdisplayFinancialButton:message.body];
    }else if ([method isEqualToString:@"refreshBalance"]){

    }else if ([method isEqualToString:@"hideWebBack"]){
        [self jumphideWebBack:message.body];
    }else if ([method isEqualToString:@"callThePasswordBox"]){
        [self jumpcallThePasswordBox:message.body];
    }else if ([method isEqualToString:@"backRootWeb"]){
        if (self.webView.backForwardList.backList.count >=1) {
            [self.webView goToBackForwardListItem:[self.webView.backForwardList.backList firstObject]];
        }
    }else if ([method isEqualToString:@"contactCustomerService"] || [method isEqualToString:@"contactTpurseCustomerService"]){
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            if ([PortalHelper sharedInstance].isReachable) {
                BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                if (!isAutoLogin) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        EMError *error = [[EMClient sharedClient] loginWithUsername:[[PortalHelper sharedInstance]get_userInfo].easemobId password:@"111111"];
                        NSLog(@"sdf");
                    });
                }
                ChatViewController *tmpVc = [[ChatViewController alloc]initWithConversationChatter:@"kefu" conversationType:EMConversationTypeChat];
                [self OPenVc:tmpVc];
            } else {
                [MBProgressHUD showError:@"网络连接异常，请检查网络"];
            }
        } else {
            [MBProgressHUD showPrompt:@"请先登录"];
            [self openLoginView:nil];
        }
    }else if ([method isEqualToString:@"employeeLoanApply"]){ //借
        [self employeeLoanApplyFunc:message.body];
    }else if ([method isEqualToString:@"employeeLoanRepayment"] || [method isEqualToString:@"employeeLoanAdvanceRepayment"]){ //还
        if ([method isEqualToString:@"employeeLoanAdvanceRepayment"]) {
            self.Advance  =@"1";
        } else if([method isEqualToString:@"employeeLoanRepayment"]){
            self.Advance  =@"0";
        }
        [self employeeLoanRepaymentFunc:message.body];
    }else if ([method isEqualToString:@"turnIntoPage"]){    //转入
        [self turnIntoPageFunc:message.body];
    }else if ([method isEqualToString:@"turnOutPage"]){ //转出
        [self turnOutPageFunc:message.body];
    }else if ([method isEqualToString:@"MyLoan"]){    //显示/隐藏 我的借款 文字按钮 @“1” 显示，其他任何情况隐藏
        NSString *tmp = message.body;
        if ([tmp isKindOfClass:[NSString class]] && [tmp isEqualToString:@"1"]) {
            [self setRightForH5MyLoan];
            self.MyLoan = YES;
        } else {
            self.MyLoan = NO;
            [self reMoveRightForH5];
        }
        self.Loan = YES;
    }else if ([method isEqualToString:@"MyLoanRecordList"]){ //显示/隐藏 借款记录 圆点按钮  @“1” 显示，其他任何情况隐藏
        NSString *tmp = message.body;
        if ([tmp isKindOfClass:[NSString class]] && [tmp isEqualToString:@"1"]) {
            [self setRightForH5MyLoanRecordList];
            self.MyLoanRecordList = YES;
        } else {
            self.MyLoanRecordList = NO;
            [self reMoveRightForH5];
        }
        self.Loan = YES;
    }else if ([method isEqualToString:@"Gototherealname"]){
        [self OPenVc:[RealNameVc new]];
    }else if ([method isEqualToString:@"TempustreasureBtn"]){
        [self TempustreasureFunc:message.body];
    }
}

/////腾邦宝  按钮
- (void)TempustreasureFunc:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSString class]]) {
        NSString *tmp = dic;
        if ([tmp isEqualToString:@"1"]) {
            UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"bao账单"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
            right1.accessibilityIdentifier = @"list";
            
            //为导航栏添加右侧按钮2
            UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"疑问"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
            right2.accessibilityIdentifier = @"help";
            
            NSArray *arr = [[NSArray alloc]initWithObjects:right1, right2, nil];
            self.navigationItem.rightBarButtonItems = arr;
        } else {
            self.navigationItem.rightBarButtonItems = nil;
        }
    }
}

- (void)rightAction:(UIBarButtonItem *)btn{
    if ([btn.accessibilityIdentifier isEqualToString:@"list"]) {
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            EachWkVc *vc = [EachWkVc new];
            vc.url = [[PortalHelper sharedInstance]get_Globaldata].fundBillUrl;
            [self OPenVc:vc];
        } else {
            kWeakSelf(self);
            [self openLoginView:^{
                [weakself rightAction:btn];
            }];
        }
    } else if ([btn.accessibilityIdentifier isEqualToString:@"help"]) {
        EachWkVc *vc = [EachWkVc new];
        vc.url = [[PortalHelper sharedInstance]get_Globaldata].fundQaUrl;
        [self OPenVc:vc];
    }
}
///////腾邦宝结束



/////////
- (void)employeeLoanApplyFunc:(NSDictionary *)dic{

}
/////////////////


/////////////////
- (void)employeeLoanRepaymentFunc:(NSDictionary *)dic{

}
/////////////////

- (NSDictionary *)ProcessingJSdata:(NSDictionary *)body{
    NSDictionary *tmp;
    if ([body isKindOfClass:[NSDictionary class]]) {
        tmp = body;
    }else if ([body isKindOfClass:[NSString class]]) {
        NSString *tim = (NSString *)body;
        tmp= [tim dictionaryWithJsonString];
    }
#ifdef DEBUG
    NSString *strTmp = [tmp DicToJsonstr];
    NSLog(@"strTmp=%@",strTmp);
#endif
    return tmp;
}


- (void)turnOutPageFunc:(NSDictionary *)dic{
    [self OpenRealNameBaoVcORRealNameVcORSmsVcORRiskManagementVc:NO body:dic];
}
- (void)turnIntoPageFunc:(NSDictionary *)dic{
    [self OpenRealNameBaoVcORRealNameVcORSmsVcORRiskManagementVc:YES  body:dic];
}

-(void)OpenRealNameBaoVcORRealNameVcORSmsVcORRiskManagementVc:(BOOL)isIN body:(NSDictionary *)body{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        NSDictionary *tmp;
        if ([body isKindOfClass:[NSDictionary class]]) {
            tmp = body;
        }else if ([body isKindOfClass:[NSString class]]) {
            NSString *tim = (NSString *)body;
            tmp= [tim dictionaryWithJsonString];
        }
        if (tmp) {
            if ([body isKindOfClass:[NSDictionary class]] &&  [body[@"jumpFlag"] isEqualToString:@"0"]) {
                if ([body[@"isEvaluate"] isEqualToString:@"0"]) {
                    RiskManagementVc *vc = [RiskManagementVc new];
                    vc.url = body[@"url"];
                    [self OPenVc:vc];
                }else{
                    [self OpenturnOutVcORturnIntoVc:isIN];
                }
            } else if ([body isKindOfClass:[NSDictionary class]] &&  [body[@"jumpFlag"] isEqualToString:@"1"]) {
                if ([body[@"isEvaluate"] isEqualToString:@"0"]) {
                    RealNameBaoVc *vc = [RealNameBaoVc new];
                    vc.filterFlag = @"1";
                    vc.url = body[@"url"];
                    [self OPenVc:vc];
                }else{
                    RealNameVc *vc = [RealNameVc new];
                    vc.filterFlag = @"1";
                    if (isIN) {
                        vc.WillOpenVcs = @[[turnIntoVc class]];
                    }else{
                        vc.WillOpenVcs = @[[turnOutVc class]];
                    }
                    [self OPenVc:vc];
                }
            } else if ([body isKindOfClass:[NSDictionary class]] &&  [body[@"jumpFlag"] isEqualToString:@"2"]) {
//                SmsVc *vc = [SmsVc new];
//                vc.isEvaluate = [body[@"isEvaluate"] boolValue];
//                vc.url = body[@"url"];
//                if (vc.isEvaluate) {
//                    if (isIN) {
//                        vc.WillOpenVcs = @[[turnIntoVc class]];
//                    }else{
//                        vc.WillOpenVcs = @[[turnOutVc class]];
//                    }
//                }
//                [self OPenVc:vc];
                
                if ([body[@"isEvaluate"] isEqualToString:@"0"]) {
                    RealNameBaoVc *vc = [RealNameBaoVc new];
                    vc.filterFlag = @"1";
                    vc.url = body[@"url"];
                    [self OPenVc:vc];
                }else{
                    RealNameVc *vc = [RealNameVc new];
                    vc.filterFlag = @"1";
                    if (isIN) {
                        vc.WillOpenVcs = @[[turnIntoVc class]];
                    }else{
                        vc.WillOpenVcs = @[[turnOutVc class]];
                    }
                    [self OPenVc:vc];
                }
            }else{
                
            }
        } else {
            [self OpenturnOutVcORturnIntoVc:isIN];
        }
    }else{
        kWeakSelf(self);
        [self openLoginView:^{
            [weakself OpenRealNameBaoVcORRealNameVcORSmsVcORRiskManagementVc:isIN body:body];
        }];
    }
}
-(void)OpenturnOutVcORturnIntoVc:(BOOL)isIN{
    if (isIN) {
        [self OPenVc:[turnIntoVc new]];
    }else{
        [self OPenVc:[turnOutVc new]];
    }
}
- (void)RightForH5Btn:(UIBarButtonItem *)btn{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        if ([btn.accessibilityIdentifier isEqualToString:@"MyLoan"]) {
            EmployeeLoanVc *vc = [EmployeeLoanVc new];
            vc.url = [[PortalHelper sharedInstance]get_Globaldata].myLoanUrl;
            [self OPenVc:vc];
            
//            [self openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].myLoanUrl];
        } else if ([btn.accessibilityIdentifier isEqualToString:@"MyLoanRecordList"]) {
            [self popselecetPopView];
        }
    } else {
        [MBProgressHUD showPrompt:@"请先登录"];
        kWeakSelf(self);
        [self openLoginView:^{
            [weakself RightForH5Btn:btn];
        }];
    }
}

////////我的贷款页面//////////////////
- (void)popselecetPopView{
    if (self.popselecetView) {
        [self.popselecetView closeClisck];
    }else{
        CGFloat tmp = 20;
        if (IPoneX) {
            tmp += 20;
        }
        UIView *targetView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH-44-20, tmp, 44, 44)];
        self.targetView = targetView;
        
        MOTPopConfig *config = [MOTPopConfig new];
        config.size = CGSizeMake(104, 40);
        config.targetView = self.targetView;
        config.isAuto = NO;
        config.tabColor = [UIColor whiteColor];
        config.isAuto = NO;
        config.vX = SCREENWIDTH-30;
        
        UIButton *Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 104, 40)];
        [Btn1 setWithNormalColor:0x1E2E47 NormalAlpha:1 NormalTitle:NSLocalizedString(@" 借还记录", @"") NormalImage:@"借还记录图标" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [config addView:Btn1];
        
        kWeakSelf(self);
        [MOTMutablePopView popWithConfig:config  ClickIndexBlock:^(NSUInteger index) {
            NSLog(@"%s",__func__); //100
            if (index<100) {
                EmployeeLoanVc *vc = [EmployeeLoanVc new];
                vc.url = [[PortalHelper sharedInstance]get_Globaldata].myLoanRecordUrl;
                [weakself OPenVc:vc];
                
//                [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].myLoanRecordUrl];
//                [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].finBillUrl];
            }
        }];
    }
}
//////////////////////////////

- (void)setRightForH5MyLoan{
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithTitle:@"我的借款" style:UIBarButtonItemStylePlain target:self action:@selector(RightForH5Btn:)];
    right2.tintColor = [UIColor colorWithRed:227/255.0 green:191/255.0 blue:124/255.0 alpha:1/1.0];
    right2.accessibilityIdentifier = @"MyLoan";
    self.navigationItem.rightBarButtonItem = right2;
}
- (void)setRightForH5MyLoanRecordList{
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"更多按钮"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(RightForH5Btn:)];
    right2.accessibilityIdentifier = @"MyLoanRecordList";
    self.navigationItem.rightBarButtonItem = right2;
}
- (void)reMoveRightForH5{
    self.navigationItem.rightBarButtonItem = nil;
}
//employeeLoanApply    借
//employeeLoanRepayment  还
//contactTpurseCustomerService  联系客服

//腾邦宝转入页面   turnIntoPage(WebView webView)
//腾邦宝转出页面   turnOutPage(WebView webView)

- (void)jumpcallThePasswordBox:(NSDictionary *)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        self.payData = dic;
    }else if ([dic isKindOfClass:[NSString class]]) {
        NSString *tim = (NSString *)dic;
        self.payData = [tim dictionaryWithJsonString];
    }
    if (self.payData[@"ordNo"] && self.payData[@"ordMoney"]) {
        if ([self.payData[@"ordMoney"] doubleValue] >= 1000) {
            [self sendSmsCodebindId:0 Money:[self.payData[@"ordMoney"] doubleValue] codeId:nil];
        } else {
            [self OpenPasswordpaymentbox]; //
        }
    } else {
        [MBProgressHUD showPrompt:@"缺少参数" toView:self.view];
    }
}


- (void)jumphideWebBack:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    NSString *str = (NSString *)dic;
    if ([str isKindOfClass:[NSString class]] && [str isEqualToString:@"1"]) {
        [self customBackButton];
    } else {
        UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = leftBarutton;
    }
}
    
- (void)jumpfinishWeb:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    if ([self.navigationController.topViewController isEqual:self]) {
        NSString *isNeedRefresh = (NSString *)dic;
        if ([isNeedRefresh isKindOfClass:[NSString class]] && self.navigationController.childViewControllers.count>=2) {
            EachWkVc *ttmp = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count-2];
            if ([ttmp isKindOfClass:[EachWkVc class]]) {
                if ([isNeedRefresh isEqualToString:@"1"]) {
                    ttmp.isNeedRefresh = YES;
#ifdef DEBUG
//                    [MBProgressHUD showPrompt:@"我收到了H5要刷新de消息"];
#endif
                } else {
                    ttmp.isNeedRefresh = NO;
                }
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)jumpdisplayFinancialButton:(NSDictionary *)dic{
//    NSLog(@"%@",dic);
//}
//recharge(type)  //充值方法 "rechargeBalance"(余额充值),"financialManageBalance"(理财充值)
- (void)jumprecharge:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    if ([dic isKindOfClass:[NSString class]]) {
        NSString *tpm = (NSString *)dic;
        if ([tpm isEqualToString:@"rechargeBalance"]) {
            if ([[[PortalHelper sharedInstance]get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
                RechargeVc *vc = [RechargeVc new];
                vc.load_type = WithdrawCashVc_load_type_NONE;
                [self OPenVc:vc];
            }else{
                [MBProgressHUD showPrompt:@"请先实名认证"];
                [self OpneRealNameVc];
            }
        } else if ([tpm isEqualToString:@"financialManageBalance"]) {
            RechargeVc *vc = [RechargeVc new];
            vc.load_type = WithdrawCashVc_load_type_H5;
            [self OPenVc:vc];
        }
    }
}
//withdraw(type)  //提现方法 "withdrawBalance"(余额提现),"WithdrawFinancialManageBalance"(理财提现)
- (void)jumpwithdraw:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    if ([dic isKindOfClass:[NSString class]]) {
        NSString *tpm = (NSString *)dic;
        if ([tpm isEqualToString:@"withdrawBalance"]) {
            if ([[[PortalHelper sharedInstance]get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
                WithdrawCashVc *vc = [WithdrawCashVc new];
                vc.load_type = WithdrawCashVc_load_type_NONE;
                vc.stateMoney = RechargeandcashwithdrawalVcState_WithdrawCash;
                [self OPenVc:vc];
            }else{
                [MBProgressHUD showPrompt:@"请先实名认证"];
                [self OpneRealNameVc];
            }
        } else if ([tpm isEqualToString:@"WithdrawFinancialManageBalance"]) {
            WithdrawCashVc *vc = [WithdrawCashVc new];
            vc.load_type = WithdrawCashVc_load_type_H5;
            vc.stateMoney = RechargeandcashwithdrawalVcState_WithdrawCash;
            [self OPenVc:vc];
        }
    }
}
- (void)OpneRealNameVc{
    RealNameVc *vc = [RealNameVc new];
    [self OPenVc:vc]; 
}
- (void)jumpisDisplayFinancialBack:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    [MBProgressHUD showPrompt:@"jumpisDisplayFinancialBack" toView:self.view];
}
- (void)jumplogin:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [MBProgressHUD showPrompt:@"您已经登录" toView:self.view];
    } else {
        NSString *tmp = (NSString *)dic;
        if ([tmp isKindOfClass:[NSString class]] && [tmp isEqualToString:@"RealName"]) {
            SignInVc *losgin = [[SignInVc alloc]init];
            losgin.WillOpenVcs = @[[RealNameVc class]];
            [self OPenVc:losgin];
        } else {
            [self openLoginView:nil];
        }
    }
}
//# 与原生交互
//
//recharge(type)  //充值方法 "rechargeBalance"(余额充值),"financialManageBalance"(理财充值)
//withdraw(type)  //提现方法 "withdrawBalance"(理财提现),"WithdrawFinancialManageBalance"(理财提现)
//
//isDisplayFinancialBack(boolean)  //顶部菜单栏显示返回按钮
//
//login();  //登录方法


//- (void)jumpPay:(NSString *)body{
//    if ([body isKindOfClass:[NSString class]]) {
//        payPre *data = [payPre mj_objectWithKeyValues:body];
//        if (data.sysId && data.sign && data.timestamp && data.v && data.orderId) {
//            CashierVc *payVc = [[CashierVc alloc]init];
//            payVc.data = data;
//            kWeakSelf(self);
//            payVc.Successblock = ^(NSDictionary *dic) {
//                if ([dic[PAYMENT_STATUS_NOTE] integerValue]== CANCEL_PAYMENT_STATUS) {
//                    [weakself Execute_the_JS_statementWith:@"payCancel()"];
//                } else {
//                    NSDictionary *dicRes = @{@"retStatus":dic[PAYMENT_STATUS_NOTE],@"errorCode":@"100",@"errorMsg":dic[PAYMENT_STATUS_NOTESTR]};
//                    NSString *jsStr = [NSString stringWithFormat:@"payFinish('%@')",[dicRes dictionaryToJsonForH5]];
//                    [weakself Execute_the_JS_statementWith:jsStr];
//                }
//            };
//            [self.navigationController pushViewController:payVc animated:YES];
        

//            UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:payVc];;
//            [self presentViewController:nnvc animated:YES completion:nil];
//        } else {
//            [MBProgressHUD showPrompt:NSLocalizedString(@"The argument for the jumpPay method is not valid", @"The argument for the jumpPay method is not valid") toView:self.view];
//        }
//    }else{
//        [MBProgressHUD showPrompt:NSLocalizedString(@"The argument for the jumpPay method is not valid", @"The argument for the jumpPay method is not valid") toView:self.view];
//    }
//}

- (void)Execute_the_JS_statementWith:(NSString *)str{
    [self.webView evaluateJavaScript:str completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        }else{
            NSLog(@"成功");
        }
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}
//- (void)Land:(NSDictionary *)body{
//    kWeakSelf(self);
//    [self openLoginViewisCacel:^(NSString *isCacel) {
//        if ([isCacel isEqualToString:STRING_1]) {
//            [weakself Execute_the_JS_statementWith:@"loginCancel()"];
//        } else if ([isCacel isEqualToString:STRING_0]){
//            NSDictionary *dicRes = @{@"retStatus":@"0",@"errorCode":@"100",@"errorMsg":@"",@"userId":[PortalHelper sharedInstance].userInfo.userId,@"sign":@""};
//            NSString *jsStr = [NSString stringWithFormat:@"loginFinish('%@')",[dicRes dictionaryToJsonForH5]];
//            [weakself Execute_the_JS_statementWith:jsStr];
//        }
//    }];
//}

#pragma --mark< OpenEachWkVc >
- (void)OpenNewWkWebview:(NSDictionary *)body{
    EachWkVc *vc = [EachWkVc new];
//    vc.url = body[@"url"];
    if ([body isKindOfClass:[NSString class]]) {
        vc.url = body;
    }else if ([body isKindOfClass:[NSDictionary class]]) {
        vc.url = body[@"url"];
        NSString *tmp = body[@"isClose"];
        if (tmp && tmp.length && [tmp isEqualToString:@"back"]) {
            vc.isCloseBack = YES;
        } else {
            vc.isCloseBack = NO;
        }
    }
    [self OPenVc:vc]; 
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    if (self.shareToview) {
//        [self.shareToview closeClisck];
//    }
    if (self.popselecetView) {
        [self.popselecetView closeClisck];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.isdisVIew = YES;
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (self.isNeedRefresh) {
//#ifdef DEBUG
////        [MBProgressHUD showPrompt:@"我要刷新了"];
//#endif
//        [self.webView reloadFromOrigin];
//        self.isNeedRefresh = NO;
//    }
//    self.H5jumploginING = YES;
//    if (self.isdisVIew /*&& ![self.title isEqualToString:@"购买"]*/) {
//        self.isdisVIew = NO;
//        if (self.isNeedRefreshForNet) {
//            self.url = self.url;
//        } else {
//            [self.webView reload];
//        }
//    }
//}

- (void)load100{
    if (self.H5jumploginING && self.H5jumplogin) {
        self.H5jumploginING = NO;
        [self resentCokie];
    }
}
- (void)CreatpopView{
    if (!_popView) {
        kWeakSelf(self);
        _popView = [[Z_PopView alloc] initWithArray:@[NSLocalizedString(@"share", @"share"),NSLocalizedString(@"Collection", @"Collection")] WithImageArray:@[SHARE_POPVIEW,COLLECTION_POPVIEW]];
        _popView.chooseBlock = ^(NSString *chooseItem) {
            [weakself remove_popView];
            if ([chooseItem isEqualToString:NSLocalizedString(@"share", @"share")]) {
                
            } else if ([chooseItem isEqualToString:NSLocalizedString(@"Collection", @"Collection")]) {
//                if ([PortalHelper sharedInstance].userInfo) {
//                    [weakself GOCollection];
//                }else{
//                    [weakself openLoginView:^{
//                        [weakself GOCollection];
//                    }];
//                }
            }
        };
    }
}

- (void)setsessionContext{
    NSString *JSFuncString = @"function setCookieIOS(name,value,expires,urlpath)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/tpurse/h5/dist'\
    }";
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].authenUserId;
    if (userId && userId.length) {
        [parameters setObject:userId forKey:@"userId"];
    }else{
        [parameters setObject:@"" forKey:@"userId"];
    }
    NSString *authenUserId = [[PortalHelper sharedInstance]get_userInfo].authenUserId;
    if (authenUserId && authenUserId.length) {
        [parameters setObject:authenUserId forKey:@"authenUserId"];
    }else{
        [parameters setObject:@"" forKey:@"authenUserId"];
    }
    [parameters setObject:@"1" forKey:@"stepCode"];
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    if (accessToken && accessToken.length) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }else{
        [parameters setObject:@"" forKey:@"accessToken"];
    }

    
    NSString *sessionContext = [parameters dictionaryToJsonForH5];
    //    NSString *cookieStr = [NSString stringWithFormat:@"document.cookie = 'sessionContext=%@'",sessionContext];
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    //    NSString *excuteJSStringDE1 = [NSString stringWithFormat:@"delCookieIOS('sessionContext');"];
    
    
    NSString *excuteJSString1 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1,self.pathh);", @"sessionContext",sessionContext];
    
    //    [JSCookieString appendString:excuteJSStringDE1];
    [JSCookieString appendString:excuteJSString1];
    
    //执行js
    [self.webView evaluateJavaScript:JSCookieString completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        } else {
            //            [self.webView reload];
            NSLog(@"成功");
        }
    }];
}
- (void)resentCokie{
    
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    kWeakSelf(self);
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         NSInteger index = 0;
                         for (WKWebsiteDataRecord *record  in records){
                             [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                       forDataRecords:@[record]
                                                                    completionHandler:^{
                                                                        if ((records.count - 1) == index) {
                                                                            [weakself setsessionContext];
                                                                        }
                                                                        NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                    }];
                             index++;
                         }
                     }];
    
    

    
    
    
//    if (self.webView.backForwardList.backList.count >=1) {
//        [self.webView goToBackForwardListItem:[self.webView.backForwardList.backList firstObject]];
//    }
//    //    [self setUserScripts];
//    //    if (self.webView.isLoading) {
//    //        [self.webView stopLoading];
//    //        [self.webView reload];
//    //    }
//    //    return;
//    //js函数
//    NSString *JSFuncString =
//    @"function setCookieIOS(name,value,expires)\
//    {\
//    var oDate=new Date();\
//    oDate.setDate(oDate.getDate()+expires);\
//    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
//    }\
//    function getCookieIOS(name)\
//    {\
//    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
//    if(arr != null) return unescape(arr[2]); return null;\
//    }\
//    function delCookieIOS(name)\
//    {\
//    var exp = new Date();\
//    exp.setTime(exp.getTime() - 1);\
//    var cval=getCookieIOS(name);\
//    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
//    }";
//
//
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
//    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
//    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
//    [parameters setObject:PORTALVERSION forKey:@"version"];
//
//    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].userId;
//    if (userId && userId.length) {
//        [parameters setObject:userId forKey:@"userId"];
//    }else{
//        [parameters setObject:@"" forKey:@"userId"];
//    }
//
//    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
//    if (accessToken && accessToken.length) {
//        [parameters setObject:accessToken forKey:@"accessToken"];
//    }else{
//        [parameters setObject:@"" forKey:@"accessToken"];
//    }
//
//    NSString *sessionContext = [parameters dictionaryToJsonForH5];
//
//    //    NSString *cookieStr = [NSString stringWithFormat:@"document.cookie = 'sessionContext=%@'",sessionContext];
//
//
//    //拼凑js字符串
//    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
//    NSString *excuteJSStringDE1 = [NSString stringWithFormat:@"delCookieIOS('sessionContext');"];
//
//
//    NSString *excuteJSString1 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1);", @"sessionContext",sessionContext];
//
//    [JSCookieString appendString:excuteJSStringDE1];
//    [JSCookieString appendString:excuteJSString1];
//
//    //执行js
//    [self.webView evaluateJavaScript:JSCookieString completionHandler:^(id data, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"失败:%@",error.description);
//        } else {
//            NSLog(@"成功");
//        }
//    }];
}
- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
    [self resentCokie];
}
#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    [self resentCokie];
}




- (void)payFailWith:(NSInteger)errorCode :(NSString *)msg{
    if (errorCode == kRespondCodePassworderror) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself PasswordRetrieval];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself retryPay];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (errorCode == kRespondCodePasswordinputmultipleerrors) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"找回密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself PasswordRetrieval];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)PasswordRetrieval{
    
    NSString *title = @"请联系客服找回密码，客服电话";
    NSString *des = @"分机号:";
    if ([[PortalHelper sharedInstance]get_Globaldata].customerServicePhone.length == 18) {
        title = [title stringByAppendingString:[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringToIndex:13]];
        des= [des stringByAppendingString:[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringFromIndex:14]];
        UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:title message:des preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // 点击‘取消’，做点事情
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[[[PortalHelper sharedInstance]get_Globaldata].customerServicePhone substringToIndex:13]];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }];
        
        [showAlert addAction:action1];
        [showAlert addAction:action2];
        
        [self presentViewController:showAlert animated:YES completion:nil];
    }
}
- (void)retryPay{
    if (self.boxview) {
        [self.boxview firstINput];
    } else {
        [self OpenPasswordpaymentbox];
    }
}


- (void)OpenPasswordpaymentbox{
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
    Passwordpaymentbox *view = [Passwordpaymentbox new];
    self.boxview = view;
    kWeakSelf(self);
    view.Fill_in_the_text = ^(NSString *inText) {
        //        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = Height_keyboardDistanceFromTextField;
        [weakself Passwordinputsuccessful:inText];
        //        [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    };
    view.cannelPay = ^{
        [weakself cannelPay];
    };
    view.changePassWord = ^{
        [weakself PasswordRetrieval];
    };
//    [view windosViewshow];
    UIView *tmp = self.view;
    [view windosViewshowWithsubView:tmp];
}

- (void)sendSmsCodebindId:(NSInteger )bindId Money:(double)money codeId:(NSString *)codeId{
    if ([self.smsSendOKFlag isEqualToString:@"1"]) {
        self.Verificationbox.hidden = NO;
        if ([self.Verificationbox.codeInput canBecomeFirstResponder]) {
            [self.Verificationbox.codeInput becomeFirstResponder];
        }
        [MBProgressHUD showPrompt:@"验证码已发送!" toView:self.view];
    } else {
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:@"发送短信验证吗中..." toView:self.view];
        [[ToolRequest sharedInstance]moneySystemsendVerifyCodeWithmobile:[[PortalHelper sharedInstance] get_userInfo].bankMobile type:self.verifyCodetype bindId:bindId money:money codeId:codeId success:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.smsSendOKFlag = @"1";
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:@"发送成功" toView:weakself.view];
            if (!weakself.Verificationbox) {
                [weakself OpenVerificationCodeBox];
            }else{
                weakself.Verificationbox.hidden = NO;
                if ([weakself.Verificationbox.codeInput canBecomeFirstResponder]) {
                    [weakself.Verificationbox.codeInput becomeFirstResponder];
                }
            }
            [weakself.Verificationbox creatTimer];
            weakself.Verificationbox.resendSmsCode = ^{
                [weakself sendSmsCodebindId:bindId Money:money codeId:codeId];
            };
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }
}
- (void)OpenVerificationCodeBox{
    //    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
    VerificationCodeBox *view = [VerificationCodeBox new];
    self.Verificationbox = view;
    kWeakSelf(self);
    view.Fill_in_the_text = ^(NSString *inText) {
        weakself.smsCode = inText;
        [weakself checkVerifyCodeWithtype];
    };
    view.cannelPay = ^{
        [weakself cannelPay];
    };
    view.timeOut = ^{
        weakself.smsSendOKFlag = nil;
    };
    UIView *tmp = self.view;
    [view windosViewshowWithsubView:tmp];
}
- (void)checkVerifyCodeWithtype{
    [MBProgressHUD showLoadingMessage:@"验证码校验中..." toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpursesystemcheckVerifyCodeWithtype:self.verifyCodetype verifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        weakself.Verificationbox.hidden = YES;
        if (weakself.Verificationbox.codeInput.isFirstResponder) {
            [weakself.Verificationbox.codeInput resignFirstResponder];
        };
        [weakself OpenPasswordpaymentbox];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}
- (void)cannelPay{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"继续充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
  
    [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself.boxview closeClisck];
        weakself.boxview = nil;
        //        [weakself.Verificationbox closeClisck];
        
        weakself.Verificationbox.hidden = YES;
        if (weakself.Verificationbox.codeInput.isFirstResponder) {
            [weakself.Verificationbox.codeInput resignFirstResponder];
        }
        [weakself callH5Func:@"-1" des:@"取消支付"];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)smsCodeinputsuccessful:(NSString *)inText{
    self.smsCode = inText;
    [self.Verificationbox closeClisck];
    [self OpenPasswordpaymentbox];
}

- (void)callH5Func:(NSString *)staue des:(NSString *)des{
    NSString *tmp;
    if ([staue isEqualToString:@"-1"]) {
        tmp = @"callbackForThePasswordBox('-1','取消支付')";
    } else if ([staue isEqualToString:@"0"]) {
        if (des && des.length) {
            tmp = [NSString stringWithFormat:@"callbackForThePasswordBox('0','%@')",des];
        } else {
            tmp = @"callbackForThePasswordBox('0','支付失败')";
        }
    } else if ([staue isEqualToString:@"1"]) {
        tmp = @"callbackForThePasswordBox('1','支付成功')";
        [self performSelector:@selector(PaySuccess) withObject:nil afterDelay:2.0];
    }
    [self Execute_the_JS_statementWith:tmp];
    
}
- (void)PaySuccess{
    [MBProgressHUD showSuccess:@"充值成功" toView:self.view];
    [self popSelf];
}
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
//    if (self.preMainurl && ![navigationAction.request.URL.host isEqualToString:self.preMainurl]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        [self.webView loadRequest:navigationAction.request];
//        MJExtensionLog(@"sdf");
//    }
//    self.preMainurl = navigationAction.request.URL.host;
//}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    MJExtensionLog(@"navigationAction.request.URL.absoluteString=%@ \n",navigationAction.request.URL.absoluteString);
    
//    if ([navigationAction.request.URL.absoluteString isEqualToString:@"http://m.haidaowang.com/index.html#back_flag"]) {
//        self.title = @"腾邦物流旗下跨境电商-海捣网";
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }else if ([navigationAction.request.URL.absoluteString hasPrefix:@"itms-services://?action=download-manifest"]) {
//        self.web.delegate = self;
//        [self.web loadRequest:navigationAction.request];
//        decisionHandler(WKNavigationActionPolicyCancel);
//        self.failRequest = navigationAction.request;
//        [MBProgressHUD showLoadingMessage:@"正在跳转,请稍侯..."];
//        [self performSelector:@selector(hidHUD) withObject:nil afterDelay:2.0];
//    }else{
    //TODO
    MJExtensionLog(@"navigationAction.request.URL=%@",navigationAction.request.URL);
    if (self.preMainurl && ![navigationAction.request.URL.host isEqualToString:self.preMainurl] && ![navigationAction.request.URL.absoluteString hasPrefix:@"https"]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        [webView stopLoading];
        [self.webView loadRequest:navigationAction.request];
        MJExtensionLog(@"sdf");
    }
    decisionHandler(WKNavigationActionPolicyAllow);
//    }
    self.preMainurl = navigationAction.request.URL.host;
//    if ([self.preMainurl isEqualToString:@"api.map.baidu.com"]) {
//        self.preMainurl = nil;
//    }
    if (self.Loan) {
        if (self.MyLoan || self.MyLoanRecordList) {
            if (self.MyLoan) {
                [self setRightForH5MyLoan];
            } else if (self.MyLoanRecordList) {
                [self setRightForH5MyLoanRecordList];
            }
        } else {
            [self reMoveRightForH5];
        }
    }
}

- (void)Passwordinputsuccessful:(NSString *)inText{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"付款中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_regularFintpurseRechargeWithpayPassword:inText orderId:self.payData[@"ordNo"] orderDesc:self.payData[@"orderDesc"] orderPrice:[self.payData[@"ordMoney"] doubleValue] success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [weakself callH5Func:@"1" des:@"支付成功"];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself.boxview closeClisck];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
        [weakself payFailWith:errorCode :msg];
        [weakself.boxview.input clearUpPassword];
    }];
}
@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
