//
//  ToolModeldata.h
//  TourismT
//
//  Created by Store on 16/12/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>





typedef enum {
    RechargeandcashwithdrawalVcState_Recharge,
    RechargeandcashwithdrawalVcState_WithdrawCash
} RechargeandcashwithdrawalVcState;


#define HOME_TYPE_BANK  @"1"  //银行卡
#define HOME_TYPE_AIR  @"2" //机票

/////我的银行卡
//@interface BankList : NSObject
//@property (nonatomic,strong) NSMutableArray *list;
//@end


///我的消息
@interface outORINSuccess : NSObject
@property (nonatomic,strong) NSString *arrDate;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *calDate;
@property (nonatomic,strong) NSNumber *cardNo;
@property (nonatomic,strong) NSString *fee;
@property (nonatomic,strong) NSString *price;
@end


///通知
@interface noticeData : NSObject
@property (nonatomic,strong) NSNumber *idd;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *info;
@end

///我的消息
@interface tpTreasurequeryPayMethod : NSObject  
@property (nonatomic,strong) NSMutableArray *bankCards;
@property (nonatomic,strong) NSString *fastTranOutRedDesc;
@property (nonatomic,strong) NSString *tranOutRedDesc;
@property (nonatomic,strong) NSNumber *acctBal;
@property (nonatomic,strong) NSNumber *todayFastOuLimit;
@property (nonatomic,strong) NSString *incomeArrDate;
@property (nonatomic,strong) NSString *tranOutDesc;
@property (nonatomic,strong) NSString *fastTranOutDesc;
@end

///我的消息
@interface appIdAndSecret : NSObject
@property (nonatomic,strong) NSString *appId;
@property (nonatomic,strong) NSString *appSecret;
@end

@interface oneHomeData : NSObject
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *redPoint;
@end

@interface accessToken : NSObject
@property (nonatomic,strong) NSString *sessionSecret;
@property (nonatomic,strong) NSString *sessionKey;
@property (nonatomic,strong) NSDate *expireTime;
@property (nonatomic,strong) NSString *accessToken;
@end

@interface UserInfo : NSObject
@property (nonatomic,strong) NSString *bankMobile;
@property (nonatomic,strong) NSURL *headUrl;
@property (nonatomic,strong) NSString *authenTicket;
@property (nonatomic,strong) NSString *authenUserId;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *fullMobile;
@property (nonatomic,strong) NSString *vipLevel;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *loginTime;
@property (nonatomic,assign) BOOL payPasswordFlag;
@property (nonatomic,assign) BOOL gestureFlag;
@property (nonatomic,strong) NSString *realFlag;
@property (nonatomic,strong) NSString *easemobId;
@end


@interface AirInfo : NSObject
@property (nonatomic,strong) NSString *depActual;
@property (nonatomic,strong) NSString *depWeather;
@property (nonatomic,strong) NSString *arrEstimated;
@property (nonatomic,strong) NSString *arrActual;
@property (nonatomic,strong) NSString *depEstimated;

@property (nonatomic,strong) NSString *arrWeather;
@property (nonatomic,strong) NSString *flightStatus;
@property (nonatomic,strong) NSString *boardingGate;
@property (nonatomic,strong) NSString *carousel;
@property (nonatomic,strong) NSString *arrTerminal;

@property (nonatomic,strong) NSString *preFlightNo;
@property (nonatomic,strong) NSString *depTerminal;
@property (nonatomic,strong) NSString *flightzj;
@property (nonatomic,strong) NSString *rate;
@property (nonatomic,strong) NSString *flyTimePercent;
@end


@interface HomeDataNew : NSObject
@property (nonatomic,strong) NSURL *fundUrl;
@property (nonatomic,strong) NSURL *loanUrl;
@property (nonatomic,strong) NSURL *privateFundUrl;
@property (nonatomic,strong) NSString *incomeRatio;

@property (nonatomic,strong) NSMutableArray *bannerInfos;
@property (nonatomic,strong) NSMutableArray *prgInfos;

