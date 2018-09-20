//
//  basicVc.m
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"
#import "AFNetworkReachabilityManager.h"
#import "basicUiTableView.h"
#import "NSString+Add.h"
//#import "shareTo.h"
#import "SignInVc.h"
#import "baseWkVc.h"
#import "AuthenticationVc.h"
#import "EachWkVc.h"
#import "GesturecipherVc.h"
#import "RealNameVc.h"
@interface basicVc ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end


@implementation basicVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    [self customBackButton];
    self.view.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    self.empty_type = In_loading_empty_num;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(LOGIN_EXIT_NOTIFICATIONFunC:)
                                                 name:LOGIN_EXIT_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GET_NEW_TOKEN_NOTIFICATIONFunc:)
                                                 name:GET_NEW_TOKEN_NOTIFICATION
                                               object:nil];
}

- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
//    self.FLAG_IN_DATA_UPDATE = YES;
//    [self loadNewData];
}

#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
//    if (![[PortalHelper sharedInstance] get_userInfo] && [self.navigationController.topViewController isEqual:self]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
}
- (void)setRightBtn{
    [self.navigationItem.rightBarButtonItem setTintColor:COLOUR_TITLE_NORMAL];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(15),NSFontAttributeName, nil] forState:UIControlStateHighlighted];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(15),NSFontAttributeName, nil] forState:UIControlStateSelected];
}

- (void)customNavigationBar
{
    // 1.2设置所有导航条的标题颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = PingFangSC_Medium(17);
    md[NSForegroundColorAttributeName] = COLOUR_TITLE_NORMAL;
    [navBar setTitleTextAttributes:md]; 
}

