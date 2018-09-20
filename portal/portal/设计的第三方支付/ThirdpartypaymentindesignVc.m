//
//  ThirdpartypaymentindesignVc.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ThirdpartypaymentindesignVc.h"
#import "ThirdpartypaymentindesignDesCell.h"
#import "ThirdpartypaymentindesignHead.h"
#import "ThirdpartypaymentindesignTypeCell.h"
#import "addBankCarkFoot.h"
#import "payTypeSele.h"
#import "SetpaymentpasswordVc.h"
#import "RealNameVc.h"
#import "RechargeVc.h"
#import "SignInVc.h"
#import "GesturecipherVc.h"
@interface ThirdpartypaymentindesignVc ()
@property (nonatomic,weak) addBankCarkFoot *foot;
@property (nonatomic,weak) ThirdpartypaymentindesignHead *head;


@end

@implementation ThirdpartypaymentindesignVc
- (void)viewDidLoad {
    [self setmyUI];
    [super viewDidLoad];
    self.view.backgroundColor  =ColorWithHex(0xD8D8D8,0.22);
    self.threePay = YES;
    self.tcoinFlag = @"0";
    self.title = NSLocalizedString(@"支付订单", @"");
    self.registerClasss = @[[ThirdpartypaymentindesignDesCell class],[ThirdpartypaymentindesignTypeCell class]];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 12+20, 0);
    
    self.fd_interactivePopDisabled = YES;
    [self setHeadAndFoot];
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [self setGesturecipherVc];
        [self.header beginRefreshing];
    }else{
        self.empty_type = succes_empty_num;
        [self.tableView reloadData];
        self.head.hidden = NO;
        self.foot.hidden = NO;
        [MBProgressHUD showPrompt:@"请先登录"];
        [self openLoginView:nil];
    }
}
- (void)setmyUI{ 
    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(115, 596, 144, 12);
    label.text = @"深圳腾邦智慧科技有限公司";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    label.textColor = [UIColor colorWithRed:203/255.0 green:206/255.0 blue:211/255.0 alpha:1/1.0];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-59);
    }];

    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@""];