@property (nonatomic,strong) NSURL *topHref;
@property (nonatomic,strong) NSURL *topPicture;
@property (nonatomic,strong) NSString *topNeedLogin;
@property (nonatomic,strong) NSString *topOpenMode;

@end


@interface bannerInfosOne : NSObject
@property (nonatomic,strong) NSURL *picture;
@property (nonatomic,strong) NSURL *href;

@property (nonatomic,strong) NSString *needLogin;
@property (nonatomic,strong) NSString *openMode;
@end

@interface prgInfosOne : NSObject
@property (nonatomic,strong) NSURL *prgDetailHref;
@property (nonatomic,strong) NSString *prgRate;
@property (nonatomic,strong) NSString *increaseRate;
@property (nonatomic,strong) NSString *period;
@property (nonatomic,strong) NSString *repayMod;
@end


@interface UserInfoDeatil : NSObject
@property (nonatomic,strong) NSString *finaUserName;
@property (nonatomic,strong) NSURL *headUrl;
@property (nonatomic,strong) NSURL *integralUrl;
@property (nonatomic,strong) NSNumber *totalAsset;
@property (nonatomic,strong) NSNumber *totalIncome;
@property (nonatomic,strong) NSString *errorMsg;
@property (nonatomic,strong) NSNumber *finaAsset;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *bankMobile;

@property (nonatomic,strong) NSNumber *acctBal;
@property (nonatomic,strong) NSNumber *unCashAcctBal;

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSNumber *cashAcctBal;
@property (nonatomic,strong) NSNumber *integral;

@property (nonatomic,strong) NSMutableArray *Arry_list;

@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *payPasswordFlag;
@property (nonatomic,strong) NSString *realFlag;
@property (nonatomic,strong) NSString *hasUnreadNews;

@property (nonatomic,strong) NSString *fundBal; //腾邦宝余额
@property (nonatomic,strong) NSString *mynewUserFlag; //新用户标志
@property (nonatomic,strong) NSString *receiveExpMoneyFlag; //体验金领取标志
@property (nonatomic,strong) NSString *expMoneyIncomeFlag; //体验金收益到账提醒标志

@property (nonatomic,strong) NSURL *loanUrl; //我的贷款url地址  

@property (nonatomic,strong) NSString *loanStatus; //贷款状态
@property (nonatomic,strong) NSNumber *loanDueRepayAmt; //应还金额
@property (nonatomic,strong) NSNumber *loanCnt; //贷款笔数
@property (nonatomic,strong) NSString *loanRepayDate; //还款日期


@end


@interface bankCard : NSObject
@property (nonatomic,strong) NSString *bindRemark;

@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSNumber *bindId;
@property (nonatomic,strong) NSString *cardNo;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSURL *bigBankIcon;
@property (nonatomic,strong) NSString *bankCode;


@property (nonatomic,strong) NSString *arrTime;
@property (nonatomic,strong) NSString *depEstimated;
@property (nonatomic,strong) NSString *arrEstimated;

@property (nonatomic,strong) NSString *ticketNo;
@property (nonatomic,strong) NSString *arrCityName;
@property (nonatomic,strong) NSString *duration;
@property (nonatomic,strong) NSString *arrCityCode;
@property (nonatomic,strong) NSString *flightNo;
@property (nonatomic,strong) NSString *depTime;
@property (nonatomic,strong) NSString *displayFlag;
@property (nonatomic,strong) NSString *airName;
@property (nonatomic,strong) NSString *depCityName;
@property (nonatomic,strong) NSString *depDate;
@property (nonatomic,strong) NSString *passengerName;
@property (nonatomic,strong) NSURL *airLogo;
@property (nonatomic,strong) NSString *depCityCode;
@end


@interface RechargeSuccess : NSObject
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *cardNo;
@property (nonatomic,strong) NSNumber *money;
@end


@interface ApplySuccessOKdata : NSObject
@property (nonatomic,strong) NSNumber *acctId;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *bankNo;
@property (nonatomic,strong) NSNumber *loanAmt;
@end


