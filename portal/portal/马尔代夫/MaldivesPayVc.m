//
//  MaldivesPayVc.m
//  portal
//
//  Created by Store on 2018/3/8.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "MaldivesPayVc.h"
#import "UIImageView+CornerRadius.h"
#import "payTypeSele.h"
#import "MaldivesPaySuccessVc.h"
#import "FindPassWordVc.h"
#import "MaldiVerificationCodeBox.h"
#import "YYLabel.h"
#import "NSAttributedString+YYText.h"
#import "Supporthotel.h"
@interface MaldivesPayVc ()
@property (nonatomic,weak) UIView *openstaue;
@property (nonatomic,weak) UIImageView *QRcodeview;
@property (nonatomic,weak) UIButton *QRcodeviewReset;
@property (nonatomic,weak) UIImageView *typeicon;
@property (nonatomic,weak) UILabel *typelabel;
@property (nonatomic,weak) UILabel *payStaue;

@property (nonatomic,weak) UIView *closestaue;
@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,strong) NSTimer *scrollTimer;
@property (nonatomic,strong) ThreeOk *ThreeOkdata;

@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,assign) BOOL isNeedPay;

@property (nonatomic,strong) NSString *payType;

@end

@implementation MaldivesPayVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"向商家付款";
    self.view.backgroundColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:70/255.0 alpha:1/1.0];
    [self.header beginRefreshing];
    
    self.payType = @"BAL";
    [self setjiudian];
}
- (void)setright{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"更多点点"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnThree) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* more = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = more;
}
- (void)setjiudian{
    YYLabel *label = [YYLabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view);
//        make.left.equalTo(self.openstaue);
//        make.right.equalTo(self.openstaue);
    }];
    
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"注：支持商户扫码进行付款，点击查看", @"")];
    one.yy_font = PingFangSC_Regular(12);
    one.yy_color =  [UIColor colorWithRed:109/255.0 green:121/255.0 blue:139/255.0 alpha:1/1.0];
    //        one.yy_lineSpacing = 10;
    [text appendAttributedString:one];
    
    
    NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"支持酒店", @"")];
    two.yy_font = PingFangSC_Regular(12);
    //        two.yy_lineSpacing = 10;
    two.yy_color = ColorWithHex(0x5F7FFC, 1.0);
    two.yy_underlineStyle = NSUnderlineStyleSingle;
    [two yy_setTextHighlightRange:two.yy_rangeOfAll
                            color:ColorWithHex(0x5F7FFC, 1.0)
                  backgroundColor:[UIColor clearColor]
                        tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                            SupportHotel *Supporthotel = [SupportHotel new];
                            [Supporthotel windosViewshow];
                            NSLog(@"%s",__func__);
                        }];
    [text appendAttributedString:two];

    //        text.yy_lineSpacing = 10;
    label.numberOfLines = 0;  //设置多行显示
    label.textAlignment = NSTextAlignmentCenter;
    label.preferredMaxLayoutWidth = SCREENWIDTH - 40; //设置最大的宽度
    label.attributedText = text;
}
- (void)payList{
    //    GlobalParameter *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
    //    [self openEachWkVcWithId:data.loanUrl];
    [self openEachWkVcWithId:[NSString stringWithFormat:@"%@?t=2",[[PortalHelper sharedInstance] get_Globaldata].myBillUrl.absoluteString]];
}
- (void)useInstructions{
    GlobalParameter *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
    [self openEachWkVcWithId:data.qrCodeInsUrl];
}
- (void)btnThree{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"付款记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself payList];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"使用说明" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself useInstructions];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [weakself paySuccess];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_qrCodecheckPayQRCodeStatussuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [weakself.header endRefreshing];
        weakself.tableView.hidden = YES;
        NSString *status = dataDict[@"status"];
        if ([status isEqualToString:@"1"]) {
            [weakself setopen_staue];
        } else {
            [weakself setclose_staue];
        }
//        [weakself setclose_staue];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}

- (void)setopen_staue{
    UIView *openstaue = [UIView new];
    [self.view addSubview:openstaue];
    self.openstaue = openstaue;
    openstaue.backgroundColor = [UIColor whiteColor];
    [openstaue SetFilletWith:8.0];
    [openstaue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(41);
        make.height.mas_equalTo(openstaue.mas_width).multipliedBy(420/335.0);
    }];
    
    {
        UIImageView *view = [[UIImageView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1/1.0];
        [self.openstaue addSubview:view];
        [view zy_cornerRadiusAdvance:4.0 rectCornerType:UIRectCornerTopLeft|UIRectCornerTopRight];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.openstaue);
            make.right.equalTo(self.openstaue);
            make.top.equalTo(self.openstaue);
            make.height.equalTo(@50);
        }];
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"个人收钱图标"];
        [view addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.openstaue).offset(20);
            make.centerY.equalTo(view);
            make.width.equalTo(@11);
            make.height.equalTo(@15);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"付款码";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:70/255.0 alpha:1/1.0];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.centerY.equalTo(view);
        }];
    }
    {
        UIImageView *view = [[UIImageView alloc] init];
        [self.openstaue addSubview:view];
        self.QRcodeview = view;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.openstaue);
            make.top.equalTo(self.openstaue).offset(50*PROPORTION_HEIGHT+50);
            make.left.equalTo(self.openstaue).offset(88*PROPORTION_WIDTH);
            make.right.equalTo(self.openstaue).offset(-88*PROPORTION_WIDTH);
            make.height.mas_equalTo(view.mas_width);
        }];
        
        UIButton *btn = [UIButton new];
        [self.openstaue addSubview:btn];
        [btn setWithNormalColor:0x5F7FFC NormalAlpha:1.0 NormalTitle:@"刷新二维码" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        self.QRcodeviewReset = btn;
        [self.QRcodeviewReset addTarget:self action:@selector(QRcodeviewResetBtn) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.openstaue);
            make.top.equalTo(self.QRcodeview.mas_bottom).offset(15*PROPORTION_HEIGHT);
            make.left.equalTo(self.openstaue).offset(88*PROPORTION_WIDTH);
            make.width.equalTo(@85);
            make.height.equalTo(@44);
        }];

    }
    {
        UIImageView *view = [[UIImageView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1/1.0];
        [self.openstaue addSubview:view];
        [view zy_cornerRadiusAdvance:4.0 rectCornerType:UIRectCornerBottomLeft|UIRectCornerBottomRight];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.openstaue);
            make.right.equalTo(self.openstaue);
            make.bottom.equalTo(self.openstaue);
            make.height.equalTo(@50);
        }];
        
        UILabel *typelabel = [[UILabel alloc] init];
        self.typelabel = typelabel;
        typelabel.text = @"零钱";
        typelabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        typelabel.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
        [self.openstaue addSubview:typelabel];
        [typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view).offset(8.5);
            make.centerY.equalTo(view);
        }];
        
        UIImageView *typeicon = [[UIImageView alloc] init];
        self.typeicon = typeicon;
        typeicon.image = [UIImage imageNamed:@"零钱图标"];
        [self.openstaue addSubview:typeicon];
        [typeicon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(typelabel.mas_left).offset(-10);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
        }];

        UIImageView *more = [[UIImageView alloc] init];
        [self.openstaue addSubview:more];
        more.image = [UIImage imageNamed:@"选择更多按钮"];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(typelabel.mas_right).offset(5);
            make.width.equalTo(@6);
            make.height.equalTo(@10.7);
        }];
        
        UIButton *btnMore = [UIButton new];
        [self.openstaue addSubview:btnMore];
        [btnMore addTarget:self action:@selector(btnMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.bottom.equalTo(view);
            make.left.equalTo(typeicon);
            make.right.equalTo(more);
        }];

        UILabel *payStaue = [[UILabel alloc] init];
        self.payStaue = payStaue;
        payStaue.textAlignment = NSTextAlignmentRight;
        typelabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        payStaue.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
        [self.openstaue addSubview:payStaue];
        [payStaue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btnMore);
            make.left.equalTo(btnMore.mas_right).offset(10);
            make.right.equalTo(view).offset(-10);
        }];
    }
    [self QRcodeviewResetBtn];