//    imageView.frame = CGRectMake(170, 551, 35, 30);
    imageView.image = [UIImage imageNamed:@"t钱包灰色.png"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(label.mas_top).offset(-15);
        make.width.equalTo(@35);
        make.height.equalTo(@30);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.header.isRefreshing && [[PortalHelper sharedInstance]get_userInfo]) {
        [self.header beginRefreshing];
    }
}
- (void)customBackButton{
    UIImage* image = [[UIImage imageNamed:PIC_CUSTOM_NAVIGATION_BACK_KING] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popSelfCanl)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)setHeadAndFoot{
    ThirdpartypaymentindesignHead *head = [[ThirdpartypaymentindesignHead alloc]initWithFrame:CGRectMake(0, 0, 0, 136*PROPORTION_HEIGHT+24)];
    head.pasteboarddata  =self.pasteboarddata;
    self.head = head;
    self.tableView.tableHeaderView = head;
    
    
    addBankCarkFoot *foot = [[addBankCarkFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+60)];
    self.foot = foot;
    [foot.btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"确定支付" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [foot.btn setBackgroundImage:[ColorWithHex(0x5E7FFF, 1.0) imageWithColor] forState:UIControlStateNormal];
    
    kWeakSelf(self);
    foot.doneBtn = ^{
        if ([PortalHelper sharedInstance].isReachable) {
            [weakself FootpayPre];
        } else {
            [MBProgressHUD showPrompt:@"网络连接异常，请检查网络" toView:weakself.view];
        }
    };
    self.tableView.tableFooterView = foot;
    
    self.head.hidden = YES;
    self.foot.hidden = YES;
}

- (void)FootpayPre{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        if (![[PortalHelper sharedInstance]get_userInfo].payPasswordFlag){
            [MBProgressHUD showPrompt:@"请先设置支付密码"];
            [self OPenVc:[SetpaymentpasswordVc new]];
            return;
        }else if (![[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:STRING_1]){
            [MBProgressHUD showPrompt:@"请先实名认证"];
            [self OPenVc:[RealNameVc new]];
            return;
        }else{
            if (self.ThreeOkdata) {
                if (self.one) {
                    if ([self.pasteboarddata[@"money"] doubleValue] >= 1000.0) {
                        [self sendSmsCodebindId:[self.one.bindId integerValue] Money:[self.pasteboarddata[@"money"] doubleValue] codeId:nil];
                    } else {
                        [self OpenPasswordpaymentbox];
                    }
                    //零钱支付大于1000。取消验证码
//                    [self OpenPasswordpaymentbox];
                } else {
                    if (([self.pasteboarddata[@"money"] doubleValue] <= [self.ThreeOkdata.acctBal doubleValue] && !self.isOA) || ([self.pasteboarddata[@"money"] doubleValue] <= [self.ThreeOkdata.cashAcctBal doubleValue] && self.isOA)) {
                        if ([self.pasteboarddata[@"money"] doubleValue] >= 1000.0) {
                            [self sendSmsCodebindId:[self.one.bindId integerValue] Money:[self.pasteboarddata[@"money"] doubleValue] codeId:nil];
                        } else {
                            [self OpenPasswordpaymentbox];
                        }
                    } else {
                        [self Frontalinsufficienc];
                    }
                }
            }
        }
    }else {
        [MBProgressHUD showPrompt:@"请先登录"];
        [self openLoginView:nil];
        return;
    }
}

- (void)Frontalinsufficienc{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"零钱不足,请先充值" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([PortalHelper sharedInstance].isReachable) {
            RechargeVc *tmp = [RechargeVc new];
            [weakself OPenVc:tmp];
        } else {
            [MBProgressHUD showPrompt:@"网络连接异常，请检查网络" toView:weakself.view];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"放弃支付" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself returenCustomaryAPPPro:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)loadNewDataOK{
    
}
- (void)loadNewDatafail{
    
}
- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpurseuserqueryPayMethodsuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.ThreeOkdata = [ThreeOk mj_objectWithKeyValues:dataDict];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        if (weakself.isOA) {
            if (weakself.ThreeOkdata && weakself.pasteboarddata) {
                weakself.head.hidden = NO;
                weakself.foot.hidden = NO;
                weakself.foot.btn.enabled = YES;
                [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
                weakself.head.pasteboarddata  =weakself.pasteboarddata;
                [weakself loadNewDataOK];
            }
        } else {
            [weakself loadNewDataOK];
            weakself.head.hidden = NO;
            weakself.foot.hidden = NO;
            weakself.foot.btn.enabled = YES;
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        weakself.head.hidden = YES;
        weakself.foot.hidden = YES;
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
    if (self.isOA) {
        [[ToolRequest sharedInstance]URLBASIC_orderqueryOrderInfoWithSysId:self.payIdForOA[@"sysId"] Sign:self.payIdForOA[@"sign"] Timestamp:self.payIdForOA[@"timestamp"] V:self.payIdForOA[@"v"] OrderId:self.payIdForOA[@"orderId"] success:^(id dataDict, NSString *msg, NSInteger code) {
            NSMutableDictionary *muDic = [NSMutableDictionary new];
            [muDic setObject:@"OA" forKey:@"WhoCallsName"];
            [muDic setObject:@"TwalletPay00000002" forKey:@"WhoCalls"];
            [muDic setObject:dataDict[@"orderId"] forKey:@"businessID"];
            
            NSString *orderName = dataDict[@"orderName"];
            [muDic setObject:orderName forKey:@"businessName"];
            
            NSNumber *money = dataDict[@"orderPrice"];
            [muDic setObject:[NSString stringWithFormat:@"%.2f",[money doubleValue]] forKey:@"money"];
            
            weakself.pasteboarddata = muDic;
            if (weakself.ThreeOkdata && weakself.pasteboarddata) {
                weakself.head.hidden = NO;
                weakself.foot.hidden = NO;
                weakself.foot.btn.enabled = YES;
                [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
                weakself.head.pasteboarddata  =weakself.pasteboarddata;
                [weakself loadNewDataOK];
            }
        } failure:^(NSInteger errorCode, NSString *msg) {
            weakself.head.hidden = YES;
            weakself.foot.hidden = YES;
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }];
    }
}

//OA
- (void)returnOAwithPayWithretStatus:(NSString *)retStatus errorCode:(NSString *)errorCode errorMsg:(NSString *)errorMsg authCode:(NSString *)authCode{
    NSString *tmp = [NSString stringWithFormat:@"TwalletPay00000002://%@/a%@/b%@/c",retStatus,errorCode,errorMsg];
    NSString *urlStringUTF8 = [tmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";//此处不做更改，
    //    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    //    NSString *urlStringUTF8 = [tmp stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStringUTF8]];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//OA
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        if (self.ThreeOkdata.bankCardsArray.count) {
            payTypeSele *view = [payTypeSele new];
            view.ThreeOkdata = self.ThreeOkdata;
            kWeakSelf(self);
            view.ThreeselecetType = ^(ThreeOkBankOne *one) {
                if (![one isEqual:weakself.one]) {
                    if (one) {
                        weakself.one = one;
                    } else {
                        weakself.one = nil;
                    }
                    [weakself.tableView reloadData];
                }
            };
            [view windosViewshow];
        } else {
            [MBProgressHUD showPrompt:@"没有更多的支付方式" toView:self.view];
        }
    }
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ThirdpartypaymentindesignDesCell *cell = [ThirdpartypaymentindesignDesCell returnCellWith:tableView];
        [self configureThirdpartypaymentindesignDesCell:cell atIndexPath:indexPath];
        return  cell;
    }else{
        ThirdpartypaymentindesignTypeCell *cell = [ThirdpartypaymentindesignTypeCell returnCellWith:tableView];
        [self configureThirdpartypaymentindesignTypeCell:cell atIndexPath:indexPath];
        return  cell;
    }
}

#pragma --mark< 配置ThirdpartypaymentindesignDesCell 的数据>
- (void)configureThirdpartypaymentindesignDesCell:(ThirdpartypaymentindesignDesCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.isOA) {
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            cell.pasteboarddata  =self.pasteboarddata;
        }else{
            cell.title.text = @"OA红包";
            cell.num.text = [NSString stringWithFormat:@"%@%@",@"订单号:",self.payIdForOA[@"orderId"] ];
        }
//            cell.title.text = pasteboarddata[@"businessName"];
    } else {
        cell.pasteboarddata  =self.pasteboarddata;
    }
}
#pragma --mark< 配置ThirdpartypaymentindesignTypeCell 的数据>
- (void)configureThirdpartypaymentindesignTypeCell:(ThirdpartypaymentindesignTypeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.isOA = self.isOA;
    cell.one = self.one;
    cell.ThreeOkdata  =self.ThreeOkdata;
    if (!self.ThreeOkdata.bankCardsArray.count) {
        cell.more.hidden = YES;
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.empty_type == fail_empty_num) {
        return 0;
    } else {
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            return 2;
        }else{
            return 1;
        }
    }
}

