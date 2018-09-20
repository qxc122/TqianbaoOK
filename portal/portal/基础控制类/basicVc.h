//
//  basicVc.h
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HeaderAll.h"
#import "MACRO_NOTICE.h"
#import "ToolRequest+common.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "MJExtension.h"
#import "MACRO_ENUM.h"
#import "UIImageView+Add.h"
//#import <UMSocialCore/UMSocialCore.h>
//#import "UMMobClick/MobClick.h"
#import <LocalAuthentication/LocalAuthentication.h>


#ifdef DEBUG
#import "NSDictionary+Add.h"
#endif

typedef void (^ShareSuccess)(NSString *messg);
typedef void (^ShareFailure)(NSString *error);


typedef NS_ENUM(NSInteger, empty_num)
{
    In_loading_empty_num = -48, //加载中
    
    fail_empty_num = KRespondCodeFail, //加载失败
    succes_empty_num = kRespondCodeSuccess,   //加载成功
    NoNetworkConnection_empty_num = KRespondCodeNotConnect,   //无网络连接
    NoNetworkConnection_TO_NetworkConnection_empty_num,   //从无网络连接 到有 网络连接
    
    logout_empty_num,   //未登录
    noItems_empty_num,   //没有数组
};

//typedef void (^LoginSuccess)();

typedef void (^LoadGlobalParam)();

//typedef void (^LoginSuccessWithStaue)(NSString* isCacel);




@interface basicVc : UIViewController

@property (nonatomic,assign) BOOL threePay;  //第三方支付进来的
@property (nonatomic,assign) BOOL isUnlock; //是用来解锁的


@property (nonatomic,strong) NSString  *filterFlag; // 是否是腾邦宝

@property(assign, nonatomic) UIStatusBarStyle statusBarStyle;
@property (nonatomic,assign) CGFloat  sesPro;//提示多少秒 
@property (nonatomic,strong) MJRefreshHeader *header;//头部
@property (nonatomic,strong) MJRefreshFooter *footer;//底部
@property (nonatomic,assign) BOOL  isNeedRefreth;
@property (nonatomic,strong) NSString  *NodataTitle; // 没有数据时候的标题
@property (nonatomic,strong) NSString  *NodataDescribe; // 没有数据时候的描叙
@property (nonatomic,assign) empty_num  empty_type; //
@property (nonatomic,strong) NSArray *CTrollersToR; //将要移除的控制器

@property (nonatomic,strong) NSArray *WillOpenVcs; //将要关闭本身控制器时，要打开的下一个控制器
@property (nonatomic,strong) NSArray *WillOpenVcdatas; //要打开的下一个控制器 的数据
@property (nonatomic,strong) id defaultData; //默认数据
@property (nonatomic,assign) BOOL  isSuccess; //请求成功

@property (nonatomic,assign) BOOL FLAG_IN_DATA_UPDATE; //数据更新中标志,有些不能点击

#pragma --mark<退出成功>
- (void)setLoginOut;
#pragma --mark<退出 不发通知>
- (void)Quitwithoutnotice;
#pragma --mark<开启指纹 或者 手势密码>
- (void)kaiqi;
#pragma --mark<请求全局参数  适用下面这个替代上面的>
- (void)appgetGlobalParamssuccess:(LoadSuccess)block;
#pragma --mark<银行卡列表>
- (void)loadBankList:(LoadSuccess)block failure:(RequestFailure)failureBlock;

#pragma --mark<控制器 右边按钮的文字大小 和 颜色>
- (void)setRightBtn;

- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user;
- (void)customBackButton;
- (void)popSelf;
- (void)setDZNEmptyDelegate:(id)TabOrColl;
#pragma --mark<打开登录页面>
- (void)openLoginView:(LoadSuccess)block;
#pragma --mark<打开  baseWkVc 页面>
- (void)openEachWkVcWithId:(id)url;
#pragma --mark<打开  baseWkVc 页面>
- (void)openbaseWkVcWithId:(id)url;
#pragma --mark<打开 支付 页面>
- (void)openCashierVcWithData:(id)data block:(LoadSuccess)block;
#pragma -mark<加载新数据>
- (void)loadNewData;
#pragma -mark<加载更多数据>
- (void)loadMoreData;
#pragma -mark<调用分享面板>
- (void)presentshareToWithData:(id)ShareData;
#pragma -mark<调用分享面板>
- (void)OPenVc:(basicVc *)vc;
    
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView;

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

- (void)DidTap;

//- (void)payFailWith:(NSInteger)errorCode :(NSString *)msg;
//
//- (void)PasswordRetrieval;
//
//- (void)retryPay;

#pragma -mark<分享接口二期  建议后续使用改接口>
//- (void)shareTwoWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title withDescr:(NSString *)descr withWebOrImageUrl:(id )WebOrImageUrl withThumImage:(id)thumImage IsImage:(BOOL)IsImage success:(ShareSuccess)successBlock failure:(ShareFailure)failureBlock;
@end
