//
//  RiskManagementVc.m
//  portal
//
//  Created by Store on 2018/1/25.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "RiskManagementVc.h"
#import "turnOutVc.h"
#import "turnIntoVc.h"

@interface RiskManagementVc ()

@end

@implementation RiskManagementVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风险评估";
}

- (void)popSelf{
    if (self.isCloseBack && [self.webView canGoBack] && [self.title isEqualToString:@"声明"]) {
        [self.webView goBack];
    }else{
        kWeakSelf(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您还未完成本次风险评估，退出将不保留当前进度。确定退出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"继续评估" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)turnOutPageFunc:(NSDictionary *)dic{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        turnOutVc *vc = [turnOutVc new];
        vc.CTrollersToR = @[[self class]];
        [self OPenVc:vc];
    } else {
        kWeakSelf(self);
        [self openLoginView:^{
            turnOutVc *vc = [turnOutVc new];
            vc.CTrollersToR = @[[weakself class]];
            [weakself OPenVc:vc];
        }];
    }
}

- (void)turnIntoPageFunc:(NSDictionary *)dic{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        turnIntoVc *vc = [turnIntoVc new];
        vc.CTrollersToR = @[[self class]];
        [self OPenVc:vc];
    } else {
        kWeakSelf(self);
        [self openLoginView:^{
            turnIntoVc *vc = [turnIntoVc new];
            vc.CTrollersToR = @[[weakself class]];
            [weakself OPenVc:vc];
        }];
    }
}
@end
