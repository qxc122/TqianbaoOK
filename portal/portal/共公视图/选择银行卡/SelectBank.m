//
//  SelectBank.m
//  TourismT
//
//  Created by Store on 2017/4/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SelectBank.h"
#import "PortalHelper.h"

typedef NS_ENUM(NSInteger, SelectBank_btnTag)
{
    cancel_SelectBank_btnTag,//取消
    ok_SelectBank_btnTag,//确定
};


@interface SelectBank ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,weak) UIPickerView *pickerView;
@property (nonatomic,strong) bankList *datea;
@end

@implementation SelectBank

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.datea = [[PortalHelper sharedInstance]get_bankListdata];
        UIView *blcak = [[UIView alloc]init];
        blcak.backgroundColor = ColorWithHex(0x000000, 0.5);
        [self addSubview:blcak];
        
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        self.pickerView = pickerView;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:pickerView];
        
        UIButton *close = [UIButton new];
        [self addSubview:close];
        
        UIButton *ok = [UIButton new];
        [self addSubview:ok];
        
        [blcak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@300);
            make.bottom.equalTo(self);
        }];
        
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(pickerView);
            make.height.equalTo(@44);
            make.width.equalTo(@44);
        }];
        [ok mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(pickerView);
            make.height.equalTo(@44);
            make.width.equalTo(@44);
        }];
        [ok setTitle:@"确定" forState:UIControlStateNormal];
        [close setTitle:@"取消" forState:UIControlStateNormal];
        [ok setTitleColor:ColorWithHex(0x000000, 0.54) forState:UIControlStateNormal];
        [close setTitleColor:ColorWithHex(0x000000, 0.54) forState:UIControlStateNormal];
        ok.titleLabel.font = PingFangSC_Regular(12);
        close.titleLabel.font = PingFangSC_Regular(12);
        [ok addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [close addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        close.tag = cancel_SelectBank_btnTag;
        ok.tag = ok_SelectBank_btnTag;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeClisck)];
        [blcak addGestureRecognizer:tap];
    }
    return self;
}
- (void)btnClick:(UIButton *)sender{
    if (sender.tag == ok_SelectBank_btnTag) {
        NSInteger row=[self.pickerView selectedRowInComponent:0];
        //然后是获取这个行中的值，就是数组中的值 //TODO
        if (self.SelectBank) {
            self.SelectBank(self.datea.Arry_list[row]);
        }
    }
    [self closeClisck];
}
- (void)closeClisck{
    [self removeFromSuperview];
}
- (void)windosViewshow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window);
        make.right.equalTo(window);
        make.top.equalTo(window);
        make.bottom.equalTo(window);
    }];
}


#pragma -mark<UITableViewDataSource 返回列数>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
#pragma -mark<UITableViewDataSource 返回每一列中的行数>
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.datea.Arry_list.count;
}
#pragma -mark<UITableViewDataSource 返回每个item中的title>
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    bankCard *tmp = self.datea.Arry_list[row];
    return tmp.bankName;
}
#pragma -mark<UITableViewDataSource 返回每个item的高>
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35.f;
}

@end
