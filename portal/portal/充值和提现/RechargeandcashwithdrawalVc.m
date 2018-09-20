//
//  RechargeandcashwithdrawalVc.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RechargeandcashwithdrawalVc.h"
#import "RechargeVc.h"

#import "NavigationBarDetais.h"



@interface RechargeandcashwithdrawalVc ()<UIScrollViewDelegate>
@property (nonatomic,weak) NavigationBarDetais *head;
@property (nonatomic,weak) UIScrollView *scroview;
@property (nonatomic,weak) UIButton *LeftBtn;
@property (nonatomic,weak) UIButton *RightBtn;
@property (nonatomic,assign)SeleVC Selestate; //选中的是 余额 还是充值 余额
@property (nonatomic,strong)UIViewController *Rechargevc;
@property (nonatomic,strong)UIViewController *WithdrawCashvc;
@end

@implementation RechargeandcashwithdrawalVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stateMoney = RechargeandcashwithdrawalVcState_Recharge;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor =ColorWithHex(0x1E2E47 , 1.0);
    [self SetUI];
    self.Selestate = SeleVC_Recharge;
}

- (void)SetUI{
    CGFloat tmp = 64;
    if (IPoneX) {
        tmp += 20;
    }
    NavigationBarDetais *head = [[NavigationBarDetais alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, tmp)];
    self.head = head;
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        head.titleNa.text = NSLocalizedString(@"充值", @"");
    } else {
        head.titleNa.text = NSLocalizedString(@"提现", @"");
    }
    [head.returnBtn setImage:[UIImage imageNamed:PIC_CUSTOM_NAVIGATION_BACK_KING] forState:UIControlStateNormal];
    [self.view addSubview:head];
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    
    
    UIScrollView *scroview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, tmp+50, SCREENWIDTH, SCREENHEIGHT-tmp-50)];
    scroview.delegate = self;
    self.scroview = scroview;
    scroview.bounces = NO;
    scroview.showsHorizontalScrollIndicator = NO;
    scroview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroview];
    scroview.backgroundColor = [UIColor whiteColor];
    scroview.contentSize = CGSizeMake(SCREENWIDTH*2.0, CGRectGetHeight(scroview.frame));
    scroview.pagingEnabled = YES;
    
    if (self.stateMoney == RechargeandcashwithdrawalVcState_Recharge) {
        RechargeVc *tmpOne = [[RechargeVc alloc]init];
        tmpOne.stateMoney = self.stateMoney;
        self.Rechargevc = tmpOne;
        [self addChildViewController:self.Rechargevc];
        self.Rechargevc.view.frame = CGRectMake(0, 0, CGRectGetWidth(scroview.frame), CGRectGetHeight(scroview.frame));
        [scroview addSubview:self.Rechargevc.view];
        
        RechargeVc *tmpTwo = [[RechargeVc alloc]init];
        tmpTwo.stateMoney = self.stateMoney;
        self.WithdrawCashvc = tmpTwo;
        [self addChildViewController:self.WithdrawCashvc];
        self.WithdrawCashvc.view.frame = CGRectMake(SCREENWIDTH, 0, CGRectGetWidth(scroview.frame), CGRectGetHeight(scroview.frame));
        [scroview addSubview:self.WithdrawCashvc.view];
    } else {
        WithdrawCashVc *tmpOne = [[WithdrawCashVc alloc]init];
        tmpOne.stateMoney = self.stateMoney;
        self.Rechargevc = tmpOne;
        [self addChildViewController:self.Rechargevc];
        self.Rechargevc.view.frame = CGRectMake(0, 0, CGRectGetWidth(scroview.frame), CGRectGetHeight(scroview.frame));
        [scroview addSubview:self.Rechargevc.view];
        
        WithdrawCashVc *tmpTwo = [[WithdrawCashVc alloc]init];
        tmpTwo.stateMoney = self.stateMoney;
        self.WithdrawCashvc = tmpTwo;
        [self addChildViewController:self.WithdrawCashvc];
        self.WithdrawCashvc.view.frame = CGRectMake(SCREENWIDTH, 0, CGRectGetWidth(scroview.frame), CGRectGetHeight(scroview.frame));
        [scroview addSubview:self.WithdrawCashvc.view];
    }
    
    UIButton *LeftBtn = [UIButton new];
    self.LeftBtn  =LeftBtn;
    [self.view addSubview:LeftBtn];
    

    UIButton *RightBtn = [UIButton new];
    self.RightBtn  =RightBtn;
    [self.view addSubview:RightBtn];

    [LeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(scroview.mas_top);
        make.width.equalTo(RightBtn);
        make.height.equalTo(@51);
    }];
    
    [RightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(LeftBtn.mas_right);
        make.right.equalTo(self.view);
        make.top.equalTo(LeftBtn);
        make.bottom.equalTo(LeftBtn);
    }];
    
    [LeftBtn setWithNormalColor:0xD5B478 NormalAlpha:0.6 NormalTitle:NSLocalizedString(@"余额", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0xE3BF7C  SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:0 NormalROrM:nil backColor:0x0 backAlpha:0];
    [LeftBtn addTarget:self action:@selector(SelestateClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [RightBtn setWithNormalColor:0xD5B478 NormalAlpha:0.6 NormalTitle:NSLocalizedString(@"理财余额", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0xE3BF7C  SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:0 NormalROrM:nil backColor:0x0 backAlpha:0];
    [RightBtn addTarget:self action:@selector(SelestateClick:) forControlEvents:UIControlEventTouchUpInside];
    LeftBtn.tag = SeleVC_Recharge;
    RightBtn.tag = SeleVC_WithdrawCash;
}
- (void)SelestateClick:(UIButton *)btn{
    if (btn.tag != self.Selestate) {
        self.Selestate = btn.tag;
    }
}
- (void)setSelestate:(SeleVC)Selestate{
    _Selestate = Selestate;
    if (Selestate == SeleVC_Recharge) {
        [self.scroview setContentOffset:CGPointMake(0, 0) animated:YES];
        self.LeftBtn.selected = YES;
        self.RightBtn.selected = NO;
        self.LeftBtn.titleLabel.font = PingFangSC_Medium(16);
        self.RightBtn.titleLabel.font = PingFangSC_Regular(16);
    } else {
        [self.scroview setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:YES];
        self.LeftBtn.selected = NO;
        self.RightBtn.selected = YES;
        self.LeftBtn.titleLabel.font = PingFangSC_Regular(16);
        self.RightBtn.titleLabel.font = PingFangSC_Medium(16);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    if (offset < SCREENWIDTH) {
        self.Selestate = SeleVC_Recharge;
    } else {
        self.Selestate = SeleVC_WithdrawCash;
    }
}
@end
