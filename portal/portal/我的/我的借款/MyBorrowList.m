//
//  MyBorrowList.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "MyBorrowList.h"
#import "popSelecetView.h"
#import "MOTMutablePopView.h"
#import "WithdrawCashVc.h"
#import "RechargeVc.h"

@interface MyBorrowList ()
@property (weak, nonatomic) UIButton *LeftBtn;
@property (weak, nonatomic) UIButton *RightBtn;

@property (weak, nonatomic) UIView *targetView;
@property (weak, nonatomic) popSelecetView *popselecetView;
@end

@implementation MyBorrowList
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
        CGFloat tmp = 20;
        if (IPoneX) {
            tmp += 20;
        }
        UIView *targetView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH-44-20, tmp, 44, 44)];
        self.targetView = targetView;
        
        MOTPopConfig *config = [MOTPopConfig new];
        config.size = CGSizeMake(104, 40);
        config.targetView = self.targetView;
        config.isAuto = NO;
        config.tabColor = [UIColor whiteColor];
        config.isAuto = NO;
        config.vX = SCREENWIDTH-30;
        
        UIButton *Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 104, 40)];
        [Btn1 setWithNormalColor:0x1E2E47 NormalAlpha:1 NormalTitle:NSLocalizedString(@" 借还记录", @"") NormalImage:@"借还记录图标" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [config addView:Btn1];
        
        kWeakSelf(self);
        [MOTMutablePopView popWithConfig:config  ClickIndexBlock:^(NSUInteger index) {
            NSLog(@"%s",__func__); //100
            if (index<100) {
                [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].finBillUrl];
            }
        }];
    }
}


@end
