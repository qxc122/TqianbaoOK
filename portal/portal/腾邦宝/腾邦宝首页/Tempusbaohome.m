//
//  Tempusbaohome.m
//  portal
//
//  Created by Store on 2018/1/19.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "Tempusbaohome.h"

@interface Tempusbaohome ()

@end

@implementation Tempusbaohome

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"bao账单"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    right1.accessibilityIdentifier = @"list";
    
    //为导航栏添加右侧按钮2
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"疑问"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    right2.accessibilityIdentifier = @"help";
    
    NSArray *arr = [[NSArray alloc]initWithObjects:right1, right2, nil];
    self.navigationItem.rightBarButtonItems = arr;
}
- (void)rightAction:(UIBarButtonItem *)btn{
    if ([btn.accessibilityIdentifier isEqualToString:@"list"]) {
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            EachWkVc *vc = [EachWkVc new];
            vc.url = [[PortalHelper sharedInstance]get_Globaldata].fundBillUrl;
            [self OPenVc:vc];
        } else {
            kWeakSelf(self);
            [self openLoginView:^{
                [weakself rightAction:btn];
            }];
        }
    } else if ([btn.accessibilityIdentifier isEqualToString:@"help"]) {
        EachWkVc *vc = [EachWkVc new];
        vc.url = [[PortalHelper sharedInstance]get_Globaldata].fundQaUrl;
        [self OPenVc:vc];
    }
}
@end
