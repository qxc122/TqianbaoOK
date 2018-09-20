//
//  SYPasswordView.h
//  PasswordDemo
//
//  Created by aDu on 2017/2/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextFieldAdd.h"
@interface SYPasswordView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextFieldAdd *textField;
/**
 *  清除密码
 */
- (void)clearUpPassword;

//输入完毕
@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *inText);

//输入中
@property (nonatomic, copy) void (^Fill_In_input)(NSString *inText);
@end
