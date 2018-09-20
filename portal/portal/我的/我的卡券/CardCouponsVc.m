//
//  CardCouponsVc.m
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "CardCouponsVc.h"
#import "AirListVc.h"
#import "CouponsVc.h"

@interface CardCouponsVc ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIButton *btn1;
@property (nonatomic,weak) UIButton *btn2;
@property (nonatomic,weak) UIView *view1;
@property (nonatomic,weak) UIView *view2;
@property (nonatomic,weak) UIScrollView *content;

@property (nonatomic,strong) AirListVc *airListVc;
@property (nonatomic,strong) CouponsVc *couponsVc;
@end

@implementation CardCouponsVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"我的票券";
    UIButton *btn1 = [UIButton new];
    btn1.backgroundColor = [UIColor whiteColor];
    self.btn1 = btn1;
    [self.view addSubview:btn1];
    [btn1 setWithNormalColor:0x9DA4AE NormalAlpha:1.0 NormalTitle:@"票" NormalImage:nil NormalBackImage:nil SelectedColor:0x1E2E47 SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    
    UIButton *btn2 = [UIButton new];
    btn2.backgroundColor = [UIColor whiteColor];
    self.btn2 = btn2;
    [self.view addSubview:btn2];
    [btn2 setWithNormalColor:0x9DA4AE NormalAlpha:1.0 NormalTitle:@"券" NormalImage:nil NormalBackImage:nil SelectedColor:0x1E2E47 SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:227/255.0 green:191/255.0 blue:124/255.0 alpha:1/1.0];
        self.view1 = view;
        [self.view addSubview:view];
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:227/255.0 green:191/255.0 blue:124/255.0 alpha:1/1.0];
        self.view2 = view;
        [self.view addSubview:view];
    }
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(@59);
        make.width.equalTo(@[self.btn2]);
    }];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.btn1.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(@59);
    }];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btn1);
        make.centerX.equalTo(self.btn1);
        make.height.equalTo(@2);
        make.width.equalTo(@60);
    }];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btn2);
        make.centerX.equalTo(self.btn2);
        make.height.equalTo(@2);
        make.width.equalTo(@60);
    }];
    
    UIScrollView *content = [UIScrollView new];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:245/255.0 alpha:1/1.0];
    [self.view addSubview:content];
    self.content = content;
    content.delegate = self;
//    CGFloat hei = SCREENHEIGHT-59-64;

    CGFloat hei = SCREENHEIGHT-59;
    if (IPoneX) {
        hei -= 66;
    }else{
        hei -= 88;
    }
    self.content.frame = CGRectMake(0, 59, SCREENWIDTH, hei);

//    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view2.mas_bottom);
//        make.bottom.equalTo(self.view);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//    }];
    self.airListVc = [AirListVc new];
    self.couponsVc = [CouponsVc new];
    [self addChildViewController:self.airListVc];
    [self addChildViewController:self.couponsVc];
    self.airListVc.view.frame = CGRectMake(0, 0, SCREENWIDTH, hei);
    self.couponsVc.view.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, hei);
    [self.content addSubview:self.airListVc.view];
    [self.content addSubview:self.couponsVc.view];
    content.contentSize = CGSizeMake(SCREENWIDTH*2.0, 0);
    content.pagingEnabled = YES;
    content.showsHorizontalScrollIndicator = NO;
    content.bounces = NO;

    
    
//    self.airListVc.view.backgroundColor = [UIColor redColor];
//    self.couponsVc.view.backgroundColor = [UIColor greenColor];
    
    self.view2.hidden = YES;
    self.btn1.selected  =YES;
    [self.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    if (@available(iOS 11.0, *)) {
//        self.content.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    self.content.backgroundColor = [UIColor redColor];
    self.couponsVc.view.backgroundColor = [UIColor yellowColor];
    self.airListVc.view.backgroundColor = [UIColor blueColor];
}
- (void)btnClick:(UIButton *)btn{
    if (!btn.selected) {
        self.btn1.selected =  !self.btn1.selected;
        self.btn2.selected =  !self.btn2.selected;
        if (self.btn1.selected) {
            self.view1.hidden = NO;
        } else {
            self.view1.hidden = YES;
        }
        if (self.btn2.selected) {
            self.view2.hidden = NO;
        } else {
            self.view2.hidden = YES;
        }
        
        if (self.btn2.selected) {
            [self.content setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:YES];
        } else {
            [self.content setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        [self btnClick:self.btn1];
    } else if (scrollView.contentOffset.x == SCREENWIDTH){
        [self btnClick:self.btn2];
    }
}
@end