//    setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
//    if ([setUp_dataBlock.ScavengingType isEqualToString:@"BANK"]) {
//        [self typeChageLoad];
//    }
}

//获取 /刷新二维码
- (void)QRcodeviewResetBtn{
    kWeakSelf(self);
//    setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
    if (!self.QRcodeview.image) {
        [MBProgressHUD showLoadingMessage:@"付款码请求中..." toView:self.view];
    }
    [[ToolRequest sharedInstance]URLBASIC_qrCodegeneratePayQRCodeWithpayMethod:self.payType devicesToken:[[PortalHelper sharedInstance]get_deviceToken].deviceToken success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        NSString *qrcUrl = dataDict[@"qrcUrl"];
        weakself.orderId = dataDict[@"orderId"];
        [weakself.QRcodeview sd_setImageWithURL:[NSURL URLWithString:qrcUrl]];
        [weakself removeTimer];
        [weakself creatTimer];
        [weakself setright];
        weakself.payStaue.text = nil;
        [weakself.QRcodeviewReset setTitle:@"刷新二维码" forState:UIControlStateNormal];
    } failure:^(NSInteger errorCode, NSString *msg) {
//        [weakself removeTimer];
//        [weakself creatTimer];
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showError:msg toView:weakself.view];
        [weakself removeTimer];
        weakself.QRcodeview.image = [UIImage imageNamed:@"l网络不佳ogo遮挡图标"];
        [weakself.QRcodeviewReset setTitle:@"网络不佳，请刷新二维码" forState:UIControlStateNormal];
    }];
}

