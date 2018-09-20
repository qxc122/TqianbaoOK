//
//  ScansuccessCell.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ScansuccessCell.h"


@interface ScansuccessCell ()<UITextFieldDelegate>
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *titlee;
@property (nonatomic, weak) UIImageView *des;
@property (nonatomic, weak) UILabel *name;

@property (nonatomic, weak) UILabel *moneyTitle;
@property (nonatomic, weak) UILabel *moneyLOgo;

@property (nonatomic, weak) UIView *line;
//@property (nonatomic, weak) UIButton *btn;
@end

@implementation ScansuccessCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ScansuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * icon = [[UIImageView alloc]init];
        self.icon = icon;
        [self.contentView addSubview:icon];
        
        UILabel * titlee = [[UILabel alloc]init];
        self.titlee = titlee;
        [self.contentView addSubview:titlee];
        
        UIImageView * des = [[UIImageView alloc]init];
        self.des = des;
        [self.contentView addSubview:des];
        
        UILabel * name = [[UILabel alloc]init];
        self.name = name;
        [self.contentView addSubview:name];
        
        UILabel * moneyTitle = [[UILabel alloc]init];
        self.moneyTitle = moneyTitle;
        [self.contentView addSubview:moneyTitle];
        
        UILabel * moneyLOgo = [[UILabel alloc]init];
        self.moneyLOgo = moneyLOgo;
        [self.contentView addSubview:moneyLOgo];
        
        UITextFieldAdd * moneyInput = [[UITextFieldAdd alloc]init];
        self.moneyInput = moneyInput;
        [self.contentView addSubview:moneyInput];
        
        UIView * line = [[UIView alloc]init];
        self.line = line;
        [self.contentView addSubview:line];

        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(25*PROPORTION_HEIGHT);
            make.height.equalTo(@(60*PROPORTION_WIDTH));
            make.width.equalTo(@(60*PROPORTION_WIDTH));
        }];
        
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.icon);
            make.height.equalTo(@18);
            make.width.equalTo(@52);
            make.top.equalTo(self.icon.mas_bottom).offset(15*PROPORTION_HEIGHT);
        }];
        
        [titlee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.des);
            make.right.equalTo(self.des.mas_left).offset(-5);
        }];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.des);
            make.left.equalTo(self.des.mas_right).offset(5);
        }];
        
        [moneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.right.equalTo(self.line);
            make.top.equalTo(self.des.mas_bottom).offset(56*PROPORTION_HEIGHT);
        }];
        [moneyLOgo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.width.equalTo(@(21));
            make.top.equalTo(self.moneyTitle.mas_bottom).offset(45*PROPORTION_HEIGHT);
        }];
        [moneyInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLOgo.mas_right).offset(25);
            make.right.equalTo(self.line);
            make.bottom.equalTo(self.moneyLOgo);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.moneyLOgo.mas_bottom).offset(15*PROPORTION_HEIGHT);
            make.bottom.equalTo(self.contentView).offset(-40*PROPORTION_HEIGHT);
            make.height.equalTo(@0.5);
        }];

        line.backgroundColor  =ColorWithHex(0xDADEE3, 1.0);
        [icon SetContentModeScaleAspectFill];
        [icon SetFilletWith:60*PROPORTION_WIDTH];
        [titlee setWithColor:0x3A4554 Alpha:1.0 Font:16 ROrM:@"m"];
        [moneyTitle setWithColor:0x3A4554 Alpha:1.0 Font:14 ROrM:@"r"];
        [moneyLOgo setWithColor:0x1E2E47 Alpha:1.0 Font:38 ROrM:@"r"];
        


        self.moneyInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.moneyInput.keyboardType = UIKeyboardTypeDecimalPad;
        self.moneyInput.delegate = self;
        [moneyInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [moneyInput setWithColor:0x1E2E47 Alpha:1.0 Font:38 ROrM:@"r"];
        [moneyInput setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        moneyInput.placeholder = @"请输入付款金额";
        moneyTitle.text = @"转账金额";
        titlee.text = @"转账给";
        moneyLOgo.text = @"¥";
        des.image = [UIImage imageNamed:@"个人用户"];
        [self setTextIN];
//        name.text = @"sdf";
//        icon.image = [UIImage imageNamed:@"背景图"];
    }
    return self;
}
- (void)setScanQRCodeOkdata:(scanQRCodeOk *)scanQRCodeOkdata{
    _scanQRCodeOkdata = scanQRCodeOkdata;
    self.name.text = scanQRCodeOkdata.payeeName;
    [self.icon sd_setImageWithURL:scanQRCodeOkdata.payeeLogo placeholderImage:ImageNamed(SD_HEAD_ALTERNATIVE_PICTURES)];
}
#pragma  -mark<输入框改变了>
-(void)textFieldDidChange :(UITextField *)textField{
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(textField.text);
    }
    [self setTextIN];
}

- (void)setTextIN{
    if (self.moneyInput.text.length) {
        [self.moneyInput setWithColor:0x1E2E46 Alpha:1.0 Font:38 ROrM:@"r"];
    }else{
        [self.moneyInput setWithColor:0x3A4554 Alpha:1.0 Font:16 ROrM:@"r"];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length >1 && [[textField.text substringFromIndex:textField.text.length-1] isEqualToString:@"."]) {
        textField.text = [textField.text substringToIndex:textField.text.length-1];
    }
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(textField.text);
    }
}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    BOOL tmp = NO;
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""]) {
        if ([textField.text isEqualToString:@"0."]) {
            textField.text = nil;
            [self setTextIN];
        }
        tmp = YES;
    } else {
        
        tmp =  [string ThejudgmentisaletterXx];
        if (tmp) {
            if ((!textField.text || !textField.text.length) && ([string isEqualToString:@"0"] || [string isEqualToString:@"."])) {
                textField.text = @"0.";
                [self setTextIN];
                tmp = NO;
            }
        }
        if (tmp) {
            if ([textField.text rangeOfString:@"."].location != NSNotFound && [string isEqualToString:@"."]) {
                tmp = NO;
            }
        }
        if (tmp) {
            NSRange rang = [textField.text rangeOfString:@"."];
            if (rang.location != NSNotFound) {
                if (textField.text.length - rang.location -1 >=2) {
                    tmp = NO;
                }
            }
        }
    }
    
    return tmp;
}
@end
