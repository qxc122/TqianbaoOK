//
//  AuthenticationVc.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AuthenticationVc.h"
#import "RealNameHead.h"
#import "AuthenticationSmsVc.h"
#import "AuthenticationpasswordVc.h"
#import "AuthenticationCell.h"
@interface AuthenticationVc ()
@property (nonatomic,strong) NSMutableArray *Arry_data;
@end

@implementation AuthenticationVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.registerClasss = @[[AuthenticationCell class]];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    
    [self addHeadAndFoot];
}
- (void)addHeadAndFoot{
    CGFloat tmp = 130;
    if (IPoneX) {
        tmp += 20;
    }
    RealNameHead *head = [[RealNameHead alloc]initWithFrame:CGRectMake(0, 0, 0, tmp)];
    head.pading= 27;
    head.title.text = NSLocalizedString(@"请先选择身份验证方式", @"");
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    self.tableView.tableHeaderView = head;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *one = self.Arry_data[indexPath.row];
    UIViewController *vc;
    if ([one.title isEqualToString:NSLocalizedString(@"短信验证码", @"")]) {
        vc = [AuthenticationSmsVc new];
    } else if ([one.title isEqualToString:NSLocalizedString(@"支付密码", @"")]) {
        vc = [AuthenticationpasswordVc new];
    }
    if (vc) {
        [self OPenVc:vc]; 
    }
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AuthenticationCell *cell = [AuthenticationCell returnCellWith:tableView];
    [self configureAuthenticationCell:cell atIndexPath:indexPath];
    return  cell;
}
#pragma --mark< 配置SignInaddBankCardsmscell 的数据>
- (void)configureAuthenticationCell:(AuthenticationCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.Arry_data[indexPath.row];
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        
        setUpData *tmp1 = [setUpData new];
        tmp1.title = NSLocalizedString(@"短信验证码", @"");
        [_Arry_data addObject:tmp1];
        
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            setUpData *tmp2 = [setUpData new];
            tmp2.title = NSLocalizedString(@"支付密码", @"");
            [_Arry_data addObject:tmp2];
        }
        
    }
    return _Arry_data;
}

@end