- (void)customBackButton
{
    UIImage* image = [[UIImage imageNamed:PIC_CUSTOM_NAVIGATION_BACK_KING] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)setDZNEmptyDelegate:(id)TabOrColl{
    if ([TabOrColl isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)TabOrColl;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
    }else if ([TabOrColl isKindOfClass:[UICollectionView class]]) {
        UICollectionView *colobleView = (UICollectionView *)TabOrColl;
        colobleView.emptyDataSetSource = self;
        colobleView.emptyDataSetDelegate = self;
    }
}

- (void)popSelf
{
    if (self.WillOpenVcs.count && self.isSuccess) {
        NSInteger index = 0;
        for (Class tmp in self.WillOpenVcs) {
            basicVc *vc = [tmp new];
            if ([vc isKindOfClass:[basicVc class]]) {
                if (![vc isKindOfClass:[RealNameVc class]] || ([vc isKindOfClass:[RealNameVc class]] && ![[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:@"1"])) {
                    if (self.WillOpenVcdatas.count >= index+1) {
                        [vc setValue:self.WillOpenVcdatas[index] forKey:@"defaultData"];
                    }
                    vc.CTrollersToR = @[[self class]];
                    [self OPenVc:vc];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)dealloc{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.sesPro = 1.0f;
        [self hideBottomBarWhenPush];
        self.NodataTitle = NSLocalizedString(@"暂无数据", @"暂无数据");
        self.NodataDescribe = @" ";
    }
    return self;
}
- (void)hideBottomBarWhenPush
{
    self.hidesBottomBarWhenPushed = YES;
}

#pragma -mark<mj_header  头部>
- (MJRefreshHeader *)header{
    if (!_header) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        [header setImages:@[[UIImage imageNamed:@"001"],[UIImage imageNamed:@"002"],[UIImage imageNamed:@"003"],[UIImage imageNamed:@"004"],[UIImage imageNamed:@"005"]] forState:MJRefreshStateIdle];
        // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
//        [header setImages:@[[UIImage imageNamed:@"type1"],[UIImage imageNamed:@"type2"],[UIImage imageNamed:@"type3"],[UIImage imageNamed:@"type4"]] forState:MJRefreshStatePulling];
        // Set the refreshing state of animated images
        [header setImages:@[[UIImage imageNamed:@"01"],[UIImage imageNamed:@"02"],[UIImage imageNamed:@"03"],[UIImage imageNamed:@"04"],[UIImage imageNamed:@"05"],[UIImage imageNamed:@"06"],[UIImage imageNamed:@"07"],[UIImage imageNamed:@"08"],[UIImage imageNamed:@"09"],[UIImage imageNamed:@"10"],[UIImage imageNamed:@"11"],[UIImage imageNamed:@"12"]] forState:MJRefreshStateRefreshing];
        
//        [header setImages:@[[UIImage imageNamed:@"111"],[UIImage imageNamed:@"222"],[UIImage imageNamed:@"333"]] forState:MJRefreshStateRefreshing];
        // Hide the time
        header.lastUpdatedTimeLabel.hidden = YES;
        
        // Hide the status
        header.stateLabel.hidden = YES;
        // Set header
        
        _header = header;
        
//        MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        _header = header;
    }
    return _header;
}

#pragma -mark<加载新数据>
- (void)loadNewData{
    
}
#pragma -mark<加载更多数据>
- (void)loadMoreData{
    
}

#pragma -mark<mj_footer  头部>
- (MJRefreshFooter *)footer{
    if (!_footer) {
        MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _footer = footer;
    }
    return _footer;
}

#pragma --mark<打开登录页面>
- (void)openLoginView:(LoadSuccess)block{
    SignInVc *losgin = [[SignInVc alloc]init];
    losgin.block = block;
    [self OPenVc:losgin];
}

#pragma --mark<打开  baseWkVc 页面>
- (void)openbaseWkVcWithId:(id)url{
    baseWkVc *wkweb = [[baseWkVc alloc]init];
    wkweb.url = url;
    [self OPenVc:wkweb];
}

#pragma --mark<打开  baseWkVc 页面>
- (void)openEachWkVcWithId:(id)url{
    EachWkVc *wkweb = [[EachWkVc alloc]init];
    wkweb.url = url;
    [self OPenVc:wkweb];
}

- (void)OPenVc:(basicVc *)vc{
    UINavigationController *tmp = [[UIApplication sharedApplication]keyWindow].rootViewController;
    if ([tmp isKindOfClass:[UINavigationController class]]) {
        if ([vc isKindOfClass:[basicVc class]]) {
    
            vc.threePay = self.threePay;
        }
        [tmp pushViewController:vc animated:YES];
    }
}

#pragma --mark<打开 支付 页面>
- (void)openCashierVcWithData:(id)data block:(LoadSuccess)block{

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.CTrollersToR.count) {
        NSMutableArray *muArry =[self.navigationController.viewControllers mutableCopy];
        for (UIViewController *vc in self.navigationController.viewControllers) {
            for (Class class in self.CTrollersToR) {
                if ([vc isKindOfClass:class] && ![vc isEqual:self.navigationController.topViewController]) {
                    [muArry removeObject:vc];
                    break;
                }
            }
        }
        self.navigationController.viewControllers = muArry;
        self.CTrollersToR = nil;
    }
}

#pragma --<空白页处理>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.empty_type == succes_empty_num) {
        return [UIImage imageNamed:PIC_NONE_DATA_PLACE];
    } else if (self.empty_type == fail_empty_num) {
        return [UIImage imageNamed:@"开小差"];
    } else if (self.empty_type == NoNetworkConnection_empty_num) {
        return [UIImage imageNamed:PIC_NONE_NET_PLACE];
    }else{
        return [UIImage imageNamed:@"开小差"];
    }
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
   
    if (self.empty_type == NoNetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"网络连接异常，请检查网络", @"网络连接异常，请检查网络")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"网络已连接，请重试", @"网络已连接，请重试")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else if (self.empty_type == succes_empty_num){
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",self.NodataTitle&&self.NodataTitle.length?self.NodataTitle:@" "] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else{
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"服务器开小差了,请重试", @"服务器开小差了,请重试")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }
    return nil;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.empty_type == NoNetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }else if (self.empty_type == succes_empty_num){
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"%@\n\n",self.NodataDescribe&&self.NodataDescribe.length?self.NodataDescribe:@" "] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else{
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }
    return nil;
}
//按钮文本或者背景样式
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.empty_type == NoNetworkConnection_empty_num) {
        return [NSLocalizedString(@"检查设置", @"检查设置") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }else if (self.empty_type != succes_empty_num){
        return [NSLocalizedString(@"重新加载", @"重新加载") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        return [NSLocalizedString(@"重新加载", @"重新加载") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }
    return nil;
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if(self.empty_type != succes_empty_num || self.empty_type == NoNetworkConnection_empty_num || self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num){
        return  [UIImage imageNamed:EMPTY_STATUS_BUTTON_BOX];
    }
    return nil;
}

//- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView{
//      return CGPointMake(SCREENWIDTH*0.5, 300);
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return 30;
//}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
//    return 15.0;
//}


//空白页的背景色

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    if (self.empty_type == In_loading_empty_num){
        return NO;
    }
    return YES;
}

//空白页点击事件
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
//    [self DidTap];
//}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    if (self.empty_type == NoNetworkConnection_empty_num) {
        [self CheckNetWork];
    }else{
        [self DidTap];
    }
}
- (void)CheckNetWork{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}
- (void)DidTap{
    if (self.empty_type != succes_empty_num) {
        if ([PortalHelper sharedInstance].isReachable) {
            self.header.hidden = NO;
            [self.header beginRefreshing];
        }
    }
}