@interface reApplySuccessOKdata : NSObject
@property (nonatomic,strong) NSNumber *amt;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *bankNo;
@property (nonatomic,strong) NSString *payMethod;
@end

@interface scanQRCodeOk : NSObject
@property (nonatomic,strong) NSURL *payeeLogo;
@property (nonatomic,strong) NSString *payeeName;
@property (nonatomic,strong) NSString *acctBal;
@property (nonatomic,strong) NSMutableArray *bankCardArray;
@end


@interface Conductfinancialtransactions : NSObject
@property (nonatomic,strong) NSNumber *totalAsset;//总资产
@property (nonatomic,strong) NSNumber *finaAsset;//理财资产
@property (nonatomic,strong) NSNumber *acctBal;//账户余额
@property (nonatomic,strong) NSNumber *freezeBal;// 冻结金额
@property (nonatomic,strong) NSNumber *totalIncome;//累计总收益

@property (nonatomic,strong) NSString *realFlag;//实名标志

@property (nonatomic,strong) NSNumber *bindId;//绑卡编号

@property (nonatomic,strong) NSString *cardNo;//卡号
@property (nonatomic,strong) NSString *bankName;//银行名称
@property (nonatomic,strong) NSURL *bankIcon;//银行icon
@property (nonatomic,strong) NSString *cfcaSignFlag;//数字签名申请标志

@property (nonatomic,strong) NSNumber *tpurseAcctBal;//T钱包账户余额
@property (nonatomic,strong) NSString *tpurseRealFlag;//T钱包实名标志
@property (nonatomic,strong) NSString *userName;//用户姓名
@property (nonatomic,strong) NSString *certNo;//身份证号
@end



@interface scanQRCodeDone : NSObject
@property (nonatomic,strong) NSString *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *payeeName;
@end


@interface scanQRCodeBankOne : NSObject
@property (nonatomic,strong) NSNumber *bindId;
@property (nonatomic,strong) NSNumber *bankNo;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSURL *bankIcon;
@end

@interface ThreeOk : NSObject
@property (nonatomic,strong) NSNumber *cashAcctBal;
@property (nonatomic,strong) NSNumber *integral;
@property (nonatomic,strong) NSNumber *unCashAcctBal;
@property (nonatomic,strong) NSNumber *acctBal;
@property (nonatomic,strong) NSMutableArray *bankCardsArray;
@end


@interface ThreeOkBankOne : NSObject
@property (nonatomic,strong) NSURL *bigBankIcon;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSNumber *bindId;
@property (nonatomic,strong) NSString *cardNo;
@property (nonatomic,strong) NSNumber *singleLimit;
@end


@interface MaldivesPushcontent : NSObject
@property (nonatomic,strong) NSString *resultStatus;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *iconUrl;
@property (nonatomic,strong) NSNumber *tranAmt;
@property (nonatomic,strong) NSString *tranName;
@property (nonatomic,strong) NSString *bankIconUrl;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *bankCardNo;
@end

@interface MaldivesPush : NSObject
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) MaldivesPushcontent *conten;
@end





@interface Successincashwithdrawal : RechargeSuccess
@property (nonatomic,strong) NSString *applyDatetime;
@property (nonatomic,strong) NSString *estimateArrDatetime;
@property (nonatomic,strong) NSNumber *fee;
@end



@interface graphicVerifyCodeUrlInfo : NSObject
@property (nonatomic,strong) NSURL *graphicVerifyCodeUrl;
@end


@interface GlobalParameter : NSObject
@property (nonatomic,strong) NSURL *registAgreementUrl; //用户协议
@property (nonatomic,strong) NSURL *privacyAgreementUrl;    //隐私协议
@property (nonatomic,strong) NSURL *finUrl; //理财url地址
@property (nonatomic,strong) NSURL *totalAssetUrl;//总资产url地址
@property (nonatomic,strong) NSURL *balUrl; //余额url地址
@property (nonatomic,strong) NSURL *myFinUrl;   //我的理财url地址


