//
//  GesturecipherVc.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "GesturecipherVc.h"

#import "NavigationBarDetais.h"
#import "GesturecipherCoCell.h"
#import "AuthenticationVc.h"
#import "SignInVc.h"
#import "payTwoVc.h"
#import "SignInVc.h"
#import "RealNameVc.h"
@interface GesturecipherVc ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *Arry;
@property (nonatomic,weak) UILabel *desLable;
@property (nonatomic,weak) UIButton *reset;

@property (nonatomic,weak) NavigationBarDetais *head;
@property (nonatomic,weak) YHGesturePasswordView *viedfw;

@property (nonatomic,weak) UIImageView *headIcon;
@property (nonatomic,weak) UILabel *errorLable;
@property (nonatomic,weak) UIView *suLine;
@property (nonatomic,weak) UIButton *LLabel;
@property (nonatomic,weak) UIButton *RLabel;

@property (nonatomic,assign) NSInteger errorNum;
@end

@implementation GesturecipherVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusBarStyle = UIStatusBarStyleDefault;
        self.state = GestureResultPassword;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Arry = [NSMutableArray array];
    self.fd_interactivePopDisabled = YES;
    self.fd_prefersNavigationBarHidden = YES;
    [self setGesturePasswordView];
    [self addHead];
    [self SetUI];
}
- (void)SetUI{
    UILabel *errorLable = [[UILabel alloc]init];
    self.errorLable = errorLable;
    [self.view addSubview:errorLable];
    [errorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.viedfw.mas_top).offset(-50*PROPORTION_HEIGHT);
    }];
    [errorLable setWithColor:0xF4333C  Alpha:1.0 Font:14 ROrM:@"r"];
    if (self.state == GestureSetPassword) {
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
        self.collectionView = collectionView;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.userInteractionEnabled = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[GesturecipherCoCell class] forCellWithReuseIdentifier:NSStringFromClass([GesturecipherCoCell class])];

        [self.view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.head.mas_bottom).offset(66*PROPORTION_HEIGHT);
            make.width.equalTo(@(46*PROPORTION_WIDTH));
            make.height.equalTo(collectionView.mas_width);
        }];
        
        UILabel *desLable = [[UILabel alloc]init];
        self.desLable = desLable;
        [self.view addSubview:desLable];
        [desLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.viedfw.mas_top).offset(-50*PROPORTION_HEIGHT);
        }];

        
        UIButton *reset = [[UIButton alloc]init];
        self.reset = reset;
        self.reset.hidden = YES;
        [self.view addSubview:reset];
        [reset mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.height.equalTo(@44);
            make.bottom.equalTo(self.view.mas_bottom).offset(-55*PROPORTION_HEIGHT+15);
        }];
        [reset setWithNormalColor:0x9DA4AE NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"重新绘制", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [reset addTarget:self action:@selector(resetClickTwoALL) forControlEvents:UIControlEventTouchUpInside];

        [self setdesLable:0];
    }else{
        UIImageView *headIcon = [[UIImageView alloc]init];
        self.headIcon = headIcon;
        [self.view addSubview:headIcon];
        [headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.head.mas_bottom).offset(56*PROPORTION_HEIGHT);
            make.width.equalTo(@(70*PROPORTION_WIDTH));
            make.height.equalTo(headIcon.mas_width);
        }];

        UIImageView *suLine = [[UIImageView alloc]init];
        self.suLine = suLine;
        [self.view addSubview:suLine];
        [suLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-36*PROPORTION_HEIGHT);
            make.width.equalTo(@(0.5));
            make.height.equalTo(@20);
        }];
        
        UIButton *LLabel = [[UIButton alloc]init];
        self.LLabel = LLabel;
        [self.view addSubview:LLabel];
        [LLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.suLine);
            make.right.equalTo(self.suLine.mas_left).offset(-15);
        }];
        
        UIButton *RLabel = [[UIButton alloc]init];
        self.RLabel = RLabel;
        [self.view addSubview:RLabel];
        [RLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.suLine);
            make.left.equalTo(self.suLine.mas_left).offset(15);
        }];

        [headIcon SetFilletWith:70*PROPORTION_WIDTH];
        [headIcon SetContentModeScaleAspectFill];
        [LLabel setWithNormalColor:0x9DA4AE NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"忘记手势密码", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [RLabel setWithNormalColor:0x9DA4AE NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"验证码登录", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
//        [headIcon zy_cornerRadiusRoundingRect];
        suLine.backgroundColor =ColorWithHex(0x979EAA, 1.0);
        [LLabel addTarget:self action:@selector(LLabelClick) forControlEvents:UIControlEventTouchUpInside];
        [RLabel addTarget:self action:@selector(RLabelClick) forControlEvents:UIControlEventTouchUpInside];
        [headIcon sd_setImageWithURL:[[PortalHelper sharedInstance]get_userInfoDeatil].headUrl placeholderImage:ImageNamed(SD_HEAD_ALTERNATIVE_PICTURES)];
//        headIcon.image = [UIImage imageNamed:@"背景"];
    }
    //tess
//    errorLable.text  =NSLocalizedString(@"验证码登asdf录", @"");
}
- (void)resetClickTwoALL{
    self.viedfw.times = 0;
    [self.Arry removeAllObjects];
    [self.collectionView reloadData];

    self.viedfw.pwdValue = nil;
    [self.viedfw reset];
    [self setdesLable:0];
    self.reset.hidden = YES;
}
- (void)setdesLable:(NSInteger)index{
    if (index == 0) {
        [self.desLable setWithColor:0x4F8CEB  Alpha:1.0 Font:14 ROrM:@"r"];
        self.desLable.text  =@"为了您的账户安全，请设置手势密码";
    } else if (index == 1) {
        [self.desLable setWithColor:0x858E9B  Alpha:1.0 Font:14 ROrM:@"r"];
        self.desLable.text  =@"绘制手势密码";
    } else if (index == 2) {
        [self.desLable setWithColor:0x858E9B  Alpha:1.0 Font:14 ROrM:@"r"];
        self.desLable.text  =@"再次绘制手势密码";
    } else if (index == 3) {
        [self.desLable setWithColor:0xF4333C  Alpha:1.0 Font:14 ROrM:@"r"];
        self.desLable.text  =@"与首次绘制不一样，请重新绘制";
        self.reset.hidden = NO;
    }
}
- (void)LLabelClick{
    NSLog(@"%s",__func__);
    AuthenticationVc *vc = [AuthenticationVc new];
    [self OPenVc:vc];
}
- (void)RLabelClick{
    NSLog(@"%s",__func__);
    SignInVc *vc = [SignInVc new];
    vc.isUnlock = YES;
    [self OPenVc:vc];
}
- (void)WrongLengthdon{
    [self resetClick];
    [self setdesLable:0];
}
- (void)resetClick{
    NSLog(@"%s",__func__);
    [self resetClickTwo];
    self.viedfw.times = 0;
    [self.Arry removeAllObjects];
    [self.collectionView reloadData];
}
- (void)resetClickTwo{
    NSLog(@"%s",__func__);
    self.viedfw.times = 1;
    [self.viedfw reset];
    [self setdesLable:2];
    self.reset.hidden = YES;
}

