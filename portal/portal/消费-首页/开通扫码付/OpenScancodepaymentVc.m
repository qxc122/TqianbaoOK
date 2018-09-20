//
//  OpenScancodepaymentVc.m
//  portal
//
//  Created by Store on 2017/10/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "OpenScancodepaymentVc.h"
#import "NavigationBarDetais.h"
#import "YYText.h"

@interface OpenScancodepaymentVc ()
@property (nonatomic,weak) NavigationBarDetais *head;
@property (nonatomic,weak) UIImageView *QRimg;
@property (nonatomic,weak) UILabel *titlee;
@property (nonatomic,weak) UILabel *des;
@property (nonatomic,weak) UIButton *btn;
@property (nonatomic,weak) YYLabel *label;
@end

@implementation OpenScancodepaymentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self SetUI];
}
- (void)SetUI{
    CGFloat tmp = 64;
    if (IPoneX) {
        tmp += 20;
    }
    NavigationBarDetais *head = [[NavigationBarDetais alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, tmp)];
    self.head = head;
    [head.titleNa setWithColor:0x1E2E47 Alpha:1.0 Font:17 ROrM:@"r"];
    head.titleNa.text = NSLocalizedString(@"开通扫码付", @"");
    [self.view addSubview:head];
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    
    UIImageView * QRimg = [UIImageView new];
    self.QRimg  =QRimg;
    [self.view addSubview:QRimg];
    
    UILabel * titlee = [UILabel new];
    self.titlee  =titlee;
    [self.view addSubview:titlee];
    
    UILabel * des = [UILabel new];
    self.des  =des;
    [self.view addSubview:des];
    
    UIButton * btn = [UIButton new];
    self.btn  =btn;
    [self.view addSubview:btn];
    
    YYLabel * label = [YYLabel new];
    self.label  =label;
    [self.view addSubview:label];
    
    CGFloat tmpHeight = 130;
    if (IPoneX) {
        tmpHeight += 20;
    }
    [self.QRimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(62*PROPORTION_WIDTH);
        make.right.equalTo(self.view).offset(-62*PROPORTION_WIDTH);
        make.top.equalTo(self.view).offset(tmpHeight*PROPORTION_HEIGHT);
        make.height.equalTo(self.QRimg.mas_width);
    }];
    [self.titlee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.QRimg.mas_bottom).offset(54*PROPORTION_HEIGHT);
    }];
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.titlee.mas_bottom).offset(14*PROPORTION_HEIGHT);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(98*PROPORTION_WIDTH);
        make.right.equalTo(self.view).offset(-98*PROPORTION_WIDTH);
        make.top.equalTo(self.titlee.mas_bottom).offset(45*PROPORTION_HEIGHT);
        make.height.equalTo(@50);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-20);
    }];

    [self.QRimg SetContentModeScaleAspectFill];
    [self.titlee setWithColor:0x1E2E47 Alpha:1.0 Font:21 ROrM:@"m"];
    [self.des setWithColor:0x9DA4AE Alpha:1.0 Font:14 ROrM:@"r"];
    [self.btn setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"开始扫描", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0x5D7EFC backAlpha:1.0];
    [self.btn SetFilletWith:50.0];
    self.titlee.text = @"线下商户扫码付";
    self.des.text = @"扫描商户收款码支付";
    self.titlee.textAlignment = NSTextAlignmentCenter;
    self.des.textAlignment = NSTextAlignmentCenter;
    self.QRimg.image = [UIImage imageNamed:@"背景"];
    


    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"点击“开始扫描”即代表您同意", @"")];
    one.yy_font = PingFangSC_Regular(12);
    one.yy_color = ColorWithHex(0x858E9B, 1.0);
    [text appendAttributedString:one];
    
    
    NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"《扫码支付用户协议》", @"")];
    two.yy_font = PingFangSC_Regular(12);
    two.yy_underlineStyle = NSUnderlineStyleSingle;
    [two yy_setTextHighlightRange:two.yy_rangeOfAll
                            color:ColorWithHex(0x858E9B, 1.0)
                  backgroundColor:[UIColor clearColor]
                        tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                            NSLog(@"%s",__func__);
                        }];
    [text appendAttributedString:two];
    
    
    self.label.attributedText = text;
    self.label.numberOfLines  = 0;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
}

@end