@property (nonatomic,strong) NSURL *fundUrl;//腾邦宝
@property (nonatomic,strong) NSURL *fundQaUrl;//腾邦宝
@property (nonatomic,strong) NSURL *fundBillUrl;//腾邦宝
@property (nonatomic,strong) NSURL *myLoanUrl;//腾邦宝
@property (nonatomic,strong) NSURL *myLoanRecordUrl;//腾邦宝



@property (nonatomic,strong) NSURL *myNewsUrl;//我的消息url地址
@property (nonatomic,strong) NSURL *aboutUsUrl; //关于我们url地址
@property (nonatomic,strong) NSURL *myBillUrl;//我的账单url地址
@property (nonatomic,strong) NSURL *myReceivableUrl; //我的收款记录url地址

@property (nonatomic,strong) NSURL *finCalendarUrl;//理财日历
@property (nonatomic,strong) NSURL *finBillUrl; //理财账单
@property (nonatomic,strong) NSString *customerServicePhone;

//@property (nonatomic,strong) NSString *mobile;


@property (nonatomic,strong) NSURL *tpurseServicetAgreementUrl;//T钱包服务协议
@property (nonatomic,strong) NSURL *vcServiceAgreementUrl; //腾邦创投服务协议

@property (nonatomic,strong) NSURL *vcPrivacyAgreementUrl;//腾邦创投隐私条款
@property (nonatomic,strong) NSURL *tpursePayAgreementUrl; //T钱包快捷支付协议

@property (nonatomic,strong) NSURL *tpurseServiceCustomerAgreementUrl; //平安大华客户协议
@property (nonatomic,strong) NSURL *tpurseServiceRechargeAgreementUrl; //平安大华快取协议

@property (nonatomic,strong) NSURL *loanUrl; //我的借款url地址
@property (nonatomic,strong) NSURL *qrCodeInsUrl; //付款二维码嘛使用说明

@property (nonatomic,strong) NSURL *fundAcctPayAgreementUrl; //平安付科技电子支付账户协议


@property (nonatomic,strong) NSNumber *iosDeployVerCode; //版本号
@property (nonatomic,strong) NSString *isPassForIOS; // 1。通过。    2。 未通过。
@end

@interface UMdeviceToken : NSObject
@property (nonatomic,strong) NSString *deviceToken;
@end


@interface QRcode : NSObject
@property (nonatomic,strong) NSURL *codeUrl;
@property (nonatomic,strong) NSString *codeId;
@end

@interface bankList : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_list;

@property (nonatomic,strong) NSNumber *bindId;
@property (nonatomic,strong) NSString *userRealName;
@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *cardNo;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *bankIcon;  //后台还未定义改字段
@property (nonatomic,strong) NSString *bankMobile;
@end


@interface ximengOK : NSObject
@property (nonatomic,strong) NSURL *redirectUrl;
@end


@interface HomeData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_merchList;
@end

@interface HomeDataOne : NSObject
@property (nonatomic,strong) NSString *finFlag;
@property (nonatomic,strong) NSURL *merchLink;
@property (nonatomic,strong) NSString *merchName;
@property (nonatomic,strong) NSURL *merchIcon;
@property (nonatomic,strong) NSString *merchId;
@property (nonatomic,assign) BOOL needLogin;
@end



@interface noticationData : NSObject
@property (nonatomic,strong) NSString *codeId;
@property (nonatomic,strong) NSURL *content;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *money;
@end


@interface leftData : NSObject
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSURL *url;
@end

@interface MyNewsData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_newsList;
@property (nonatomic,strong) NSString *hasMore;
@end

@interface MyNewsData_One : NSObject
@property (nonatomic,strong) NSString *newsDate;
@property (nonatomic,strong) NSURL *newsImg;
@property (nonatomic,strong) NSString *newsTitle;
@property (nonatomic,strong) NSURL *newsLink;
@property (nonatomic,strong) NSNumber *newsId;
@property (nonatomic,strong) NSString *newsType;
@end

