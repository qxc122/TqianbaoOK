//
//  HeaderAll.h
//  portal
//
//  Created by Store on 2017/8/30.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#ifndef HeaderAll_h
#define HeaderAll_h

//#define EaseMobAppKey  @"tempus#yuyou"
//#ifdef DEBUG
//#define EaseMobapnsCertName  @"yuyouTest"
//#else
//#define EaseMobapnsCertName  @"yuyouProduct"
//#endif

//环信开放平台参数
#define EaseMobAppKey  @"tempus#twallet"
#ifdef DEBUG
#define EaseMobapnsCertName  @"walletTest"
#else
#define EaseMobapnsCertName  @"walletOK"
#endif

typedef void (^LoadSuccess)();

#import "IQKeyboardManager.h"
#import "SelectBank.h"
#import "UIView+Add.h"
#import "NSDate+DateTools.h"
#import "MJExtension.h"
#import "UIImageView+CornerRadius.h"
#import "UITextField+Add.h"
#import "UIImageView+Add.h"
#import "UIView+backgroundColor.h"
#import "UIButton+Add.h"
#import "UIColor+Add.h"
#import "UIImage+Add.h"
#import "NSString+Add.h"

#import "UILabel+UILabelTpay.h"
#import "MBProgressHUD+MJ.h"
#import "MACRO_COLOR.h"
#import "MACRO_UIFONT.h"
#import "Masonry.h"
#import "MACRO_PIC.h"
#import "ToolModeldata.h"
#import "MACRO_PORTAL.h"
#import "UIImageView+WebCache.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MACRO_UI.h"
#import "MACRO_ENUM.h"
#import "ToolRequest+common.h"
#import "MACRO_NOTICE.h"
#import "EaseUI.h"
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define TOURPAGESIZE 10
#define FIRSTPAGE    1


#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define PROPORTION_HEIGHT  SCREENHEIGHT/667.0
#define PROPORTION_WIDTH   SCREENWIDTH/375.0


#define IPoneX (SCREENHEIGHT == 812)

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif /* HeaderAll_h */
