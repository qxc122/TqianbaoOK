//
//  ScancodepaymentVc.m
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScancodepaymentVc.h"
#import <AVFoundation/AVFoundation.h>
#import "ScansuccessVc.h"
#import "NavigationBarDetais.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>



/**
 *  屏幕 高 宽 边界
 */
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
//#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP  IPoneX?(140+20):140
#define LEFT 38*PROPORTION_WIDTH
#define Width SCREENWIDTH-38*PROPORTION_WIDTH*2
#define kScanRect CGRectMake(LEFT, TOP, Width, Width)

@interface ScancodepaymentVc ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, weak) UILabel *des;

@property (nonatomic,weak) NavigationBarDetais *head;

@property (nonatomic,strong) QRcode *data;
@end

@implementation ScancodepaymentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [QRcode new];
    self.fd_prefersNavigationBarHidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
    [self setCropRect:kScanRect];
    
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];
    [self setHead];
}
- (void)setHead{
    CGFloat tmp = 64;
    if (IPoneX) {
        tmp += 20;
    }
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
    head.HeadBack.backgroundColor = ColorWithHex(0x000000,0.55);
    [head.returnBtn setWithNormalColor:0xE3BF7C NormalAlpha:1 NormalTitle:NSLocalizedString(@" 首页", @"") NormalImage:PIC_CUSTOM_NAVIGATION_BACK_KING NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    [head.RightBtn setWithNormalColor:0xE3BF7C NormalAlpha:1 NormalTitle:NSLocalizedString(@"相册", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
    
    head.titleNa.text = NSLocalizedString(@"向个人转帐", @"");
    [self.view addSubview:head];
    kWeakSelf(self);
    head.ClickreturnBtn = ^{
        [weakself popSelf];
        NSLog(@"%s",__func__);
    };
    head.ClickRightBtn = ^{
        [weakself OpenCameraAndAlbumAuthor];
        NSLog(@"%s",__func__);
    };
}
-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, Width, 50)];
    _line.image = [UIImage imageNamed:PIC_SCAN_CODE_MOVING_COLOR_BLOCK];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    UIImageView *desBack = [[UIImageView alloc]init];
//    desBack.backgroundColor = ColorWithHex(0x0, 1.0);
    [self.view addSubview:desBack];

    
    
    UILabel * des = [[UILabel alloc]init];
    [self.view addSubview:des];

    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@14);
        make.top.equalTo(imageView.mas_bottom).offset(41*PROPORTION_HEIGHT);
    }];
    [desBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.des);
        make.top.equalTo(imageView.mas_bottom).offset(30*PROPORTION_HEIGHT);
        make.width.equalTo(@232);
        make.height.equalTo(@35);
    }];
    des.numberOfLines = 0;
    des.textAlignment = NSTextAlignmentCenter;
    des.text = @"请对准二维码／条码，耐心等待";
    [des setWithColor:0xFFFFFF Alpha:1.0 Font:14 ROrM:@"r"];
    
    desBack.image = [UIImage imageNamed:@"文字背景层"];
    [desBack SetContentModeScaleAspectFill];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_session startRunning];
    [timer setFireDate:[NSDate date]];
    
#if TARGET_IPHONE_SIMULATOR
    self.data.codeId = @"2017102409580800000118";
    ScansuccessVc *vc = [ScansuccessVc new];
    vc.CTrollersToR = @[[self class]];
    vc.data = self.data;
    [self OPenVc:vc];

#endif
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_session stopRunning];
    [timer setFireDate:[NSDate distantFuture]];
}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, Width, 50);
        if ((TOP+10+2*num) >= (TOP + Width-10-50)) {
            _line.image = [UIImage imageNamed:PIC_SCAN_CODE_MOVING_COLOR_BLOCK_TOTOP];
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, Width, 50);
        if ((TOP+10+2*num) <= (TOP + 10)) {
            _line.image = [UIImage imageNamed:PIC_SCAN_CODE_MOVING_COLOR_BLOCK];
            upOrdown = NO;
        }
    }
    
}


- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SCREENHEIGHT;
    CGFloat left = LEFT/SCREENWIDTH;
    CGFloat width = Width/SCREENWIDTH;
    CGFloat height = Width/SCREENHEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"扫描结果：%@",stringValue);
        [self Twodimensionalcodeprocessing:stringValue];
//        NSArray *arry = metadataObject.corners;
//        for (id temp in arry) {
//            NSLog(@"%@",temp);
//        }

    } else {
        NSLog(@"无扫描信息");
        return;
    }
}


- (void)Twodimensionalcodeprocessing:(NSString *)code{
    if (code.length == 22) {
        self.data.codeId = code;
        ScansuccessVc *vc = [ScansuccessVc new];
        vc.data = self.data;
        [self OPenVc:vc];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"二维码有误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (_session != nil && timer != nil) {
                [_session startRunning];
                [timer setFireDate:[NSDate date]];
            }
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
}

#pragma mark 从摄像头获取图片或视频
- (void)OpenCameraAndAlbumAuthor{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Photos"]];
    
    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
    if (authoriation == PHAuthorizationStatusNotDetermined) {
        kWeakSelf(self);
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //这里非主线程，选择完成后会出发相册变化代理方法
            if (status == PHAuthorizationStatusAuthorized) {
                //OK
                [weakself selectImageFromAlbum];
            } else {
                [MBProgressHUD showPrompt:@"您没有设置权限" toView:weakself.view afterDelay:self.sesPro];
            }
        }];
    }else if (authoriation == PHAuthorizationStatusAuthorized) {
        //OK
        [self selectImageFromAlbum];
    }else {
        [MBProgressHUD showPrompt:@"您没有设置权限" toView:self.view afterDelay:self.sesPro];
    }
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum{
    [_session stopRunning];
    [timer setFireDate:[NSDate distantFuture]];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO; //可编辑
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    picker.navigationBar.tintColor = ColorWithHex(0xE3BF7C, 1.0);
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera || picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum)
    {
        [self Recognitionoftwodimensionalcode:image];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)Recognitionoftwodimensionalcode:(UIImage *)newImage{
     CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSData*imageData =UIImagePNGRepresentation(newImage);
    CIImage*ciImage = [CIImage imageWithData:imageData];
    NSArray*features = [detector featuresInImage:ciImage];
    if (features.count) {
        CIQRCodeFeature*feature = [features objectAtIndex:0];
        NSString*scannedResult = feature.messageString;
        [self Twodimensionalcodeprocessing:scannedResult];
    }else{
        [_session startRunning];
        [timer setFireDate:[NSDate date]];
        [MBProgressHUD showPrompt:@"无效二维码" toView:self.view];
    }
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [_session startRunning];
    [timer setFireDate:[NSDate date]];
}
@end
