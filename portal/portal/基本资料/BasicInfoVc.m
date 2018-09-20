//
//  BasicInfoVc.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "BasicInfoVc.h"
#import "infoCell.h"
#import "editNikeNameVc.h"
#import "RealNameVc.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
@interface BasicInfoVc ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *Arry_data;
@end

@implementation BasicInfoVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"基本资料", @"");
    // Do any additional setup after loading the view.
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    self.view.backgroundColor = COLOUR_BACK_NORMAL;
    self.registerClasss = @[[infoCell class]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ADD_BANK_CARD_SUCCESSFunc:)
                                                 name:ADD_BANK_CARD_SUCCESS
                                               object:nil];
}
- (void)ADD_BANK_CARD_SUCCESSFunc:(NSNotification *)user{
    self.header.hidden = NO;
    [self.header beginRefreshing];
}
- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_tpurseusermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfoDeatil *tmp = [UserInfoDeatil mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance] set_userInfoDeatil:tmp];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        
    }];
}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *tmp = self.Arry_data[indexPath.section];
    setUpData *one = tmp[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"头像", @"")]) {
        [self OpenCameraAndAlbum];
    } else if ([one.title isEqualToString:NSLocalizedString(@"昵称", @"")]) {
        editNikeNameVc *vc= [editNikeNameVc new];
        [self OPenVc:vc]; 
    } else if ([one.title isEqualToString:NSLocalizedString(@"真实姓名", @"")]) {
        if (![[[PortalHelper sharedInstance] get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
            RealNameVc *vc= [RealNameVc new];
            [self OPenVc:vc]; 
        }
    } else if ([one.title isEqualToString:NSLocalizedString(@"绑定手机", @"")]) {

    }
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    infoCell *cell = [infoCell returnCellWith:tableView];
    [self configureinfoCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureinfoCell:(infoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *tmp = self.Arry_data[indexPath.section];
    setUpData *one = tmp[indexPath.row];
    cell.data = one;
    if ([one.title isEqualToString:NSLocalizedString(@"头像", @"")]) {
        cell.hidenIcon = NO;
    } else {
        cell.hidenIcon = YES;
    }
    if ([one.title isEqualToString:NSLocalizedString(@"绑定手机", @"")] || [one.title isEqualToString:NSLocalizedString(@"账户", @"")] || [one.title isEqualToString:NSLocalizedString(@"理财用户名", @"")] ) {
        cell.hidenMore = YES;
    }else if ([one.title isEqualToString:NSLocalizedString(@"真实姓名", @"")]) {
        if ([[[PortalHelper sharedInstance]get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
            cell.more.hidden = YES;
        } else {
            cell.more.hidden = NO;
        }
    } else {
        cell.hidenMore = NO;
    }
    
    if ([one.title isEqualToString:NSLocalizedString(@"头像", @"")]) {
        [cell.icon sd_setImageWithURL:[[PortalHelper sharedInstance]get_userInfoDeatil].headUrl placeholderImage:ImageNamed(SD_ALTERNATIVE_PICTURES)];
    } else if ([one.title isEqualToString:NSLocalizedString(@"昵称", @"")]) {
        cell.des.text = ([[PortalHelper sharedInstance]get_userInfoDeatil].nickname&&[[PortalHelper sharedInstance]get_userInfoDeatil].nickname.length)?[[PortalHelper sharedInstance]get_userInfoDeatil].nickname:[[PortalHelper sharedInstance]get_userInfoDeatil].mobile;
    } else if ([one.title isEqualToString:NSLocalizedString(@"真实姓名", @"")]) {
        if ([[[PortalHelper sharedInstance]get_userInfoDeatil].realFlag isEqualToString:STRING_1]) {
            cell.des.text = [[PortalHelper sharedInstance]get_userInfoDeatil].userName;
        } else {
            cell.des.text  =@"去实名";
        }
    } else if ([one.title isEqualToString:NSLocalizedString(@"绑定手机", @"")]) {
        cell.des.text = [[PortalHelper sharedInstance]get_userInfoDeatil].mobile;
    } else if ([one.title isEqualToString:NSLocalizedString(@"理财用户名", @"")]) {
        cell.des.text = [[PortalHelper sharedInstance]get_userInfoDeatil].finaUserName;
    } else if ([one.title isEqualToString:NSLocalizedString(@"账户", @"")]) {
        cell.des.text = [[PortalHelper sharedInstance]get_userInfoDeatil].userId;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != self.Arry_data.count-1) {
        return 10.0;
    }else{
        return 0.001;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *tmp = self.Arry_data[section];
    return tmp.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.empty_type == succes_empty_num) {
        return self.Arry_data.count;
    }else{
        return 0;
    }
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        
        
        NSMutableArray *one = [NSMutableArray array];
        setUpData *tmp11 = [setUpData new];
        tmp11.title = NSLocalizedString(@"头像", @"");
        [one addObject:tmp11];
        
        setUpData *tmp12 = [setUpData new];
        tmp12.title = NSLocalizedString(@"昵称", @"");
        [one addObject:tmp12];

        [_Arry_data addObject:one];
        
        
        NSMutableArray *two = [NSMutableArray array];
        setUpData *tmp21 = [setUpData new];
        tmp21.title = NSLocalizedString(@"真实姓名", @"");
        [two addObject:tmp21];
        
        setUpData *tmp221 = [setUpData new];
        tmp221.title = NSLocalizedString(@"账户", @"");
        [two addObject:tmp221];
        
        if ([[PortalHelper sharedInstance]get_userInfoDeatil].finaUserName && [[PortalHelper sharedInstance]get_userInfoDeatil].finaUserName.length) {
            setUpData *tmp222 = [setUpData new];
            tmp222.title = NSLocalizedString(@"理财用户名", @"");
            [two addObject:tmp222];
        }
        
        setUpData *tmp22 = [setUpData new];
        tmp22.title = NSLocalizedString(@"绑定手机", @"");
        [two addObject:tmp22];
        
        [_Arry_data addObject:two];
    }
    return _Arry_data;
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
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"上传中", @"") toView:self.view];
            kWeakSelf(self);
            [[ToolRequest sharedInstance]appuserupdateWithAvtor:image progress:^(NSProgress *uploadProgress) {
                
            } success:^(id dataDict, NSString *msg, NSInteger code) {
                UserInfo *tmp =[UserInfo mj_objectWithKeyValues:dataDict];
                
                UserInfoDeatil *data = [[PortalHelper sharedInstance]get_userInfoDeatil];
                data.headUrl = tmp.headUrl;
                [[PortalHelper sharedInstance]set_userInfoDeatil:data];

                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:NSLocalizedString(@"上传成功", @"") toView:weakself.view afterDelay:weakself.sesPro];
                [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
            }];
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
