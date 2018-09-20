//
//  baseFillCell.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseFillCell.h"

@interface baseFillCell ()<UITextFieldDelegate>


@end

@implementation baseFillCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    baseFillCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.backgroundColor = [UIColor clearColor];
        
        UIView *line = [UIView new];
        self.line = line;
        [self.contentView addSubview:line];
        
        UILabel *title = [UILabel new];
        self.title = title;
        [self.contentView addSubview:title];
        
        UITextFieldAdd *input = [UITextFieldAdd new];
        [input addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.input = input;
        self.input.delegate = self;
        [self.contentView addSubview:input];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(60);
            make.height.equalTo(@0.5);
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.bottom.equalTo(self.line);
            make.height.equalTo(@(14+20));
            make.width.equalTo(@(51+32));
        }];
        [self.input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right);
            make.right.equalTo(self.line);
            make.bottom.equalTo(self.title);
            make.top.equalTo(self.title);
        }];

        line.backgroundColor = COLOUR_LINE_NORMALTWO;
        
        [title setWithColor:NORMOL_GRAY Alpha:1.0 Font:15 ROrM:@"r"];
        [self.input setWithColor:NORMOL_BLACK Alpha:1.0 Font:15 ROrM:@"r"];
        [self.input setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

#pragma  -mark<输入框改变了>
-(void)textFieldDidChange :(UITextField *)textField{
    if (self.inputInfo.existedLength && textField.text.length > self.inputInfo.existedLength) {
        textField.text = [textField.text substringToIndex:self.inputInfo.existedLength];
    }
    if (self.inputInfo.existedLength && textField.text.length == self.inputInfo.existedLength) {
        [self inputresignFirstResponder];
    }
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(textField.placeholder, textField.text,textField);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.inputInfo.contentType == baseFillCellType_LettersAndChinese) {
        textField.text = [textField.text filterCharactorwithRegex:@"[^\u4e00-\u9fa5]"];
    }
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(textField.placeholder, textField.text,textField);
    }
}
- (void)inputresignFirstResponder{
    if ([self.input canResignFirstResponder]) {
        [self.input resignFirstResponder];
    }
}
#define NUMBERS @"0123456789"
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        BOOL tmp = NO;
        if (self.inputInfo.contentType == UIKeyboardTypeNumberPad) {
            NSCharacterSet*cs = [NSCharacterSet decimalDigitCharacterSet];
            NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            tmp =  ![string isEqualToString:filtered];
        } else if (self.inputInfo.contentType == baseFillCellType_NumbersAndletters) {
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
        } else if (self.inputInfo.contentType == baseFillCellType_LettersAndChinese) {
            tmp = YES;
        } else if (self.inputInfo.contentType == baseFillCellType_ID) {
            BOOL tmpOne = NO;;
            BOOL tmpTwo = NO;
            NSCharacterSet*cs = [NSCharacterSet decimalDigitCharacterSet];
            NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            tmpOne =  ![string isEqualToString:filtered];
            tmpTwo = [self ThejudgmentisaletterXx:string];
            tmp = tmpOne||tmpTwo;
        } else {
            tmp = YES;
        }
        if (tmp) {
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            
            if (self.inputInfo.existedLength && (existedLength - selectedLength + replaceLength) > self.inputInfo.existedLength) {
                tmp = NO;
            }
            if (self.inputInfo.existedLength && (existedLength - selectedLength + replaceLength) == self.inputInfo.existedLength) {
                NSMutableString *tmp = [textField.text mutableCopy];
                if (!tmp) {
                    tmp = [@"" mutableCopy];
                }
                [tmp insertString:string atIndex:range.location];
                textField.text = tmp;
                [self inputresignFirstResponder];
            }
        }
        return tmp;
    }
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (self.becomeFill_in_the_text) {
//        self.becomeFill_in_the_text(textField);
//    }
//}
- (BOOL)ThejudgmentisaletterXx:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"Xx"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

//#define NUM @"0123456789"
//#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
//
//
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    return [string isEqualToString:filtered];
//}

//1 controlCharacterSet//控制符
//2 whitespaceCharacterSet//空格
//3 whitespaceAndNewlineCharacterSet//空格换行
//4 decimalDigitCharacterSet//小数
//5 letterCharacterSet//文字
//6 lowercaseLetterCharacterSet//小写字母
//7 uppercaseLetterCharacterSet//大写字母
//8 nonBaseCharacterSet//非基础
//9 alphanumericCharacterSet//字母数字
//10 decomposableCharacterSet//可分解
//11 illegalCharacterSet//非法
//12 punctuationCharacterSet//标点
//13 capitalizedLetterCharacterSet//大写
//14 symbolCharacterSet//符号
//15 newlineCharacterSet//换行符

- (void)setInputInfo:(setUpData *)inputInfo{
    _inputInfo = inputInfo;
    self.title.text = inputInfo.title;
    self.input.placeholder = inputInfo.describe;
    self.input.clearButtonMode = inputInfo.clearButtonMode;
    self.input.keyboardType = inputInfo.keyboardType;

}
@end
