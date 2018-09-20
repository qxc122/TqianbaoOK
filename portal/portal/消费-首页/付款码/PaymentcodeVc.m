//
//  PaymentcodeVc.m
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "PaymentcodeVc.h"
#import "payTypeSele.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface PaymentcodeVc ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,weak) UIImageView *back;
@property (nonatomic,weak) UIImageView *backTop;

@property (nonatomic,weak) UIImageView *titleIcon;
@property (nonatomic,weak) UILabel *titlee;

@property (nonatomic,weak) UILabel *QRcodeTitle;
@property (nonatomic,weak) UIImageView *QRcode;
@property (nonatomic,weak) UIButton *save;

@property (nonatomic,weak) UIImageView *backBottom;
@property (nonatomic,weak) UIImageView *backBottomLine;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UIImageView *nameHead;
@property (nonatomic,weak) UILabel *staue;

@property (nonatomic,weak) UIButton *Btnlist;

@property (nonatomic,strong) QRcode *data;

@end


@implementation PaymentcodeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithHex(0x1E2E47, 1.0);
    self.title = @"收钱";
    
    UIImageView *back = [UIImageView new];
    self.back = back;
    [self.view addSubview:back];
    UIImageView *backTop = [UIImageView new];
    self.backTop = backTop;
    [self.view addSubview:backTop];
    
    UIImageView *titleIcon = [UIImageView new];
    self.titleIcon = titleIcon;
    [self.view addSubview:titleIcon];
    
    UILabel *titlee = [UILabel new];
    self.titlee = titlee;
    [self.view addSubview:titlee];

    UILabel *QRcodeTitle = [UILabel new];
    self.QRcodeTitle = QRcodeTitle;
    [self.view addSubview:QRcodeTitle];
    
    
    UIImageView *QRcode = [UIImageView new];
    self.QRcode = QRcode;
    [self.view addSubview:QRcode];
    UIButton *save = [UIButton new];
    self.save = save;
    [self.view addSubview:save];
    
    
    UIImageView *backBottom = [UIImageView new];
    self.backBottom = backBottom;
    [self.back addSubview:backBottom];
    
    UIImageView *backBottomLine = [UIImageView new];
    self.backBottomLine = backBottomLine;
    [self.backBottom addSubview:backBottomLine];

    UIImageView *nameHead = [UIImageView new];
    self.nameHead = nameHead;
    [self.backBottom addSubview:nameHead];
    UILabel *name = [UILabel new];
    self.name = name;
    [self.backBottom addSubview:name];
    UILabel *staue = [UILabel new];
    self.staue = staue;
    [self.backBottom addSubview:staue];

    UIButton *Btnlist = [UIButton new];
    self.Btnlist = Btnlist;
    [self.view addSubview:Btnlist];
    
    CGFloat tmp = 41;
    if (IPoneX) {
        tmp += 20;
    }
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(tmp);
        make.height.equalTo(back.mas_width).multipliedBy(400/335.0);
    }];
    [backTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back);
        make.right.equalTo(self.back);
        make.top.equalTo(self.back);
        make.height.equalTo(@50);
    }];
    [titlee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleIcon.mas_right).offset(10);
        make.centerY.equalTo(self.backTop);
    }];
    [titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(15);
        make.centerY.equalTo(self.backTop);
        make.height.equalTo(@15);
        make.width.equalTo(@11);
    }];
    [QRcodeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.back);
        make.top.equalTo(self.backTop.mas_bottom).offset(45*PROPORTION_HEIGHT);
    }];
    
    [QRcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.back);
        make.top.equalTo(self.QRcodeTitle.mas_bottom).offset(15);
        make.left.equalTo(self.back).offset(88*PROPORTION_WIDTH);
        make.right.equalTo(self.back).offset(-88*PROPORTION_WIDTH);
        make.height.equalTo(QRcode.mas_width);
    }];
    
    [save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.back);
        make.top.equalTo(self.QRcode.mas_bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@44);
    }];
    [backBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back);
        make.right.equalTo(self.back);
        make.bottom.equalTo(self.back);
        make.height.equalTo(@70);
    }];
    [backBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back);
        make.right.equalTo(self.back);
        make.top.equalTo(self.backBottom);
        make.height.equalTo(@0.5);
    }];
    [nameHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBottom);
        make.left.equalTo(self.backBottom).offset(20);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBottom);
        make.left.equalTo(self.nameHead.mas_right).offset(10);
    }];
    [staue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBottom);
        make.right.equalTo(self.back.mas_right).offset(-20);
    }];
    
    [Btnlist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-15);
        make.width.equalTo(@80);
        make.height.equalTo(@44);
    }];
    
    [back SetContentModeScaleAspectFill];
    [backBottom SetContentModeScaleAspectFill];

    [QRcode SetContentModeScaleAspectFill];
    [nameHead SetContentModeScaleAspectFill];
    [nameHead SetFilletWith:35.0f];
    

    [save setWithNormalColor:0x5F7FFC NormalAlpha:1.0 NormalTitle:@"保存图片" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [Btnlist setWithNormalColor:0xE4E4E4 NormalAlpha:0.36 NormalTitle:@"收付款记录" NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0x0 backAlpha:0];
//    [moreBtn setImage:[[UIImage imageNamed:@"背景"] thumbnailsize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    back.backgroundColor =ColorWithHex(0xFFFFFF, 1.0);
    backBottomLine.backgroundColor =ColorWithHex(0xD8D8D8, 0.3);
    backTop.backgroundColor =ColorWithHex(0xD8D8D8, 0.3);
    [backTop zy_cornerRadiusAdvance:PICTURE_FILLET_SIZE rectCornerType:UIRectCornerTopLeft|UIRectCornerTopRight];
    
    [titlee setWithColor:0x1E2E46 Alpha:0.8 Font:14 ROrM:@"r"];
    [QRcodeTitle setWithColor:0x1E2E46 Alpha:1.0 Font:15 ROrM:@"m"];
    [name setWithColor:0x3A4554 Alpha:1.0 Font:14 ROrM:@"m"];
    [staue setWithColor:0x3A4554 Alpha:0.5 Font:14 ROrM:@"r"];
    titlee.text = @"个人收钱";
    QRcodeTitle.text = @"T钱包扫一扫，向我付钱";
    
    [back SetFilletWith:PICTURE_FILLET_SIZE*2];
    self.backBottom.hidden = YES;
    
//    [stripeCodeBtn addTarget:self action:@selector(stripeCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//
    [save addTarget:self action:@selector(OpenAlbumAuthor) forControlEvents:UIControlEventTouchUpInside];
    [Btnlist addTarget:self action:@selector(BtnlistBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    titleIcon.image = [UIImage imageNamed:PIC_PERSONAL_MONEY_ICON];
    
    self.save.hidden = YES;
//    QRcode.image = [UIImage imageNamed:@"背景图"];
//    nameHead.image = [UIImage imageNamed:@"背景图"];
    [self loadURLBASIC_qrCodegenerateQRCodesuccess];
}

//- (void)saveBtnClick{
//    if (self.data) {
//        [self loadImageFinished:self.QRcode.image];
//    } else {
//        [self loadURLBASIC_qrCodegenerateQRCodesuccess];
//    }
//    NSLog(@"%s",__FUNCTION__);
//}

- (void)loadImageFinished:(UIImage *)image
{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"保存中...", @"") toView:self.view];
    kWeakSelf(self);
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@ %@", success, error,[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            if (error) {
                [MBProgressHUD showPrompt:NSLocalizedString(@"保存失败", @"") toView:weakself.view afterDelay:weakself.sesPro];
            } else {
                [MBProgressHUD showPrompt:NSLocalizedString(@"保存成功", @"") toView:weakself.view afterDelay:weakself.sesPro];
            }
        });
    }];
}


