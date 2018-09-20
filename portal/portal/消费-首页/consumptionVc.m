//
//  consumptionVc.m
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "consumptionVc.h"
#import "NavigationBarDetais.h"
#import "PaymentcodeVc.h"
#import "ScancodepaymentVc.h"
@interface consumptionVc ()
@property (nonatomic,weak) NavigationBarDetais *head;
@property (nonatomic,weak) UIButton *Scancodepayment;
@property (nonatomic,weak) UIButton *Paymentcode;
@property (nonatomic,assign)consumptionVcState stateTwo;

@property (nonatomic,strong)PaymentcodeVc *paymentcodeVc;
@property (nonatomic,strong)ScancodepaymentVc *scancodepaymentVc;
@end

@implementation consumptionVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self VCTwo];
    [self SetUI];
    [self setStateVc];
    [self setanmoid:NO];
}

- (void)SetUI{
    CGFloat tmp = 64;
    if (IPoneX) {
        tmp += 20;
    }
    UIButton *Scancodepayment = [UIButton new];
    self.Scancodepayment = Scancodepayment;
    [self.view addSubview:Scancodepayment];
    
    UIButton *Paymentcode = [UIButton new];
    self.Paymentcode = Paymentcode;
    [self.view addSubview:Paymentcode];
    
    CGFloat width = 54*PROPORTION_WIDTH;
    CGFloat height = width + 13 + 12;
    [Paymentcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(-48*PROPORTION_WIDTH);
        make.bottom.equalTo(self.view).offset(-37*PROPORTION_WIDTH);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    [Scancodepayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(48*PROPORTION_WIDTH);
        make.bottom.equalTo(self.Paymentcode);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    NSString *PaymentcodeSTR = NSLocalizedString(@"付款码", @"");
    [Paymentcode setWithNormalColor:0xFFFFFF  NormalAlpha:1.0 NormalTitle:PaymentcodeSTR NormalImage:nil NormalBackImage:nil SelectedColor:0xE3BF7C SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [Paymentcode setImage:[[UIImage imageNamed:@"微信好友"] thumbnailsize:CGSizeMake(width, width)] forState:UIControlStateNormal];
    Paymentcode.imageEdgeInsets = UIEdgeInsetsMake(- (height - width), -0, 0.0, 0.0);
    Paymentcode.titleEdgeInsets = UIEdgeInsetsMake(0, - width, -(height-12), 0);
    
    NSString *ScancodepaymentSTR = NSLocalizedString(@"扫码付", @"");
    [Scancodepayment setWithNormalColor:0xFFFFFF  NormalAlpha:1.0 NormalTitle:ScancodepaymentSTR NormalImage:nil NormalBackImage:nil SelectedColor:0xE3BF7C SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:12 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [Scancodepayment setImage:[[UIImage imageNamed:@"微信好友"] thumbnailsize:CGSizeMake(width, width)] forState:UIControlStateNormal];
    Scancodepayment.imageEdgeInsets = UIEdgeInsetsMake(- (height - width), -0, 0.0, 0.0);
    Scancodepayment.titleEdgeInsets = UIEdgeInsetsMake(0, - width, -(height-12), 0);
    
    [Paymentcode addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [Scancodepayment addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    Paymentcode.tag = consumptionVcState_Paymentcode;
    Scancodepayment.tag = consumptionVcState_Scancodepayment;
    
    NavigationBarDetais *head = [[NavigationBarDetais alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, tmp)];
    self.head = head;
    [head.returnBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head).offset(5);
        if (IPoneX) {
            make.top.equalTo(head).offset(22+20);
        }else{
            make.top.equalTo(head).offset(22);
        }
        make.width.equalTo(@(44+34));
        make.height.equalTo(@44);
    }];
    
    [head.returnBtn setWithNormalColor:0xE3BF7C NormalAlpha:1 NormalTitle:NSLocalizedString(@"首页", @"") NormalImage:@"编辑" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [head.RightBtn setWithNormalColor:0xE3BF7C NormalAlpha:1 NormalTitle:NSLocalizedString(@"相册", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    
    head.titleNa.text = NSLocalizedString(@"向个人转帐", @"");
    [self.view addSubview:head];
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    head.ClickRightBtn = ^{
        NSLog(@"%s",__func__);
    };
}
- (void)VCTwo{
    self.paymentcodeVc = [[PaymentcodeVc alloc]init];
    [self addChildViewController:self.paymentcodeVc];
    self.paymentcodeVc.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:self.paymentcodeVc.view];
    
    self.scancodepaymentVc = [[ScancodepaymentVc alloc]init];
    [self addChildViewController:self.scancodepaymentVc];
    self.scancodepaymentVc.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:self.scancodepaymentVc.view];
}
- (void)clickBtn:(UIButton *)btn{
    if (btn.tag != self.state) {
        self.state = btn.tag;
    }
}

- (void)setState:(consumptionVcState)state{
    _state = state;
    [self setStateVc];
    [self setanmoid:YES];
}
- (void)setanmoid:(BOOL)anmoid{
    UIViewAnimationOptions transitionDirection;
    UIView *fromView;
    UIView *toView;
    if (self.state == consumptionVcState_Scancodepayment) {
        fromView = self.paymentcodeVc.view;
        toView = self.scancodepaymentVc.view;
        transitionDirection = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        fromView = self.scancodepaymentVc.view;
        toView = self.paymentcodeVc.view;
        transitionDirection = UIViewAnimationOptionTransitionFlipFromRight;
    }
    kWeakSelf(self);
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:anmoid?0.5:0
                       options:transitionDirection
                    completion:^(BOOL finished) {
                        [weakself.view sendSubviewToBack:fromView];
                        [weakself.view sendSubviewToBack:toView];
                    }];
}
- (void)setStateVc{
    if (self.state == consumptionVcState_Scancodepayment) {
        self.Scancodepayment.selected = YES;
        self.Paymentcode.selected = NO;
    } else if (self.state == consumptionVcState_Paymentcode) {
        self.Scancodepayment.selected = NO;
        self.Paymentcode.selected = YES;
    }
}
@end
