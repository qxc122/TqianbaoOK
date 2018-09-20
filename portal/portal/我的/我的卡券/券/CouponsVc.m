//
//  CouponsVc.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "CouponsVc.h"

@interface CouponsVc ()

@end

@implementation CouponsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.header.hidden = YES;
    if ([PortalHelper sharedInstance].isReachable) {
        self.empty_type = succes_empty_num;
    } else {
        self.empty_type = KRespondCodeNotConnect;
    }
    
    self.NodataTitle = @"暂无可用券";
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
}
#pragma --mark<网络从无连接到连接的通知>
- (void)NETWORK_FROM_CONNECTION_TO_CONNECTION_NOTIFICATIONFunC:(NSNotification *)user{
    if (self.tableView) {
        if (!self.header.isRefreshing && self.empty_type == KRespondCodeNotConnect) {
            self.empty_type = succes_empty_num;
            [self.tableView reloadData];
        }
    }
}
#pragma --<空白页处理>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.empty_type == succes_empty_num) {
        return [UIImage imageNamed:@"暂无可用券"];
    }else{
        return [super imageForEmptyDataSet:scrollView];
    }
    return nil;
}
@end