- (void)addHead{
    CGFloat tmp = 64;
    if (IPoneX) {
        tmp += 20;
    }
    NavigationBarDetais *head = [[NavigationBarDetais alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, tmp)];
    self.head = head;
    if (self.state == GestureResultPassword) {
        [self.head.returnBtn setImage:ImageNamed(@"关闭") forState:UIControlStateNormal];;
    }
    [self.view addSubview:head];
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        if (self.state == GestureResultPassword) {
            [self setLoginOut];
        }else if (self.state == GestureSetPassword){
            [weakself popSelf];
        }
        NSLog(@"%s",__func__);
    };
    if (self.state == GestureSetPassword) {
        [head.RightBtn setTitle:@"跳过" forState:UIControlStateNormal];
        head.ClickRightBtn = ^{
            [weakself popSelf];
            NSLog(@"%s",__func__);
        };
    }else{
        head.RightBtn.hidden = YES;
    }
}

- (void)aureset{
    [self.viedfw reset];
}

-(void)setGesturePasswordView{
    YHGesturePasswordView *view = [[YHGesturePasswordView alloc]initWithFrame:CGRectMake(66*PROPORTION_WIDTH, SCREENHEIGHT-(SCREENWIDTH - 2*66*PROPORTION_WIDTH)-147*PROPORTION_HEIGHT,SCREENWIDTH - 2*66*PROPORTION_WIDTH,SCREENWIDTH - 2*66*PROPORTION_WIDTH) WithNormalImg:[[UIImage imageNamed:@"手势普通"] thumbnailsize:CGSizeMake(20*PROPORTION_WIDTH, 20*PROPORTION_WIDTH)] WithSelectedImg:[[UIImage imageNamed:@"手势高亮"] thumbnailsize:CGSizeMake(60*PROPORTION_WIDTH, 60*PROPORTION_WIDTH)] WithState:self.state];
    self.viedfw = view;
    view.btnSelectImageError = [[UIImage imageNamed:@"手势错误"] thumbnailsize:CGSizeMake(60*PROPORTION_WIDTH, 60*PROPORTION_WIDTH)];

    view.lineColor = ColorWithHex(0x1E2E47, 1.0);
    view.lineColorError = ColorWithHex(0xF4333C, 1.0);
    [self.view addSubview:view];
    
    kWeakSelf(self);
    view.sendReaultData = ^BOOL(NSString *str) {
        if ([[[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile].GestureCipherStr isEqualToString:str]) {
            [weakself popSelf];
            return YES;
        }else{
            weakself.errorNum ++;
            if (weakself.errorNum >= 5) {
                [MBProgressHUD showPrompt:@"手势密码错误多次,请用验证码登录" toView:self.view afterDelay:2.0f];
                [weakself performSelector:@selector(RLabelClick) withObject:nil afterDelay:2.0f];
            } else {
                [MBProgressHUD showPrompt:[NSString stringWithFormat:@"手势密码错误,您还有%ld次机会",5-weakself.errorNum] toView:self.view afterDelay:2.0f];
                [weakself performSelector:@selector(aureset) withObject:nil afterDelay:2.0f];
            }
            return NO;
        }
    };
    if (self.state == GestureSetPassword) {
        kWeakSelf(self);
        view.sendReaultDataWhenMoved = ^(NSMutableArray *Arry) {
            [weakself.Arry addObjectsFromArray:Arry];
            [weakself.collectionView reloadData];
            if (Arry.count) {
                [weakself setdesLable:1];
            }
        };
        view.setPwdBlock =  ^(SetPwdState pwdState,NSString *result){
            //可以做加密处理
            NSLog(@"str is value%d",pwdState);
            switch (pwdState) {
                case FristPwd:
                {
                    //第一次设置密码
                    NSLog(@"第一次设置密码");
                    [weakself setdesLable:2];
                }
                    break;
                case PwdNoValue:
                {
                    //二次设置不一致
                    [weakself setdesLable:3];
                    NSLog(@"二次设置不一致");
                    // 清空
                    
                }
                    break;
                case SetPwdSuccess:
                {
                    //设置成功
                    NSLog(@"设置成功");
                    
                    setUp *tmp = [[PortalHelper sharedInstance]get_setUpWith:[[PortalHelper sharedInstance]get_userInfo].fullMobile];
                    tmp.phone = [[PortalHelper sharedInstance]get_userInfo].fullMobile;
                    tmp.GestureCipherStr = result;
                    [[PortalHelper sharedInstance]set_setUp:tmp];
                    
                    if (weakself.threePay && ![[[PortalHelper sharedInstance]get_userInfo].realFlag isEqualToString:STRING_1]){
                        [MBProgressHUD showPrompt:@"设置成功,请先实名认证"];
                        RealNameVc *vcc = [RealNameVc new];
                        vcc.CTrollersToR = @[[weakself class]];
                        [weakself OPenVc:vcc];
                    }else{
                        [MBProgressHUD showPrompt:@"设置成功" toView:weakself.view afterDelay:2.0f];
                        [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:2.0];
                    }
                }
                    break;
                case WrongLength:
                {
                    
                    [MBProgressHUD showPrompt:@"至少划过4个点" toView:weakself.view afterDelay:2.0f];
                    [weakself performSelector:@selector(WrongLengthdon) withObject:nil afterDelay:2.0];
                    NSLog(@"长度错误");
                    
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
}

- (void)popSelf{
    if (self.isUnlock || self.Resetafterverification) {
        NSArray *tmpArry = self.navigationController.viewControllers;
        BOOL ishavePaymentcodevc = NO;
        for (UIViewController *vc in tmpArry) {
            if ([vc isKindOfClass:[payTwoVc class]] || [vc isKindOfClass:[SignInVc class]] ) {
                ishavePaymentcodevc = YES;
                break;
            }
        }
        if (ishavePaymentcodevc) {
            [super popSelf];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } else {
        [super popSelf];
    }
}

#pragma mark----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GesturecipherCoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GesturecipherCoCell class]) forIndexPath:indexPath];
    cell.Icon.highlighted = NO;
    for (NSNumber *num in self.Arry) {
        if ([num integerValue] == indexPath.row) {
            cell.Icon.highlighted = YES;
        }
    }
    return cell;
}
#pragma mark----UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(6*PROPORTION_WIDTH,6*PROPORTION_WIDTH);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return (46*PROPORTION_WIDTH - 6*PROPORTION_WIDTH*3)*0.5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (46*PROPORTION_WIDTH - 6*PROPORTION_WIDTH*3)*0.5;
}
@end