- (void)appgetGlobalParamssuccess:(LoadSuccess)block{
    if ([[PortalHelper sharedInstance]get_accessToken]) {
        [[ToolRequest sharedInstance]appgetGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            GlobalParameter *Globaldata = [GlobalParameter mj_objectWithKeyValues:dataDict];
            [[PortalHelper sharedInstance] set_Globaldata:Globaldata];
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
            
            if (block) {
                block();
            }
        } failure:^(NSInteger errorCode, NSString *msg) {
            NSLog(@"msg");
        }];
    }
}

- (void)loadBankList:(LoadSuccess)block failure:(RequestFailure)failureBlock{
    if ([[PortalHelper sharedInstance]get_accessToken]) {
        [[ToolRequest sharedInstance]URLBASIC_userqueryWithfilterFlag:self.filterFlag Bankssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            bankList *bankListdata = [bankList mj_objectWithKeyValues:dataDict];
            [[PortalHelper sharedInstance] set_bankListdata:bankListdata];
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
            if (block) {
                block();
            }
        } failure:^(NSInteger errorCode, NSString *msg) {
            NSLog(@"msg");
            if (failureBlock) {
                failureBlock(errorCode,msg);
            }
        }];
    }
}

- (void)presentshareToWithData:(id)ShareData{
//    shareTo *vc = [shareTo sharedInstance];
//    vc.shareReturnClick = ^(NSInteger platform_type) {
//        NSLog(@"platform_type=%ld",platform_type);
//        if (platform_type != UMSocialPlatformType_Predefine_Begin) {
//            
//        }
//    };
//    [vc windosViewshow];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle];
}

- (void)setLoginOut{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"退出中", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpurseuserlogoutsssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [[PortalHelper sharedInstance]set_userInfo:nil];
        [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
        
        [MBProgressHUD showPrompt:NSLocalizedString(@"退出成功", @"") toView:weakself.view afterDelay:1.0f];

        NSNotification *notification =[NSNotification notificationWithName:@"LOGIN_EXIT_NOTIFICATION" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
    }];
    
//    [self Quitwithoutnotice];
//    NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
#pragma --mark<退出 不发通知>
- (void)Quitwithoutnotice{
    [[PortalHelper sharedInstance]set_userInfo:nil];
    [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
}

- (void)kaiqi{
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否开启指纹解锁登录功能？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"不，谢谢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakself cancelkaiqi];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself kaiqizhiwen];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否开启手势密码登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"不，谢谢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakself cancelkaiqi];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            GesturecipherVc *vc = [GesturecipherVc new];
            vc.CTrollersToR = @[[weakself class]];
            vc.state = GestureSetPassword;
            vc.isUnlock = weakself.isUnlock;
            [weakself OPenVc:vc];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)cancelkaiqi{
    if (self.threePay && ![[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:STRING_1]){
        [MBProgressHUD showPrompt:@"请先实名认证"];
        RealNameVc *vc = [RealNameVc new];
        vc.CTrollersToR = @[[self class]];
        [self OPenVc:vc];
    }else{
        [self popSelf];
    }
}
- (void)kaiqizhiwen{
    kWeakSelf(self);
    [self evaluateAuthenticateWith:^{
        setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
        setUp_dataBlock.FingerprintPassword = @"1";
        [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
        
        if (weakself.threePay && ![[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:STRING_1]){
            [MBProgressHUD showPrompt:@"开启成功,请先实名认证"];
            RealNameVc *vc = [RealNameVc new];
            vc.CTrollersToR = @[[weakself class]];
            [weakself OPenVc:vc];
        }else{
            [MBProgressHUD showPrompt:@"开启成功" afterDelay:2.0f];
            [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:2.0f];
        }
    } With:^{
        [weakself resetzhiwen];
    }];
}

- (void)resetzhiwen{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"是否再次尝试开启指纹解锁登录功能？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"不，谢谢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself popSelf];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself kaiqizhiwen];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//是否开启指纹解锁登录功能？
- (void)evaluateAuthenticateWith:(LoadSuccess)succes With:(LoadSuccess)Fail
{
    
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    NSString* result = @"请验证已有指纹";
    context.localizedFallbackTitle = @"腾邦T钱包";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
                [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
                if (success) {
                    if (succes) {
                        succes();
                    }
                }
                else
                {
                    if (Fail) {
                        Fail();
                    }
                    switch (error.code) {
                        case LAErrorUserCancel:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }];
            
        }];
    }
}
@end
