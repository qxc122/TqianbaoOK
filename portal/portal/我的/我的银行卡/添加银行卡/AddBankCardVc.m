//
//  AddBankCardVc.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AddBankCardVc.h"

#import "addBankCarkHead.h"


@interface AddBankCardVc ()

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *idNum;
@property (nonatomic,strong) bankCard *banKname;
@property (nonatomic,strong) NSString *banKNum;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *phonePre;
@property (nonatomic,strong) NSString *sms;
@property (nonatomic,strong) NSString *smsStaue;

//@property (nonatomic,weak) UITextField *intput;
@end

@implementation AddBankCardVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"绑定银行卡", @"");
    self.registerClasss = @[[baseFillCell class],[addBankCardselectBankcell class],[addBankCardsmscell class],[ReaNameaddBankCardsmscell class],[ReaNameaddBankCardselectBankcell class],[ReaNamebaseFillCell class]];

//    self.empty_type = succes_empty_num;
//    self.header.hidden = YES;

//    [self addHeadAndFoot];
    
    [self.header beginRefreshing];
}

- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_userqueryWithfilterFlag:self.filterFlag Bankssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        bankList *bankListdata = [bankList mj_objectWithKeyValues:dataDict];
        weakself.bankListdata = bankListdata;
        [[PortalHelper sharedInstance] set_bankListdata:bankListdata];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        weakself.name = bankListdata.userRealName;
        weakself.idNum = bankListdata.certNo;
        bankCard *tmp = [bankCard new];
        tmp.bindId = bankListdata.bindId;
        tmp.bankName = bankListdata.bankName;
        tmp.bankIcon = [NSURL URLWithString:bankListdata.bankIcon];
        tmp.cardNo = bankListdata.cardNo;
        weakself.banKname = tmp;
        weakself.banKNum = bankListdata.cardNo;
        
        weakself.phonePre = bankListdata.bankMobile;
        weakself.phone = bankListdata.bankMobile;
        
        if ([weakself.phone IsTelNumber]) {
            weakself.smsStaue = @"eeee";
        }
        [weakself addHeadAndFoot];
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        weakself.header.hidden = YES;
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}

- (void)addHeadAndFoot{
    NSString *des = NSLocalizedString(@"我们承诺严密保障您的个人信息安全，请放心认证", @"");
    addBankCarkHead *head = [[addBankCarkHead alloc]initWithFrame:CGRectMake(0, 0, 0, [des HeightWithFont:PingFangSC_Regular(12) withMaxWidth:SCREENWIDTH-40]+13+13)];
    head.des = des;
    self.tableView.tableHeaderView = head;
    
    [self addFoot];
}

- (void)addFoot{
    addBankCarkFoot *foot = [[addBankCarkFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+60)];
    self.foot = foot;
    foot.btn.enabled = NO;
    kWeakSelf(self);
    foot.doneBtn = ^{
        [weakself bingBank];
        NSLog(@"%s",__func__);
    };
    foot.openWkWebVc = ^(id url) {
        [weakself openbaseWkVcWithId:url];
    };
    self.tableView.tableFooterView = foot;
}

