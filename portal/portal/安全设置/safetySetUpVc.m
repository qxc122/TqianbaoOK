//
//  safetySetUpVc.m
//  portal
//
//  Created by Store on 2017/9/26.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "safetySetUpVc.h"
#import "SetUpCell.h"
#import "SetpaymentpasswordVc.h"
#import "RealNameVc.h"
#import "GesturecipherVc.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface safetySetUpVc ()
@property (nonatomic,strong) NSMutableArray *Arry_data;
//@property (nonatomic,strong) setUp *setUp_data;

@end

@implementation safetySetUpVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"安全设置", @"");
    // Do any additional setup after loading the view.
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    self.view.backgroundColor = COLOUR_BACK_NORMAL;
    self.registerClasss = @[[SetUpCell class]];
}

#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *tmp = self.Arry_data[indexPath.section];
    setUpData *one = tmp[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"支付密码", @"")] && ![[PortalHelper sharedInstance]get_userInfoDeatil].payPasswordFlag) {
        SetpaymentpasswordVc *vc = [SetpaymentpasswordVc new];
        vc.iLogin = NO;
        [self OPenVc:vc]; 
    } else if ([one.title isEqualToString:NSLocalizedString(@"手势密码登录", @"")]) {
        
    } else if ([one.title isEqualToString:NSLocalizedString(@"指纹登录", @"")]) {
        
    } else if ([one.title isEqualToString:NSLocalizedString(@"实名认证", @"")] && ![[[PortalHelper sharedInstance] get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
        RealNameVc *vc = [RealNameVc new];
        [self OPenVc:vc]; 
    }
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
    if ([one.title isEqualToString:NSLocalizedString(@"支付密码", @"")] || [one.title isEqualToString:NSLocalizedString(@"实名认证", @"")]) {
        cell.hidenswitchBtn = YES;
        cell.hidenMoreAndDes = NO;
        if ([one.title isEqualToString:NSLocalizedString(@"支付密码", @"")]) {
            if ([[PortalHelper sharedInstance]get_userInfo].payPasswordFlag) {
                cell.more.hidden = YES;
            } else {
                cell.more.hidden = NO;
            }
            cell.des.text = [[PortalHelper sharedInstance]get_userInfo].payPasswordFlag?NSLocalizedString(@"已设置", @""):NSLocalizedString(@"未设置", @"");
        } else if ([one.title isEqualToString:NSLocalizedString(@"实名认证", @"")]){
            if ([[[PortalHelper sharedInstance]get_userInfo].realFlag  isEqualToString:STRING_1]) {
                cell.more.hidden = YES;
            } else {
                cell.more.hidden = NO;
            }
            cell.des.text = [[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:STRING_1]?NSLocalizedString(@"已认证", @""):NSLocalizedString(@"去认证", @"");
        }
    } else if ([one.title isEqualToString:NSLocalizedString(@"手势密码登录", @"")] || [one.title isEqualToString:NSLocalizedString(@"指纹登录", @"")]) {
        cell.hidenswitchBtn = NO;
        cell.hidenMoreAndDes = YES;
        setUp *setUp_data = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
        if ([one.title isEqualToString:NSLocalizedString(@"指纹登录", @"")]) {
            cell.switchBtn.on = [setUp_data.FingerprintPassword isEqualToString:STRING_1]?YES:NO;
        } else if ([one.title isEqualToString:NSLocalizedString(@"手势密码登录", @"")]){
            cell.switchBtn.on = setUp_data.GestureCipherStr?YES:NO;
        }
        kWeakSelf(self);
        cell.switchBtnClick = ^(NSString *type, BOOL onOrOff) {
            setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
            if ([type isEqualToString:NSLocalizedString(@"手势密码登录", @"")]) {
                setUp_dataBlock.GestureCipher = onOrOff?@"1":@"0";
                if (onOrOff) {
                    [weakself Verificationbeforesettingpaymentpassword];
                }else{
                    setUp_dataBlock.GestureCipherStr = nil;
                    [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
                }
            } else if ([type isEqualToString:NSLocalizedString(@"指纹登录", @"")]) {
                setUp_dataBlock.FingerprintPassword = onOrOff?@"1":@"0";
                if (onOrOff) {
                    [self evaluateAuthenticate];
                }else{
                    [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
                }
            }
        };
    }
}

- (void)OpenGesturecipherVc{
    GesturecipherVc *vc = [GesturecipherVc new];
    vc.state = GestureSetPassword;
    [self OPenVc:vc];
}
- (void)Verificationbeforesettingpaymentpassword{
    AuthenticationpasswordVc *vc = [AuthenticationpasswordVc new];
    vc.type = AuthenticationpasswordVc_type_Reset;
    [self OPenVc:vc];
}
- (void)setFingerprintPassword{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != self.Arry_data.count-1) {
        return 10.0;
    }else{
        return 0.001;
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
        setUpData *tmp11 = [setUpData new];
        tmp11.title = NSLocalizedString(@"支付密码", @"");
        [one addObject:tmp11];
        
        
        setUpData *tmp12 = [setUpData new];
        tmp12.title = NSLocalizedString(@"手势密码登录", @"");
        [one addObject:tmp12];
        
        LAContext* context = [[LAContext alloc] init];
        NSError* error = nil;
        //首先使用canEvaluatePolicy 判断设备支持状态
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            setUpData *tmp13 = [setUpData new];
            tmp13.title = NSLocalizedString(@"指纹登录", @"");
            [one addObject:tmp13];
        }
        
        
        [_Arry_data addObject:one];
        
        
        NSMutableArray *two = [NSMutableArray array];
        setUpData *tmp21 = [setUpData new];
        tmp21.title = NSLocalizedString(@"实名认证", @"");
        [two addObject:tmp21];

        [_Arry_data addObject:two];
    }
    return _Arry_data;
}


- (void)evaluateAuthenticate
{
    //创建LAContext
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    NSString* result = @"请验证已有指纹";
    context.localizedFallbackTitle = @"";
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        kWeakSelf(self);
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //TODO
                setUp *setUp_dataBlock = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
                if (success) {
                    setUp_dataBlock.FingerprintPassword = @"1";
                    [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    [MBProgressHUD showError:@"开启成功" toView:weakself.view];
                }
                else
                {
                    setUp_dataBlock.FingerprintPassword = @"0";
                    [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    switch (error.code) {
                        case LAErrorUserCancel:
                        {
                            [MBProgressHUD showError:@"您取消了授权" toView:weakself.view];
                            break;
                        }
                        case LAErrorUserFallback:
                        {
                            [MBProgressHUD showError:@"您取消了授权" toView:weakself.view];
                            break;
                        }
                        default:
                        {
                            [MBProgressHUD showError:@"授权失败" toView:weakself.view];
                            break;
                        }
                    }
                }
                [[PortalHelper sharedInstance]set_setUp:setUp_dataBlock];
            }];
            
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"不支持指纹识别");
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
//- (setUp *)setUp_data{
//    if (!_setUp_data) {
//        _setUp_data = [[PortalHelper sharedInstance]get_setUp];
//        if (!_setUp_data) {
//            _setUp_data = [setUp new];
//        }
//    }
//    return _setUp_data;
//}

@end
