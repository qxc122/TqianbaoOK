//
//  editNikeNameVc.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "editNikeNameVc.h"
#import "UITextFieldAdd.h"

@interface editNikeNameVc ()<UITextFieldDelegate>
@property (nonatomic,weak) UITextFieldAdd *nameIn;
@end

@implementation editNikeNameVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"修改昵称", @"");
    self.view.backgroundColor = COLOUR_BACK_NORMAL;
    [self setUIeditNikeNameVc];
    
    UIBarButtonItem* rightBarutton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", @"") style:UIBarButtonItemStylePlain target:self action:@selector(saveFUNc)];
    self.navigationItem.rightBarButtonItem = rightBarutton;
    [self setRightBtn];
}
- (void)saveFUNc{
    if (self.nameIn.text && self.nameIn.text.length) {
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"设置中", @"") toView:self.view];
            kWeakSelf(self);
            [[ToolRequest sharedInstance]URLBASIC_tpurseusermodifyNicknameWithnickname:self.nameIn.text sssuccess:^(id dataDict, NSString *msg, NSInteger code) {
                UserInfoDeatil *data = [[PortalHelper sharedInstance]get_userInfoDeatil];
                data.nickname = weakself.nameIn.text;

                [[PortalHelper sharedInstance]set_userInfoDeatil:data];
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:NSLocalizedString(@"设置成功", @"") toView:weakself.view afterDelay:2.0f];
                [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:2.0f];
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                [MBProgressHUD showPrompt:msg toView:weakself.view afterDelay:weakself.sesPro];
            }];
    }else{
       [MBProgressHUD showPrompt:NSLocalizedString(@"请先输入昵称", @"") toView:self.view afterDelay:self.sesPro];
    }
}
- (void)setUIeditNikeNameVc{
    UILabel *des = [UILabel new];
    [self.view addSubview:des];
    
    UIView *back = [UIView new];
    [self.view addSubview:back];
    
    UILabel *desnikeName = [UILabel new];
    [self.view addSubview:desnikeName];
    
    UITextFieldAdd *nameIn = [UITextFieldAdd new];
    self.nameIn = nameIn;
    [self.view addSubview:nameIn];
    
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(15);
    }];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(des.mas_bottom).offset(13);
        make.height.equalTo(@77);
    }];
    [desnikeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(des);
        make.right.equalTo(des);
        make.top.equalTo(back).offset(15);
    }];
    [nameIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(des);
        make.right.equalTo(des);
        make.top.equalTo(desnikeName.mas_bottom);
        make.bottom.equalTo(back).offset(-5);
    }];
    back.backgroundColor = [UIColor whiteColor];
    self.nameIn.delegate = self;
    nameIn.clearButtonMode = UITextFieldViewModeWhileEditing;
    des.numberOfLines = 0;
    [des setWithColor:NORMOL_GRAY Alpha:1.0 Font:12 ROrM:@"r"];
    [desnikeName setWithColor:NORMOL_GRAY Alpha:1.0 Font:12 ROrM:@"r"];
    [nameIn setWithColor:NORMOL_BLACK Alpha:1.0 Font:16 ROrM:@"r"];
    [nameIn setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
    nameIn.placeholder = NSLocalizedString(@"请输入昵称", @"");
    
    des.text =NSLocalizedString(@"设置后，其他人将看到你的昵称", @"");
    desnikeName.text =NSLocalizedString(@"昵称", @"");
    
    if ([self.nameIn canBecomeFirstResponder]) {
        [self.nameIn becomeFirstResponder];
    }
    nameIn.text = ([[PortalHelper sharedInstance]get_userInfoDeatil].nickname&&[[PortalHelper sharedInstance]get_userInfoDeatil].nickname.length)?[[PortalHelper sharedInstance]get_userInfoDeatil].nickname:[[PortalHelper sharedInstance]get_userInfoDeatil].mobile;
}

@end
