//
//  SetUpVc.m
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SetUpVc.h"
#import "safetySetUpVc.h"
#import "SetUpCell.h"
#import "XAlertView.h"
#import "LBToAppStore.h"
#import "HelpandfeedbackVc.h"
#import "baseWkVc.h"
@interface SetUpVc ()
@property (nonatomic,strong) NSMutableArray *Arry_data;
@property (nonatomic,weak) UIButton *exit;
@end

@implementation SetUpVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"设置", @"");
    // Do any additional setup after loading the view.
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    self.view.backgroundColor = COLOUR_BACK_NORMAL;
    self.registerClasss = @[[SetUpCell class]];

    UIButton *exit = [UIButton new];
    self.exit = exit;
    [self.view addSubview:exit];
    [exit setWithNormalColor:0x1E2E47 NormalAlpha:1.0 NormalTitle:nil NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0xFFFFFF backAlpha:1.0];
    [exit addTarget:self action:@selector(exitFUNc) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *des = [UILabel new];
    [self.view addSubview:des];
    [des setWithColor:0xCBCED3 Alpha:1.0 Font:12 ROrM:@"r"];
    des.text = [NSString stringWithFormat:@"%@%@",@"当前版本V",APP_VERSION];
    des.textAlignment = NSTextAlignmentCenter;
    
//  当前版本V3.0
    [exit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.exit.mas_top).offset(-15);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(des.mas_top);
    }];
}

- (void)exitFUNc{
    NSLog(@"%s",__func__);
    if ([[PortalHelper sharedInstance] get_userInfo]) {
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"退出中", @"") toView:self.view];
        kWeakSelf(self);
        [[ToolRequest sharedInstance]URLBASIC_tpurseuserlogoutsssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [[PortalHelper sharedInstance]set_userInfo:nil];
            [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
            [MBProgressHUD showPrompt:NSLocalizedString(@"退出成功", @"") toView:weakself.view afterDelay:1.0f];
            [weakself.tableView reloadData];
            [weakself.exit setTitle:[[PortalHelper sharedInstance] get_userInfo]?NSLocalizedString(@"退出登录", @""):NSLocalizedString(@"登录", @"") forState:UIControlStateNormal];
            
            NSNotification *notification =[NSNotification notificationWithName:@"LOGIN_EXIT_NOTIFICATION" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
        }];
    }else{
        [self openLoginView:nil];
    }
}
//- (void)setNotication{
//    NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION_NOBACK object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//    [self.tableView reloadData];
//    NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *tmp = self.Arry_data[indexPath.section];
    setUpData *one = tmp[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"安全设置", @"")]) {
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            safetySetUpVc *vc = [safetySetUpVc new];
            [self OPenVc:vc];
        } else {
            [self openLoginView:nil];
        }
    } else if ([one.title isEqualToString:NSLocalizedString(@"关于我们", @"")]) {
        baseWkVc *vc = [baseWkVc new];
        vc.url = [[PortalHelper sharedInstance]get_Globaldata].aboutUsUrl;
        [self OPenVc:vc]; 
    } else if ([one.title isEqualToString:NSLocalizedString(@"帮助与反馈", @"")]) {
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            HelpandfeedbackVc *vc = [HelpandfeedbackVc new];
            [self OPenVc:vc]; 
        } else {
            [self openLoginView:nil];
        }
    } else if ([one.title isEqualToString:NSLocalizedString(@"鼓励一下", @"")]) {
        LBToAppStore *toAppStore = [[LBToAppStore alloc]init];
        toAppStore.myAppID = AppIdAppStore;
        [toAppStore alertUserCommentView:self];
    } else if ([one.title isEqualToString:NSLocalizedString(@"清除缓存", @"")]) {
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你希望清除缓存吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"清除中", @"")];
            [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
                [[SDImageCache sharedImageCache]cleanDiskWithCompletionBlock:^{
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showPrompt:NSLocalizedString(@"清除成功", @"")];
                    [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
#ifdef DEBUG
    else if ([one.title isEqualToString:NSLocalizedString(@"正式测试环境切换", @"")]) {
        [[PortalHelper sharedInstance]set_userInfo:nil];
        [[PortalHelper sharedInstance]set_userInfoDeatil:nil];
        [[PortalHelper sharedInstance]set_HomeDataNew:nil];
        [[PortalHelper sharedInstance]set_Globaldata:nil];
        [[PortalHelper sharedInstance]set_appIdAndSecret:nil];
        [[PortalHelper sharedInstance]set_accessToken:nil];
        
        NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
        if ([strles isEqualToString:tesetURLAddress]) {
            [NSUserDefaults setObject:productURLAddress withKey:URLAddress];
            [MBProgressHUD showLoadingMessage:@"现在是正式环境，请重启APP"];
        } else if ([strles isEqualToString:productURLAddress]) {
            [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
            [MBProgressHUD showLoadingMessage:@"现在是测试环境，请重启APP"];
        }
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
                                                                                
                                                                            }
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                                 index++;
                             }
                         }];
    }
#endif

}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetUpCell *cell = [SetUpCell returnCellWith:tableView];
    [self configureSetUpCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureSetUpCell:(SetUpCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *tmp = self.Arry_data[indexPath.section];
    setUpData *one = tmp[indexPath.row];
    cell.data = one;
    if ([one.title isEqualToString:NSLocalizedString(@"清除缓存", @"")]) {
        NSInteger tmp = [[SDImageCache sharedImageCache] getSize];
        cell.des.text = [NSString stringWithFormat:@"%ldM",tmp/(1024*1024)];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.exit setTitle:[[PortalHelper sharedInstance] get_userInfo]?NSLocalizedString(@"退出登录", @""):NSLocalizedString(@"请登录", @"") forState:UIControlStateNormal];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != self.Arry_data.count-1) {
        return 10.0;
    }else{
        return 0.01;
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *tmp = self.Arry_data[section];
    return tmp.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.empty_type == succes_empty_num) {
        return self.Arry_data.count;
    }else{
        return 0;
    }
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];

        
        NSMutableArray *one = [NSMutableArray array];
        setUpData *tmp1 = [setUpData new];
        tmp1.title = NSLocalizedString(@"安全设置", @"");
        [one addObject:tmp1];
        [_Arry_data addObject:one];
        
        
        NSMutableArray *two = [NSMutableArray array];
        setUpData *tmp21 = [setUpData new];
        tmp21.title = NSLocalizedString(@"关于我们", @"");
        [two addObject:tmp21];
        
        setUpData *tmp22 = [setUpData new];
        tmp22.title = NSLocalizedString(@"帮助与反馈", @"");
        [two addObject:tmp22];
        [_Arry_data addObject:two];
        
        NSMutableArray *three = [NSMutableArray array];
        setUpData *tmp31 = [setUpData new];
        tmp31.title = NSLocalizedString(@"鼓励一下", @"");
        [three addObject:tmp31];
        
        setUpData *tmp32 = [setUpData new];
        tmp32.title = NSLocalizedString(@"清除缓存", @"");
        [three addObject:tmp32];
        
#ifdef DEBUG
        {
            setUpData *tmp32 = [setUpData new];
            tmp32.title = NSLocalizedString(@"正式测试环境切换", @"");
            [three addObject:tmp32];
        }
#endif
        
        [_Arry_data addObject:three];
    }
    return _Arry_data;
}
@end
