//
//  noneNetForH5.m
//  portal
//
//  Created by MiNi on 2018/4/11.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "noneNetForH5.h"

@interface noneNetForH5 ()

@end

@implementation noneNetForH5
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页无法打开";
    self.empty_type =  KRespondCodeNotConnect;
    [self.tableView reloadData];
    self.fd_interactivePopDisabled = YES;
}
#pragma --mark<网络从无连接到连接的通知>
- (void)NETWORK_FROM_CONNECTION_TO_CONNECTION_NOTIFICATIONFunC:(NSNotification *)user{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)popSelf{
    if (self.navigationController.childViewControllers.count>=3) {
        UIViewController *tmp = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count-3];
        [self.navigationController popToViewController:tmp animated:YES];
    } else {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
//    [self.navigationController popViewControllerAnimated:YES];
}
@end
