//
//  HelpandfeedbackVc.m
//  portal
//
//  Created by Store on 2017/10/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "HelpandfeedbackVc.h"
#import "SZTextView.h"
#import "UITextFieldAdd.h"
#import "HelpandfeedbackCoCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface HelpandfeedbackVc()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,weak) UIView *backTop;
@property (nonatomic,weak) UILabel *titleTop;

@property (nonatomic,weak) UIView *backBottom;
@property (nonatomic,weak) UILabel *titleBottom;


@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) SZTextView *input;
@property (nonatomic,weak) UILabel *num;
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,assign) CGFloat heightPre;


@property (nonatomic,weak) UIBarButtonItem* rightBarutton;

@property (nonatomic,weak) UIView *phoneInback;
@property (nonatomic,weak) UITextFieldAdd *phoneIn;

@property (nonatomic,strong) NSMutableArray *ImgArry;
@end
#define minHeight  50.f

@implementation HelpandfeedbackVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightPre = minHeight;
    self.ImgArry = [NSMutableArray array];
    self.view.backgroundColor = ColorWithHex(0xF0F1F5, 1.0);
    self.title = NSLocalizedString(@"帮助与反馈", @"");
    UIBarButtonItem* rightBarutton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"确定", @"") style:UIBarButtonItemStylePlain target:self action:@selector(saveFUNc)];
    self.rightBarutton = rightBarutton;
    rightBarutton.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightBarutton;
    [self setRightBtn];
    [self SetUI];
}

