//
//  Myfinancialmanagement.m
//  portal
//
//  Created by Store on 2017/10/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "Myfinancialmanagement.h"
#import "popSelecetView.h"
#import "MOTMutablePopView.h"
#import "WithdrawCashVc.h"
#import "RechargeVc.h"

@interface Myfinancialmanagement ()
@property (weak, nonatomic) UIButton *LeftBtn;
@property (weak, nonatomic) UIButton *RightBtn;

@property (weak, nonatomic) UIView *targetView;
@property (weak, nonatomic) popSelecetView *popselecetView;
@end

@implementation Myfinancialmanagement
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.popselecetView) {
        [self.popselecetView closeClisck];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"更多点点"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popselecetPopView) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem* more = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"更多点点"] style:UIBarButtonItemStylePlain target:self action:@selector(popselecetPopView)];
    
    UIBarButtonItem* more = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = more;
    
    
//    CGFloat tmp = 50;
//    if (IPoneX) {
//        tmp += 36;
//    }
//
//    UIButton *LeftBtn = [UIButton new];
//    self.LeftBtn  =LeftBtn;
//    LeftBtn.tag = 0;
//    [self.view addSubview:LeftBtn];
//
//
//    UIButton *RightBtn = [UIButton new];
//    self.RightBtn  =RightBtn;
//    RightBtn.tag = 1;
//    [self.view addSubview:RightBtn];
//
//
//
//    [LeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.width.equalTo(@(SCREENWIDTH*0.5));
//        make.bottom.equalTo(self.view);
//        make.height.equalTo(@(tmp));
//    }];
//
//    [RightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(LeftBtn.mas_right);
//        make.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.width.equalTo(@(SCREENWIDTH*0.5));
//        make.height.equalTo(@(tmp));
//    }];
//    RightBtn.backgroundColor = [UIColor redColor];
//    [RightBtn addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
//    [RightBtn addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)Btnclick:(UIButton *)btn{
    if (btn.tag == 0) {
        RechargeVc *vc = [RechargeVc new];
        vc.load_type = WithdrawCashVc_load_type_H5;
        [self OPenVc:vc];
    } else if (btn.tag == 1) {
        WithdrawCashVc *vc = [WithdrawCashVc new];
        vc.load_type = WithdrawCashVc_load_type_H5;
        vc.stateMoney = RechargeandcashwithdrawalVcState_WithdrawCash;
        [self OPenVc:vc];
    }
}

- (void)popselecetPopView{
    if (self.popselecetView) {
        [self.popselecetView closeClisck];
    }else{
//        popSelecetView *popselecetView = [popSelecetView new];
//        self.popselecetView = popselecetView;
//        [self.popselecetView windosViewshow];
        
        CGFloat tmp = 20;
        if (IPoneX) {
            tmp += 20;
        }
        UIView *targetView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH-44-20, tmp, 44, 44)];
        self.targetView = targetView;
        
        MOTPopConfig *config = [MOTPopConfig new];
        config.size = CGSizeMake(130, 128.4);
        config.targetView = self.targetView;
        config.isAuto = NO;
        config.tabColor = [UIColor whiteColor];
        config.isAuto = NO;
        config.vX = SCREENWIDTH-30;
        
        UIButton *Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 128.4*0.5)];
        [Btn1 setWithNormalColor:0x1E2E47 NormalAlpha:1 NormalTitle:NSLocalizedString(@"理财日历", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [config addView:Btn1];
        
        UIButton *Btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 128.4*0.5)];
        [Btn2 setWithNormalColor:0x1E2E47 NormalAlpha:1 NormalTitle:NSLocalizedString(@"理财账单", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [config addView:Btn2];
        
        kWeakSelf(self);
        [MOTMutablePopView popWithConfig:config  ClickIndexBlock:^(NSUInteger index) {
            NSLog(@"%s",__func__); //100
            if (index<100) {
                if ([[PortalHelper sharedInstance]get_userInfo]) {
//                    EachWkVc *vc = [EachWkVc new];
                    if (index == 0) {
                        [self openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].finCalendarUrl];
                    } else if (index == 1) {
                        [self openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].finBillUrl];
                    }
                } else {
                    [self openLoginView:nil];
                }
            }
        }];
    }
}



- (void)moreClick{
    
}
@end
