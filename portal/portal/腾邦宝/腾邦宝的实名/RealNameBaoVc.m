//
//  RealNameBaoVc.m
//  portal
//
//  Created by Store on 2018/1/25.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "RealNameBaoVc.h"
#import "RiskManagementVc.h"
@interface RealNameBaoVc ()

@end

@implementation RealNameBaoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ADD_BANK_CARD_SUCCESSFunc:)
                                                 name:ADD_BANK_CARD_SUCCESS
                                               object:nil];
}
- (void)ADD_BANK_CARD_SUCCESSFunc:(NSNotification *)user{
    RiskManagementVc *vc = [RiskManagementVc new];
    vc.CTrollersToR = @[[self class]];
    vc.url = self.url;
    [self OPenVc:vc];
}
@end