//更换支付方式
- (void)btnMoreBtn{
    if (self.ThreeOkdata) {
        payTypeSele *view = [payTypeSele new];
        view.ThreeOkdata = self.ThreeOkdata;
        kWeakSelf(self);
        view.ThreeselecetType = ^(ThreeOkBankOne *one) {
//            setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
            if ((one && [self.payType isEqualToString:@"BAL"]) || (!one && [self.payType isEqualToString:@"BANK"])) {
                if (one) {
                    self.payType = @"BANK";
                    [weakself.typeicon sd_setImageWithURL:one.bankIcon];
                    weakself.typelabel.text = [NSString stringWithFormat:@"%@(%@)",one.bankName,one.cardNo];
                } else {
                    self.payType = @"BAL";
                    weakself.typelabel.text = @"零钱";
                    weakself.typeicon.image = [UIImage imageNamed:@"零钱图标"];
                }
//                [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
                [weakself QRcodeviewResetBtn];
            }
        };
        [view windosViewshow];
    } else {
        [MBProgressHUD showLoadingMessage:@"加载中..." toView:self.view];
        [self typeChageLoad];
    }
}

- (void)typeChageLoad{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpurseuserqueryPayMethodsuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        weakself.ThreeOkdata = [ThreeOk mj_objectWithKeyValues:dataDict];
        ThreeOkBankOne *one;
        if (weakself.ThreeOkdata.bankCardsArray.count>=1) {
            one = weakself.ThreeOkdata.bankCardsArray.firstObject;
        }
//        setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
        if ([self.payType isEqualToString:@"BANK"]) {
            
            [weakself.typeicon sd_setImageWithURL:one.bankIcon];
            weakself.typelabel.text = [NSString stringWithFormat:@"%@(%@)",one.bankName,one.cardNo];
        } else if([self.payType isEqualToString:@"BAL"]){
            weakself.typelabel.text = @"零钱";
            weakself.typeicon.image = [UIImage imageNamed:@"零钱图标"];
            [weakself btnMoreBtn];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}
- (void)setclose_staue{
    UIView *closestaue = [UIView new];
    [self.view addSubview:closestaue];
    self.closestaue = closestaue;
    closestaue.backgroundColor = [UIColor whiteColor];
    [closestaue SetFilletWith:8.0];
    [closestaue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(41);
        make.height.mas_equalTo(closestaue.mas_width).multipliedBy(400/335.0);
    }];
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
        imageView.image = [UIImage imageNamed:@"插图.png"];
        [self.closestaue addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.closestaue).offset(0);
            make.right.equalTo(self.closestaue).offset(0);
            make.top.equalTo(self.closestaue).offset(0);
            make.height.mas_equalTo(closestaue.mas_width).multipliedBy(309/335.0);
        }];
    }
    {
        UIView *back = [UIView new];
        [self.closestaue addSubview:back];
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.closestaue);
            make.right.equalTo(self.closestaue);
            make.top.equalTo(self.imageView.mas_bottom);
            make.bottom.equalTo(self.closestaue);
        }];
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:@"立即开启" NormalImage:nil NormalBackImage:@"立即开启按钮" SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x0 backAlpha:0.0];
        [self.closestaue addSubview:btn];
        [btn addTarget:self action:@selector(openQRCodebtn) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.closestaue).offset(48);
            make.right.equalTo(self.closestaue).offset(-48);
            make.centerY.equalTo(back);
            make.height.equalTo(@50);
        }];
    }
}
- (void)openQRCodebtn{
    [self OpenPasswordpaymentbox];
    [self.boxview.RightBtn setWithNormalColor:0xF7FFC NormalAlpha:0.7 NormalTitle:NSLocalizedString(@"忘记密码?", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
}
- (void)Passwordinputsuccessful:(NSString *)inText{
    if (self.openstaue) {
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:@"密码校验中..." toView:self.view];
        [[ToolRequest sharedInstance]URLBASIC_qrCodecheckPayPasswordWithpayPassword:inText orderId:weakself.orderId success:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showSuccess:@"密码校验成功" toView:weakself.view];
            
            [weakself.boxview closeClisck];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showError:msg toView:weakself.view afterDelay:2.0f];
            [weakself.boxview.input clearUpPassword];
        }];
    }else{
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:@"开启中..." toView:self.view];
        [[ToolRequest sharedInstance]URLBASIC_qrCodescanQRCodeWithpayPassword:inText success:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showSuccess:@"开启成功" toView:weakself.view];
            
            [weakself.closestaue removeFromSuperview];
            [weakself setopen_staue];
            [weakself.boxview closeClisck];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showError:msg toView:weakself.view afterDelay:2.0f];
            [weakself.boxview.input clearUpPassword];
        }];
    }
}