@interface MyCollecData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_List;
@property (nonatomic,strong) NSString *hasMore;
@end

@interface MyCollecData_One : NSObject
@property (nonatomic,strong) NSURL *logo;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSNumber *favorId;
@property (nonatomic,strong) NSString *date;
@end


@interface FinanceVcData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_insuranceProductList;
@property (nonatomic,strong) NSMutableArray *Arry_tourProductList;
@property (nonatomic,strong) NSMutableArray *Arry_tpurseProductList;
@property (nonatomic,strong) NSURL *fundProductLink;
@property (nonatomic,strong) NSURL *fundProductPicture;
@property (nonatomic,strong) NSURL *vcProductLink;
@property (nonatomic,strong) NSURL *vcProductPicture;
@end

@interface FinanceVcData_One : NSObject
@property (nonatomic,strong) NSString *productPrice;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *productDesc;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,assign) BOOL needLogin;
@property (nonatomic,strong) NSURL *productLink;
@property (nonatomic,strong) NSURL *productPicture;
@end


@interface passengerInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_passengerInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface passengerInfos_one : NSObject
@property (nonatomic,strong) NSString *enName;
@property (nonatomic,strong) NSMutableArray *Arry_certInfos;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,assign) NSInteger passengerId;
@property (nonatomic,strong) NSString *selfFlag;
@property (nonatomic,strong) NSString *surname; 
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *nationalityCode;
@property (nonatomic,strong) NSString *nationalityName;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,strong) NSString *expireDate;
@end

@interface certInfos_one : NSObject
@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *nationality;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,assign) NSInteger certId;
@property (nonatomic,strong) NSString *expireDate;
@end

@interface contactInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_contactInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface contactInfos_one : NSObject
@property (nonatomic,strong) NSString *email;
@property (nonatomic,assign) NSInteger contactId;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *selfFlag;
@end

@interface addressInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_addressInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface addressInfos_one : NSObject
@property (nonatomic,strong) NSString *receiverMobile;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,assign) NSInteger addressId;
@property (nonatomic,strong) NSString *receiverName;
@property (nonatomic,strong) NSString *selfFlag;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *detailAddress;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *postCode;
@end

@interface CheckApp : NSObject
@property (nonatomic,strong) NSString *appName;
@property (nonatomic,strong) NSString *verName;
@property (nonatomic,strong) NSString *updateType;
@property (nonatomic,strong) NSString *updateInfo;
@end

@interface setUpAll : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_all;    //所有账号的手势密码
@property (nonatomic,strong) NSMutableArray *Arry_allPhone;    //所有账号的手机号
@end

@interface setUp : NSObject
@property (nonatomic,strong) NSString *phone;    //手机号码
@property (nonatomic,strong) NSString *FingerprintPassword;  //@"1" 开启  @“0” 关闭
@property (nonatomic,strong) NSString *GestureCipher;
@property (nonatomic,strong) NSString *GestureCipherStr;    //手势密码

@property (nonatomic,strong) NSString *staue;    //首页 显示 和 隐藏  ／／显示 @“1”


//@property (nonatomic,strong) NSString *ScavengingOpenState;    //扫码付开启状态
@property (nonatomic,strong) NSString *ScavengingType;    //扫码付 付款方式
@end


@interface setUpdatePre : NSObject
@property (nonatomic,strong) NSDate *datePre;
@end


@interface payPre : NSObject
@property (nonatomic,strong) NSString *sysId;
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *v;
@property (nonatomic,strong) NSString *orderId;
@end

@interface payData : NSObject
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderName;
@property (nonatomic,strong) NSString *supportTcoin;
@property (nonatomic,strong) NSNumber *orderPrice;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface setUpData : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *describe;

//绑定银行用到的
@property (nonatomic,assign) NSInteger  clearButtonMode;
@property (nonatomic,assign) NSInteger  keyboardType;
@property (nonatomic,assign) NSInteger  contentType;
@property (nonatomic,assign) NSUInteger  existedLength;
@end