- (void)BtnlistBtnClick{
    [self openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].myReceivableUrl];
    NSLog(@"%s",__FUNCTION__);
}

//- (void)stripeCodeBtnClick{
//    NSLog(@"%s",__FUNCTION__);
//}
//- (void)moreBtnClick{
//    NSLog(@"%s",__FUNCTION__);
//    payTypeSele *view = [payTypeSele new];
//    [view windosViewshow];
//}
- (void)customBackButton
{
    UIImage* image = [[UIImage imageNamed:PIC_CUSTOM_NAVIGATION_BACK_KING] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *btn = [UIButton new];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:@" 首页" forState:UIControlStateNormal];
    btn.titleLabel.font = PingFangSC_Medium(14);
    [btn setTitleColor:ColorWithHex(0xEEC783, 1.0) forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}

- (void)loadURLBASIC_qrCodegenerateQRCodesuccess{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"收款码获取中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_qrCodegenerateQRCodeWithdevicesToken:[[PortalHelper sharedInstance]get_deviceToken].deviceToken success:^(id dataDict, NSString *msg, NSInteger code) {
        QRcode *data = [QRcode mj_objectWithKeyValues:dataDict];
        weakself.data = data;
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
//        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:NSLocalizedString(@"收款码获取失败,请重试", @"") toView:weakself.view afterDelay:weakself.sesPro];
        weakself.data = nil;
    }];
}