////定时器
#pragma mark----创建定时器
-(void)creatTimer
{
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:120.0 target:self selector:@selector(QRcodeviewResetBtn) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
}
#pragma mark----移除定时器
-(void)removeTimer
{
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}
- (void)dealloc{
    [self removeTimer];
    [self removeTimer];
}

- (void)paySuccess{
    MaldivesPaySuccessVc *vc = [MaldivesPaySuccessVc new];
    vc.CTrollersToR = @[[self class]];
    [self.navigationController pushViewController:vc animated:YES];
    
}
////重写父类方法  去找回密码
- (void)PasswordRetrieval{
    [self sendSmsCodebindId:0 Money:0 codeId:@"16"];
}
-(void)OpenChangePassWordVc{
    [self OPenVc:[FindPassWordVc new]];
}

- (void)OpenVerificationCodeBox{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 127.f;
    MaldiVerificationCodeBox *view = [MaldiVerificationCodeBox new];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isNeedPay && [self.payStaue.text isEqualToString:@"支付中..."]){
        [self OpenPasswordpaymentbox];
        [self.boxview.RightBtn setWithNormalColor:0xF7FFC NormalAlpha:0.7 NormalTitle:NSLocalizedString(@"忘记密码?", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    }
}
- (void)setNoticationdata:(MaldivesPush *)noticationdata{
    _noticationdata = noticationdata;
    NSLog(@"sdfsdf");
    self.payStaue.text = nil;
    if ([noticationdata.type isEqualToString:@"1"]) {
        [self OpenPasswordpaymentbox];
        [self.boxview.RightBtn setWithNormalColor:0xF7FFC NormalAlpha:0.7 NormalTitle:NSLocalizedString(@"忘记密码?", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        self.payStaue.text = @"支付中...";
        self.isNeedPay = YES;
    } else if ([noticationdata.type isEqualToString:@"3"]) {
        if ([noticationdata.conten.resultStatus isEqualToString:@"0"]) {
            MaldivesPaySuccessVc *vc = [MaldivesPaySuccessVc new];
            vc.CTrollersToR = @[[self class]];
            vc.noticationdata = self.noticationdata;
            [self OPenVc:vc];
        } else if ([noticationdata.conten.resultStatus isEqualToString:@"1"]) {
            self.payStaue.text = @"处理中...";
        } else if ([noticationdata.conten.resultStatus isEqualToString:@"2"]) {
            self.payStaue.text = @"支付失败";
            [MBProgressHUD showError:noticationdata.conten.message];
            [self QRcodeviewResetBtn];
        }
    } else if ([noticationdata.type isEqualToString:@"2"]) {
        self.payStaue.text = @"支付中...";
    }
}
@end