- (void)bingBank{
    NSString *name;
    NSString *idNum;
    NSString *banKNum;
    NSString *bankCode;
    NSString *finaFlag;
    NSNumber *useBindId;

    if ([self.filterFlag isEqualToString:@"1"]) {
        finaFlag = @"1";
    } else {
        finaFlag = @"0";
    }
    if (self.bankListdata.cardNo.length && [self.banKNum isEqualToString:self.bankListdata.cardNo]) {
        useBindId = self.bankListdata.bindId;
    }
    
    if (!useBindId) {
        name = self.name;
        idNum = self.idNum;
        banKNum = self.banKNum;
        bankCode = self.banKname.bankCode;
    }
    
    if (!self.name || !self.name.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的姓名", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }

    if ((!self.idNum || !self.idNum.length || ![self.idNum IsIdCardNumber]) && ![self.idNum isEqualToString:self.bankListdata.certNo]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的身份证号码", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    
    if (!self.banKname) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请选择银行", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    if (!self.banKNum || !self.banKNum.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的银行卡号", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    if (!self.phone || !self.phone.length || ![self.phone IsTelNumber]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的手机号", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    if (!self.sms || !self.sms.length || self.sms.length != 6) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入六位验证码", @"") toView:self.view afterDelay:self.sesPro];
        return;
    }
    
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"添加中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_userbindBankCardWithrealName:name certNo:idNum cardNo:banKNum bankCode:bankCode bankMobile:self.phone verifyCode:self.sms operType:@"1" finaFlag:finaFlag useBindId:useBindId success:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfoDeatil *tmp = [[PortalHelper sharedInstance]get_userInfoDeatil];
        tmp.realFlag = @"1";
        [[PortalHelper sharedInstance]set_userInfoDeatil:tmp];
        
        UserInfo *tmp2 = [[PortalHelper sharedInstance]get_userInfo];
        tmp2.realFlag = @"1";
        [[PortalHelper sharedInstance]set_userInfo:tmp2];
        
        weakself.isSuccess = YES;
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:NSLocalizedString(@"添加成功", @"") toView:weakself.view afterDelay:2.0f];
        [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:2.0f];
        
        NSNotification *notification = [NSNotification notificationWithName:ADD_BANK_CARD_SUCCESS object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        NSNotification *notification2 =[NSNotification notificationWithName:@"loadNewData" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification2];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
    }];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *one = self.Arry_data[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"持卡银行", @"")]) {
        addBankCardselectBankcell *cell = [addBankCardselectBankcell returnCellWith:tableView];
        [self configureaddBankCardselectBankcell:cell atIndexPath:indexPath];
        return  cell;
    }else if ([one.title isEqualToString:NSLocalizedString(@"验证码", @"")]) {
        addBankCardsmscell *cell = [addBankCardsmscell returnCellWith:tableView];
        [self configureaddBankCardsmscell:cell atIndexPath:indexPath];
        return  cell;
    } else {
        baseFillCell *cell = [baseFillCell returnCellWith:tableView];
        [self configurebaseFillCell:cell atIndexPath:indexPath];
        return  cell;
    }
}
#pragma --mark< 配置addBankCard_smscell 的数据>
- (void)configureaddBankCardselectBankcell:(addBankCardselectBankcell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self configurebaseFillCell:cell atIndexPath:indexPath];
    kWeakSelf(self);
    cell.selectBank = ^{
        [weakself oPenBankListOrLoadData];
    };
    cell.bankCarddata = self.banKname;
}