- (void)setData:(QRcode *)data{
    _data = data;
    self.save.hidden = NO;
    if (data) {
        [self.save setTitle:@"保存图片" forState:UIControlStateNormal];
        [self.QRcode sd_setImageWithURL:data.codeUrl];
//        [self.QRcode sd_setImageWithURL:data.codeUrl placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
    } else {
        [self.save setTitle:@"请重新获取收款码" forState:UIControlStateNormal];
        self.QRcode.image = nil;
    }
    [self setNameAndHeadIcon];
}
- (void)setNameAndHeadIcon{
    if ([self.noticationdata.codeId isEqualToString:self.data.codeId]) {
        self.backBottom.hidden = NO;
        [self.nameHead sd_setImageWithURL:self.noticationdata.content placeholderImage:ImageNamed(SD_HEAD_ALTERNATIVE_PICTURES)];
        self.name.text = self.noticationdata.nickname;
        if ([self.noticationdata.status isEqualToString:@"1"]) {
            self.staue.text = @"支付中...";
        } else if ([self.noticationdata.status isEqualToString:@"2"]) {
            self.staue.text = [NSString stringWithFormat:@"%@元",self.noticationdata.money];
        } else if ([self.noticationdata.status isEqualToString:@"3"]) {
            self.staue.text = @"支付失败";
        }
    }
}
- (void)setNoticationdata:(noticationData *)noticationdata{
    _noticationdata = noticationdata;
    [self setNameAndHeadIcon];
}
#pragma mark 从摄像头获取图片或视频
- (void)OpenAlbumAuthor{
    if (self.data) {
        PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
        if (authoriation == PHAuthorizationStatusNotDetermined) {
            kWeakSelf(self);
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //这里非主线程，选择完成后会出发相册变化代理方法
                if (status == PHAuthorizationStatusAuthorized) {
                    //OK
                    [weakself loadImageFinished:self.QRcode.image];
                } else {
                    [MBProgressHUD showPrompt:@"您没有设置权限" toView:weakself.view afterDelay:self.sesPro];
                }
            }];
        }else if (authoriation == PHAuthorizationStatusAuthorized) {
            //OK
            [self loadImageFinished:self.QRcode.image];
        }else {
            [MBProgressHUD showPrompt:@"您没有设置权限" toView:self.view afterDelay:self.sesPro];
        }
    } else {
        [self loadURLBASIC_qrCodegenerateQRCodesuccess];
    }
}




#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera || picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum)
    {
        if(image){
 
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
