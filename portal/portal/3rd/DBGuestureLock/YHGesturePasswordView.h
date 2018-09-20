//
//  YHGesturePasswordView.h
//  手势密码
//
//  Created by mrlee on 2017/3/5.
//  Copyright © 2017年 mrlee. All rights reserved.
//
typedef enum {
    GestureSetPassword, //设置手势密码
    GestureResultPassword //已有手势密码教验
} PasswordState;
//设置密码的3种状态
typedef enum {
    FristPwd, //第一次设置密码
    PwdNoValue, //二次设置密码不一致
    SetPwdSuccess,  //设置密码成功
    WrongLength,  
    Other
}SetPwdState;

#import <UIKit/UIKit.h>


@interface YHGesturePasswordView : UIView
@property (nonatomic,assign)NSUInteger times;

///
@property (nonatomic,strong)NSString *pwdValue;
///错误时的图片
@property (nonatomic,assign)NSUInteger passWordLeng;

///错误时的图片
@property (nonatomic,strong)UIImage *btnSelectImageError;
///划线颜色
@property (nonatomic,strong)UIColor *lineColor;
///错误的划线颜色
@property (nonatomic,strong)UIColor *lineColorError;

//清空
-(void)reset;

/** 解锁手势完成之后判断结果时调用的block */
@property (nonatomic,copy)void (^sendReaultDataWhenMoved)(NSMutableArray *Arry);

/** 解锁手势完成之后判断结果时调用的block */
@property (nonatomic,copy)BOOL (^sendReaultData)(NSString *str);

//设置手势密码
@property(nonatomic,copy)void(^setPwdBlock)(SetPwdState pwdState,NSString *str);


// init
-(instancetype)initWithFrame:(CGRect)frame WithNormalImg:(UIImage *)normalImg WithSelectedImg:(UIImage *)selectedImg WithState:(PasswordState)state;

@end