- (void)oPenBankListOrLoadData{
    if ([[PortalHelper sharedInstance]get_bankListdata]) {
        [self oPenBankList];
    }else{
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"加载银行列表中", @"") toView:self.view];
        kWeakSelf(self);
        [self loadBankList:^{
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [weakself oPenBankList];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
        }];
    }
}
- (void)popSelf{
    if (self.block && [[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:@"1"]) {
        self.block();
    }
    [super popSelf];
}
- (void)oPenBankList{
    kWeakSelf(self);
//    if (self.intput) {
//        if ([self.intput canResignFirstResponder]) {
//            [self.intput canResignFirstResponder];
//        }
//    }
    [self.tableView endEditing:YES];
    SelectBank *backLists = [SelectBank new];
    backLists.SelectBank = ^(id bank){
        NSMutableArray *arryPath = [@[[NSIndexPath indexPathForRow:2 inSection:0]] mutableCopy];
        if ([bank isKindOfClass:[bankCard class]]) {
            bankCard *banKk = bank;
            if (![banKk.bankName isEqualToString:weakself.bankListdata.bankName] && [weakself.bankListdata.cardNo isEqualToString:weakself.banKNum]) {
                weakself.banKNum = nil;
                [arryPath addObject:[NSIndexPath indexPathForRow:3 inSection:0]];
            }
        }
        weakself.banKname = bank;
        [weakself.tableView reloadRowsAtIndexPaths:arryPath withRowAnimation:UITableViewRowAnimationNone];
        
        [weakself setFootBtn];
    };
    [backLists windosViewshow];
}

#pragma --mark< 配置addBankCard_smscell 的数据>
- (void)configureaddBankCardsmscell:(addBankCardsmscell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.smsOK = self.smsStaue;
    [self configurebaseFillCell:cell atIndexPath:indexPath];
    kWeakSelf(self);
    cell.doneClick = ^(baseCell_Click_type type) {
        if ([weakself.phone IsTelNumber]) {
            [weakself sendVerifyCodeWithmobile:weakself.phone IsNeedSend:YES];
        }else{
            [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的手机号", @"") toView:weakself.view afterDelay:weakself.sesPro];
        }
    };
}

#pragma --mark< 配置baseFillCell 的数据>
- (void)configurebaseFillCell:(baseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.Arry_data[indexPath.row];
    cell.inputInfo = one;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText,UITextField *intput) {
        if ([identifer isEqualToString:NSLocalizedString(@"请输入姓名", @"")]) {
            weakself.name = inText;
        }else if ([identifer isEqualToString:NSLocalizedString(@"请输入18位身份证号", @"")]) {
            weakself.idNum = inText;
        }else if ([identifer isEqualToString:NSLocalizedString(@"请输入银行卡号", @"")]) {
            weakself.banKNum = inText;
        }else if ([identifer isEqualToString:NSLocalizedString(@"请输入银行预留手机号", @"")]) {
            weakself.phone = inText;
            if ([inText IsTelNumber] && ![weakself.phonePre isEqualToString:weakself.phone]) {
                [weakself sendVerifyCodeWithmobile:weakself.phone IsNeedSend:NO];
            }
        }else if ([identifer isEqualToString:NSLocalizedString(@"请输入验证码", @"")]) {
            weakself.sms = inText;
        }
        [weakself setFootBtn];
    };
    if ([one.describe isEqualToString:NSLocalizedString(@"请输入姓名", @"")]) {
        cell.input.text = self.name;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请输入18位身份证号", @"")]) {
        cell.input.text = self.idNum;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请输入银行卡号", @"")]) {
        cell.input.text = self.banKNum;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请输入银行预留手机号", @"")]) {
        cell.input.text = self.phone;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请输入验证码", @"")]) {
       cell.input.text = self.sms;
    }
}
- (void)setFootBtn{
    if (self.name && self.name.length && self.idNum && self.idNum.length && self.banKNum && self.banKNum.length && self.phone && self.phone.length && self.sms && self.sms.length && self.banKname) {
        self.foot.btn.enabled = YES;
    } else {
        self.foot.btn.enabled = NO;
    }
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];

        setUpData *tmp1 = [setUpData new];
        tmp1.title = NSLocalizedString(@"姓名", @"");
        tmp1.describe = NSLocalizedString(@"请输入姓名", @"");
        tmp1.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        tmp1.keyboardType = UIKeyboardTypeDefault;
        tmp1.contentType = baseFillCellType_LettersAndChinese;
//        tmp1.existedLength = ;
        [_Arry_data addObject:tmp1];
        
        setUpData *tmp11 = [setUpData new];
        tmp11.title = NSLocalizedString(@"身份证", @"");
        tmp11.describe = NSLocalizedString(@"请输入18位身份证号", @"");
        tmp11.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        tmp11.keyboardType = UIKeyboardTypeASCIICapable;
        tmp11.contentType = baseFillCellType_ID;
        tmp11.existedLength = 18;
        [_Arry_data addObject:tmp11];
        
        setUpData *tmp2 = [setUpData new];
        tmp2.title = NSLocalizedString(@"持卡银行", @"");
        [_Arry_data addObject:tmp2];
        
        setUpData *tmp3 = [setUpData new];
        tmp3.title = NSLocalizedString(@"银行卡", @"");
        tmp3.describe = NSLocalizedString(@"请输入银行卡号", @"");
        tmp3.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        tmp3.keyboardType = UIKeyboardTypeNumberPad;
        tmp3.contentType = UIKeyboardTypeNumberPad;
        tmp3.existedLength = 30;
        [_Arry_data addObject:tmp3];
        
        setUpData *tmp4 = [setUpData new];
        tmp4.title = NSLocalizedString(@"手机号", @"");
        tmp4.describe = NSLocalizedString(@"请输入银行预留手机号", @"");
        tmp4.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        tmp4.keyboardType = UIKeyboardTypeNumberPad;
        tmp4.contentType = UIKeyboardTypeNumberPad;
        tmp4.existedLength = 11;
        [_Arry_data addObject:tmp4];
        
        setUpData *tmp5 = [setUpData new];
        tmp5.title = NSLocalizedString(@"验证码", @"");
        tmp5.describe = NSLocalizedString(@"请输入验证码", @"");
        tmp5.clearButtonMode = UITextFieldViewModeWhileEditing;
        tmp5.keyboardType = UIKeyboardTypeNumberPad;
        tmp5.contentType = baseFillCellType_NumbersAndletters;
        tmp5.existedLength = 6;
        
        
        [_Arry_data addObject:tmp5];

    }
    return _Arry_data;
}

