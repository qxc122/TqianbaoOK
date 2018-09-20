//
//  manageMoneyVc.m
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "manageMoneyVc.h"

@interface manageMoneyVc ()
@property (nonatomic,weak) GlobalParameter *data;
@end

@implementation manageMoneyVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.data = [[PortalHelper sharedInstance]get_Globaldata];
//    if ([[PortalHelper sharedInstance]get_userInfo]) {
//        if (self.data) {
//            if (!self.url) {
//                self.url = self.data.finUrl;
//            }
//        } else {
//            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"请稍后...", @"") toView:self.view];
//            kWeakSelf(self);
//            [self appgetGlobalParamssuccess:^{
//                weakself.data = [[PortalHelper sharedInstance]get_Globaldata];
//                weakself.url = self.data.finUrl;
//                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
//            }];
//        }
//    }
    if (self.data) {
        if (!self.url) {
            self.url = self.data.finUrl;
        }
    } else {
        if ([PortalHelper sharedInstance].isReachable) {
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"请稍后...", @"") toView:self.view];
            kWeakSelf(self);
            [self appgetGlobalParamssuccess:^{
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                weakself.data = [[PortalHelper sharedInstance]get_Globaldata];
                weakself.url = self.data.finUrl;
            }];
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
        self.navigationController.title = @"理财";
        [self customBackButton];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)hideBottomBarWhenPush
{
    
}
- (void)customBackButton
{
    if ([self.webView canGoBack]) {
//            [self Execute_the_JS_statementWith:@"window.webkit.messageHandlers.displayFinancialButton.postMessage('123')"];
        
//                    [self Execute_the_JS_statementWith:@"alert('dfdf')"];
        [super customBackButton];
    }else{
        UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = leftBarutton;
    }
}

@end