- (void)retryPay{
    if (self.boxview) {
        [self.boxview firstINput];
    } else {
        [self OpenPasswordpaymentbox];
    }
}

- (void)Passwordinputsuccessful:(NSString *)inText{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"付款中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_orderpayThirdOrderWithorderId:self.pasteboarddata[@"businessID"] payMethod:self.one?@"BANK":@"BAL" bindId:self.one?self.one.bindId:nil orderPrice:[NSNumber numberWithDouble:[self.pasteboarddata[@"money"] doubleValue]]  tcoinFlag:self.tcoinFlag payPassword:inText verifyCode:self.smsCode success:^(id dataDict, NSString *msg, NSInteger code) {
        NSNotification *notification2 =[NSNotification notificationWithName:@"loadNewData" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification2];
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        //        [MBProgressHUD showPrompt:@"支付成功,即将返回"];
        [weakself paySucces:dataDict];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself.boxview closeClisck];
        //                [weakself doneSucces];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [weakself payFailWith:errorCode :msg];
        [weakself.boxview.input clearUpPassword];
    }];
}

- (void)paySucces:(id)dataDict{
    if (self.isOA) {
        [MBProgressHUD showPrompt:@"支付成功"];
        [self performSelector:@selector(returnOA:) withObject:dataDict afterDelay:0.5];
    } else {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (weakself.pasteboarddata) {
                [weakself performSelector:@selector(returenCustomaryAPPPro:) withObject:dataDict afterDelay:1.0];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"留在T钱包" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)returnOA:(id)dataDict{
    if (dataDict) {
        NSDictionary *dic = dataDict;
        [self returnOAwithPayWithretStatus:[dic valueForKeyPath:@"retStatus"] errorCode:[dic valueForKeyPath:@"errorCode"] errorMsg:[dic valueForKeyPath:@"errorMsg"] authCode:nil];
    } else {
        [self returnOAwithPayWithretStatus:@"-1" errorCode:@"" errorMsg:@"用户取消了支付" authCode:nil];
    }
}
- (void)returenCustomaryAPPPro:(id)data{
    if (self.isOA) {
        if (data) {
            NSDictionary *dic = data;
            [self returnOAwithPayWithretStatus:[dic valueForKeyPath:@"retStatus"] errorCode:[dic valueForKeyPath:@"errorCode"] errorMsg:[dic valueForKeyPath:@"errorMsg"] authCode:nil];
        } else {
            [self returnOAwithPayWithretStatus:@"-1" errorCode:@"" errorMsg:@"用户取消了支付" authCode:nil];
        }
    } else {
        NSDictionary *Copydata = nil;
        if (data) {
            Copydata = @{
                         @"mmssgg":@"支付成功",
                         };
        } else {
            Copydata = @{
                         @"mmssgg":@"用户取消",
                         };
        }
        NSString *WhoCalls = self.pasteboarddata[@"WhoCalls"]; 
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setData:[self returnDataWithDictionary:Copydata] forPasteboardType:@"dataToZeji"];
        if (WhoCalls) {
            NSString *url = [WhoCalls stringByAppendingString:[NSString stringWithFormat:@"://%@",[Copydata ToUrl]]];
            NSString *urlStringUTF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStringUTF8]];
        }
    }
    [self popSelf];
}
- (void)popSelfCanl{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您要放弃支付吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"继续支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakself.empty_type == succes_empty_num) {
            [weakself FootpayPre];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"放弃支付" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself returenCustomaryAPPPro:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(NSData *)returnDataWithDictionary:(NSDictionary*)dict
{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}

- (void)setGesturecipherVc{
    if ([[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1] || [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].GestureCipherStr) {
        CGFloat tmp = 5.0*60;
        if ([[PortalHelper sharedInstance]get_userInfo] && [[PortalHelper sharedInstance]get_setupdatePre] && [[NSDate date]secondsLaterThan:[[PortalHelper sharedInstance]get_setupdatePre].datePre] >=tmp) {
            if ( [[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].FingerprintPassword isEqualToString:STRING_1]) {
                
                SignInVc *losgin = [[SignInVc alloc]init];
                losgin.isUnlock = YES;
                [self.navigationController pushViewController:losgin animated:NO];
                kWeakSelf(self);
                [[PortalHelper sharedInstance] evaluateAuthenticateWith:^{
                    [weakself.navigationController popToViewController:weakself animated:YES];
                } With:^{
                    [MBProgressHUD showPrompt:@"请使用手机号登录"];
                }];
            }else if ( [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].GestureCipherStr) {
                GesturecipherVc *vc = self.navigationController.topViewController;
                if (![vc isKindOfClass:[GesturecipherVc class]] || vc.state != GestureResultPassword) {
                    GesturecipherVc *vc = [GesturecipherVc new];
                    vc.state = GestureResultPassword;
                    [self.navigationController pushViewController:vc animated:NO];
                }
            } else {
                if ([[PortalHelper sharedInstance] get_userInfo]) {
                    [[PortalHelper sharedInstance]set_userInfo:nil];
                    [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
                }
                SignInVc *losgin = [[SignInVc alloc]init];
                losgin.isUnlock = YES;
                [self.navigationController pushViewController:losgin animated:NO];
            }
        }
    }
}
@end