- (void)sendVerifyCodeWithmobile:(NSString *)phone IsNeedSend:(BOOL)isNeedSend{
    self.smsStaue = @"eeee";
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.Arry_data.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];


    NSString *type;
    NSNumber *useBindId;
    NSString *realName;
    NSString *certNo;
    NSString *cardNo;
    NSString *bankCode;
    if ([self.filterFlag isEqualToString:@"1"]) {
        type = @"021";
    } else {
        type = SYSTEMSENDVERIFYCODEWITHMOBILETYPE_BING;
    }
    if (self.bankListdata.cardNo.length && [self.banKNum isEqualToString:self.bankListdata.cardNo]) {
        useBindId = self.bankListdata.bindId;
    }
    
    if (!useBindId) {
        realName = self.name;
        certNo = self.idNum;
        cardNo = self.banKNum;
        bankCode = self.banKname.bankCode;
    }
    if (!self.name || !self.name.length) {
        if (isNeedSend) {
            [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的姓名", @"") toView:self.view afterDelay:self.sesPro];
        }
        return;
    }
    
    if ((!self.idNum || !self.idNum.length || ![self.idNum IsIdCardNumber]) && ![self.idNum isEqualToString:self.bankListdata.certNo]) {
        if (isNeedSend) {
            [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的身份证号码", @"") toView:self.view afterDelay:self.sesPro];
        }
        return;
    }
    if (!self.banKname) {
        if (isNeedSend) {
            [MBProgressHUD showPrompt:NSLocalizedString(@"请选择银行", @"") toView:self.view afterDelay:self.sesPro];
        }
        return;
    }
    if (!useBindId && (!self.banKNum || !self.banKNum.length)) {
        if (isNeedSend) {
            [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的银行卡号", @"") toView:self.view afterDelay:self.sesPro];
        }
        return;
    }
    if (!self.phone || !self.phone.length || ![self.phone IsTelNumber]) {
        if (isNeedSend) {
            [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的手机号", @"") toView:self.view afterDelay:self.sesPro];
        }
        return;
    }
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"发送中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance] systemsendVerifyCodeForBindCardWithmobile:self.phone type:type useBindId:useBindId realName:realName certNo:certNo cardNo:cardNo bankCode:bankCode success:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.phonePre = phone;
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:NSLocalizedString(@"发送成功", @"") toView:weakself.view afterDelay:weakself.sesPro];
        weakself.smsStaue = @"YES";
        [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.Arry_data.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
    }];
//
//    [[ToolRequest sharedInstance]systemsendVerifyCodeWithmobile:self.phone type:SYSTEMSENDVERIFYCODEWITHMOBILETYPE_BING success:^(id dataDict, NSString *msg, NSInteger code) {
//        weakself.phonePre = phone;
//        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
//        [MBProgressHUD showPrompt:NSLocalizedString(@"发送成功", @"") toView:weakself.view afterDelay:weakself.sesPro];
//        weakself.smsStaue = @"YES";
//        [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.Arry_data.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//    } failure:^(NSInteger errorCode, NSString *msg) {
//        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
//        [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
//    }];
}

@end
