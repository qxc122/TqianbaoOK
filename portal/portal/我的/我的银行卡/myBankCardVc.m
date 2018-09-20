//
//  myBankCard.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "myBankCardVc.h"
#import "BankCardCell.h"
#import "myBankCardFoot.h"
#import "AddBankCardVc.h"

#ifdef DEBUG
#import "RealNameVc.h"
#endif
@interface myBankCardVc ()
@property (nonatomic,strong) NSMutableArray *Arry_card;
@end

@implementation myBankCardVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.Arry_card = [NSMutableArray array];
    self.NodataTitle = @"暂未绑定银行卡";
    self.registerClasss = @[[BankCardCell class]];
    self.title = NSLocalizedString(@"我的银行卡", @"");

    self.view.backgroundColor = COLOUR_BACK_NORMAL;
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);

//    self.userData = [[PortalHelper sharedInstance]get_userInfoDeatil];
//    self.empty_type = succes_empty_num;
//    self.header.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ADD_BANK_CARD_SUCCESSFunc:)
                                                 name:ADD_BANK_CARD_SUCCESS
                                               object:nil];
    [self.header beginRefreshing];
    
//    myBankCardFoot *foot = [[myBankCardFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
//    kWeakSelf(self);
//    foot.addBankCard = ^{
//        NSLog(@"%s",__func__);
//        AddBankCardVc *vc =[AddBankCardVc new];
//        vc.title = NSLocalizedString(@"绑定银行卡", @"");
//        [weakself OPenVc:vc]; 
//    };
//    self.tableView.tableFooterView = foot;
}
- (void)setBackColor{
    if (self.Arry_card.count) {
        self.tableView.backgroundColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
    } else {
        self.tableView.backgroundColor = [UIColor clearColor];
    }
}
- (void)ADD_BANK_CARD_SUCCESSFunc:(NSNotification *)user{
    self.header.hidden = NO;
    [self.header beginRefreshing];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.header.isRefreshing && !self.Arry_card.count) {
        [self.tableView reloadData];
    }
}
- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpurseuserqueryMyBanksuccess:^(id dataDict, NSString *msg, NSInteger code) {
        bankList *tmpLIst = [bankList mj_objectWithKeyValues:dataDict];
        weakself.Arry_card = tmpLIst.Arry_list;
        
        
//        [weakself.Arry_card addObjectsFromArray:tmpLIst.Arry_list];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself setBackColor];
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
    
//    [[ToolRequest sharedInstance]URLBASIC_tpurseusermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
//        weakself.userData = [UserInfoDeatil mj_objectWithKeyValues:dataDict];
//        [[PortalHelper sharedInstance] set_userInfoDeatil:weakself.userData];
//#ifdef DEBUG
//        NSString *strTmp = [dataDict DicToJsonstr];
//        NSLog(@"strTmp=%@",strTmp);
//#endif
//        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
//    } failure:^(NSInteger errorCode, NSString *msg) {
//        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
//    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self neetInitActionControllerRowAtIndexPath:indexPath tableView:tableView];
}
- (void)neetInitActionControllerRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
    NSString *title = @"请联系客服更换银行卡，客服电话:";
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

    
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardCell *cell = [BankCardCell returnCellWith:tableView];
    [self configureBankCardCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureBankCardCell:(BankCardCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.bankCarddata = self.Arry_card[indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_card.count;
}

//按钮文本或者背景样式
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.empty_type == succes_empty_num){
        return [[NSAttributedString alloc]initWithString:@" "];
//        return [NSLocalizedString(@"Reload", @"Reload") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }else  {
       return  [super buttonTitleForEmptyDataSet:scrollView forState:state];
    }
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if(self.empty_type == succes_empty_num){
        return  [UIImage imageNamed:PIC_BANK_CARD_EMPTY];
    }else{
       return  [super buttonBackgroundImageForEmptyDataSet:scrollView forState:state];
    }
}

- (void)DidTap{
    if (self.empty_type == succes_empty_num) {
        [self OpenAddBankCardVc];
    }else{
        [super DidTap];
    }
}

- (void)OpenAddBankCardVc{
    AddBankCardVc *vc = [AddBankCardVc new];
    [self OPenVc:vc]; 
}
//- (void)setUserData:(UserInfoDeatil *)userData{
//    _userData = userData;
//    [self.Arry_card removeAllObjects];
//    for (bankCard *data in self.userData.Arry_list) {
//        if ([data.type isEqualToString:HOME_TYPE_BANK]) {
//            [self.Arry_card addObject:data];
//        }
//    }
//    [self setBackColor];
//}
@end