- (void)SetUI{
    UIView *backAll = [UIView new];
    [self.view addSubview:backAll];
    [backAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIView *backTop = [UIView new];
    self.backTop = backTop;
    [self.view addSubview:backTop];
    
    UILabel *titleTop = [UILabel new];
    self.titleTop = titleTop;
    [self.view addSubview:titleTop];
    
    
    UIView *back = [UIView new];
    self.back = back;
    [self.view addSubview:back];
    
    SZTextView *input = [SZTextView new];
    [self.view addSubview:input];
    input.backgroundColor = [UIColor whiteColor];
    self.input = input;
    input.delegate = self;
    input.placeholder = NSLocalizedString(@"请详细描述您的问题或建议，我们将及时跟进解决(建议添加相关问题截图）", @"");
    
    UILabel *num = [UILabel new];
    self.num = num;
    [self.view addSubview:num];
    
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[HelpandfeedbackCoCell class] forCellWithReuseIdentifier:NSStringFromClass([HelpandfeedbackCoCell class])];
    [self.view addSubview:collectionView];
    
    
    UIView *backBottom = [UIView new];
    self.backBottom = backBottom;
    [self.view addSubview:backBottom];
    
    UILabel *titleBottom = [UILabel new];
    self.titleBottom = titleBottom;
    [self.view addSubview:titleBottom];
    
    UIView *phoneInback = [UIView new];
    self.phoneInback = phoneInback;
    [self.view addSubview:phoneInback];
    
    UITextFieldAdd *phoneIn = [UITextFieldAdd new];
    self.phoneIn = phoneIn;
    self.phoneIn.delegate = self;
    [self.view addSubview:phoneIn];
    
    [backTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [titleTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backTop).offset(20);
        make.right.equalTo(self.backTop).offset(-20);;
        make.top.equalTo(self.backTop).offset(13);;
        make.bottom.equalTo(self.backTop).offset(-13);;
    }];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.backTop.mas_bottom);
    }];

    [input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(20);
        make.right.equalTo(self.back).offset(-20);
        make.top.equalTo(self.back).offset(15);
        make.height.equalTo(@(self.heightPre));
    }];
    
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.back).offset(-20);
        make.top.equalTo(self.input.mas_bottom).offset(12);
    }];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(20);
        make.right.equalTo(self.back).offset(-20);
        make.top.equalTo(self.num.mas_bottom).offset(12);
        make.bottom.equalTo(self.back).offset(-15);
        make.height.equalTo(@(((SCREENWIDTH-40)-20*PROPORTION_WIDTH*4)/5.0));
    }];

    [backBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.back.mas_bottom);
    }];
    [titleBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBottom).offset(20);
        make.right.equalTo(self.backBottom).offset(-20);
        make.top.equalTo(self.backBottom).offset(13);;
        make.bottom.equalTo(self.backBottom).offset(-13);
    }];
    
    [phoneInback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.backBottom.mas_bottom);
        make.height.equalTo(@60);
    }];
    [phoneIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneInback).offset(20);
        make.right.equalTo(self.phoneInback).offset(-20);
        make.top.equalTo(self.phoneInback);
        make.bottom.equalTo(self.phoneInback);
    }];
    //set
    [num setWithColor:0xCBCED3 Alpha:1.0 Font:11 ROrM:@"r"];
    [titleTop setWithColor:0x9DA4AE Alpha:1.0 Font:12 ROrM:@"r"];
    [titleBottom setWithColor:0x9DA4AE Alpha:1.0 Font:12 ROrM:@"r"];
    titleTop.text = @"您的问题或建议（必填）";
    titleBottom.text = @"手机号／邮箱(选填，方便我们联系您)";
    back.backgroundColor = [UIColor whiteColor];
    phoneInback.backgroundColor = [UIColor whiteColor];
    
    [phoneIn setWithColor:NORMOL_BLACK Alpha:1.0 Font:15 ROrM:@"r"];
    [phoneIn setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
    phoneIn.placeholder  =@"请输入相关信息";
    
    titleTop.numberOfLines = 0;
    titleBottom.numberOfLines = 0;
    
    input.bounces = NO;
    input.showsHorizontalScrollIndicator = NO;
    input.showsVerticalScrollIndicator = NO;
    input.font = PingFangSC_Regular(14);
    input.textColor = ColorWithHex(0x1E2E47, 1.0);  //CBCED3

    self.num.text = @"0 / 300";
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
        [MBProgressHUD showPrompt:NSLocalizedString(@"No more than 300 words", @"No more than 300 words")];
    }
    if (textView.text.length) {
        self.rightBarutton.enabled = YES;
    } else {
        self.rightBarutton.enabled = NO;
    }
    self.num.text = [NSString stringWithFormat:@"%lu / 300",(unsigned long)textView.text.length];
    CGFloat height = [textView.text HeightWithFont:PingFangSC_Regular(14) withMaxWidth:SCREENWIDTH-40];
    if (height > self.heightPre) {
        self.heightPre +=30;
    }else if (height < minHeight){
        self.heightPre = minHeight;
    }else if (height + 30 < self.heightPre){
        self.heightPre -=30;
        if (self.heightPre < minHeight) {
            self.heightPre = minHeight;
        }
    }
    
    [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(20);
        make.right.equalTo(self.back).offset(-20);
        make.top.equalTo(self.back).offset(15);
        make.height.equalTo(@(self.heightPre));
    }];
}
- (void)saveFUNc{
    if (self.input.text && self.input.text.length) {
        if ((!self.phoneIn.text || !self.phoneIn.text.length || ([self.phoneIn.text IsTelNumber] || [self.phoneIn.text isValidateEmail]))) {
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"提交中", @"") toView:self.view];
            kWeakSelf(self);
            [[ToolRequest sharedInstance]appuserupdateWithImages:self.ImgArry content:self.input.text contactMethod:self.phoneIn.text progress:^(NSProgress *uploadProgress) {
                
            } success:^(id dataDict, NSString *msg, NSInteger code) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:NSLocalizedString(@"提交成功", @"") toView:weakself.view afterDelay:weakself.sesPro];
                [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:weakself.sesPro];
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
            }];
        }else{
             [MBProgressHUD showPrompt:@"请输入正确的联系方式" toView:self.view afterDelay:self.sesPro];
        }
    } else {
        [MBProgressHUD showPrompt:@"请输入问题描叙和建议" toView:self.view afterDelay:self.sesPro];
    }
}
#pragma mark--<点击了cell>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ImgArry.count<5 && (0 == self.ImgArry.count || indexPath.row == self.ImgArry.count)) {
        [self OpenCameraAndAlbum];
    }
}

