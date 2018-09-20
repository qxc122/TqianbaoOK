//
//  FindPassWordVc.m
//  portal
//
//  Created by Store on 2018/3/13.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "FindPassWordVc.h"
#import "baseFillCell.h"
#import "FindPassWordFoot.h"
#import "FindPassWordHEad.h"
@interface FindPassWordVc ()
@property (nonatomic,strong) NSString *passWordOne;
@property (nonatomic,strong) NSString *passWordTwo;
@property (nonatomic,strong) NSMutableArray *Arry_data;
@property (nonatomic,weak) FindPassWordFoot *foot;
@end

@implementation FindPassWordVc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"重置支付密码", @"");
    self.registerClasss = @[[baseFillCell class]];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    
    FindPassWordHEad *head = [[FindPassWordHEad alloc] init];
    head.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
    self.tableView.tableHeaderView = head;
    
    kWeakSelf(self);
    FindPassWordFoot *foot = [[FindPassWordFoot alloc]initWithFrame:CGRectMake(0, 0, 0, 50+159)];
    foot.btn.enabled = NO;
    self.foot = foot;
    foot.doneBtn = ^{
        [weakself changePassWord];
        NSLog(@"%s",__func__);
    };
    self.tableView.tableFooterView = foot;
}

- (void)changePassWord{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"更改中...", @"") toView:self.view];
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_userresetPayPasswordWithpayPassword:self.passWordOne Bankssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showSuccess:@"更改成功"];
        [weakself popSelf];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    baseFillCell *cell = [baseFillCell returnCellWith:tableView];
    [self configurebaseFillCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置baseFillCell 的数据>
- (void)configurebaseFillCell:(baseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.Arry_data[indexPath.row];
    cell.inputInfo = one;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText,UITextField *intput) {
        if ([identifer isEqualToString:NSLocalizedString(@"请设置6位数支付密码", @"")]) {
            weakself.passWordOne = inText;
        }else if ([identifer isEqualToString:NSLocalizedString(@"请再次输入", @"")]) {
            if (inText.length == 6) {
                if ([inText isEqualToString:weakself.passWordOne]) {
                    weakself.passWordTwo = inText;
                    weakself.foot.btn.enabled = YES;
                } else {
                    weakself.foot.btn.enabled = NO;
                    [MBProgressHUD showError:@"两次输入的密码不一致！" toView:weakself.view];
                }
            }
        }
    };
    if ([one.describe isEqualToString:NSLocalizedString(@"请设置6位数支付密码", @"")]) {
        cell.input.text = self.passWordOne;
    }else if ([one.describe isEqualToString:NSLocalizedString(@"请再次输入", @"")]) {
        cell.input.text = self.passWordTwo;
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        {
            setUpData *tmp3 = [setUpData new];
            tmp3.title = NSLocalizedString(@"新密码", @"");
            tmp3.describe = NSLocalizedString(@"请设置6位数支付密码", @"");
            tmp3.clearButtonMode = UITextFieldViewModeWhileEditing;
            tmp3.keyboardType = UIKeyboardTypeNumberPad;
            tmp3.contentType = UIKeyboardTypeNumberPad;
            tmp3.existedLength = 6;
            [_Arry_data addObject:tmp3];
        }
        {
            setUpData *tmp3 = [setUpData new];
            tmp3.title = NSLocalizedString(@"再次输入", @"");
            tmp3.describe = NSLocalizedString(@"请再次输入", @"");
            tmp3.clearButtonMode = UITextFieldViewModeWhileEditing;
            tmp3.keyboardType = UIKeyboardTypeNumberPad;
            tmp3.contentType = UIKeyboardTypeNumberPad;
            tmp3.existedLength = 6;
            [_Arry_data addObject:tmp3];
        }
    }
    return _Arry_data;
}
@end