#pragma mark----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (0 == self.ImgArry.count) {
        return 1;
    } else if (5 == self.ImgArry.count) {
        return self.ImgArry.count;
    } else {
        return self.ImgArry.count+1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HelpandfeedbackCoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HelpandfeedbackCoCell class]) forIndexPath:indexPath];
    if (0 == self.ImgArry.count || (self.ImgArry.count < 5 && self.ImgArry.count > 0 && self.ImgArry.count == indexPath.row)) {
        cell.imge.image = ImageNamed(PIC_ADD_PHOTOS);
    } else  {
        cell.imge.image = self.ImgArry[indexPath.row];
    }
    return cell;
}
#pragma mark----UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(((SCREENWIDTH-40)-20*PROPORTION_WIDTH*4)/5.0,((SCREENWIDTH-40)-20*PROPORTION_WIDTH*4)/5.0);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0*PROPORTION_WIDTH;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0*PROPORTION_WIDTH;
}



- (void)OpenCameraAndAlbum{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself OpenCameraAndAlbumAuthor:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself OpenCameraAndAlbumAuthor:UIImagePickerControllerSourceTypeCamera];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 从摄像头获取图片或视频
- (void)OpenCameraAndAlbumAuthor:(UIImagePickerControllerSourceType)MediaType{
    if (MediaType == UIImagePickerControllerSourceTypeCamera) { //相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            switch (status) {
                case AVAuthorizationStatusNotDetermined:{
                    // 许可对话没有出现，发起授权许可
                    kWeakSelf(self);
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                        
                        if (granted) {
                            //第一次用户接受
                            [weakself selectImageFromCamera];
                        }else{
                            [MBProgressHUD showPrompt:@"您没有设置权限" toView:weakself.view afterDelay:self.sesPro];
                            //用户拒绝
                        }
                    }];
                    break;
                }
                case AVAuthorizationStatusAuthorized:{
                    // 已经开启授权，可继续
                    [self selectImageFromCamera];
                    break;
                }
                case AVAuthorizationStatusDenied:
                    [MBProgressHUD showPrompt:@"您没有设置权限" toView:self.view afterDelay:self.sesPro];
                case AVAuthorizationStatusRestricted:
                    [MBProgressHUD showPrompt:@"您没有设置权限" toView:self.view afterDelay:self.sesPro];
                    // 用户明确地拒绝授权，或者相机设备无法访问
                    break;
                default:
                    [MBProgressHUD showPrompt:@"相机设备无法访问" toView:self.view afterDelay:self.sesPro];
                    break;
            }
        }
        else
        {
            [MBProgressHUD showPrompt:@"相机设备无法访问" toView:self.view afterDelay:self.sesPro];
        }
    } else {
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
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
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
        if(image){
            [self.ImgArry addObject:image];
            [self.collectionView reloadData];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""] || [string isEqualToString:@"@"] || [string isEqualToString:@"."]) {
        return YES;
    }else {
        BOOL tmp = NO;
        BOOL tmpOne = NO;;
        BOOL tmpTwo = NO;
        BOOL tmpThree = NO;
        NSCharacterSet*cs1 = [NSCharacterSet lowercaseLetterCharacterSet];
        NSString*filtered1 = [[string componentsSeparatedByCharactersInSet:cs1] componentsJoinedByString:@""];
        tmpOne =  ![string isEqualToString:filtered1];
        
        NSCharacterSet*cs2 = [NSCharacterSet uppercaseLetterCharacterSet];
        NSString*filtered2 = [[string componentsSeparatedByCharactersInSet:cs2] componentsJoinedByString:@""];
        tmpTwo =  ![string isEqualToString:filtered2];
        
        
        NSCharacterSet*cs3 = [NSCharacterSet decimalDigitCharacterSet];
        NSString*filtered3 = [[string componentsSeparatedByCharactersInSet:cs3] componentsJoinedByString:@""];
        tmpThree =  ![string isEqualToString:filtered3];
        
        tmp = tmpOne||tmpTwo||tmpThree;
        return tmp;
    }
}
@end
