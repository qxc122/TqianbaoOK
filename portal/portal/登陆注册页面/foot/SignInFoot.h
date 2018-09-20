//
//  SignInFoot.h
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "RealNameFoot.h"

@interface SignInFoot : RealNameFoot
@property (nonatomic,weak) UILabel *error;
@property (nonatomic,weak) UIButton *reSend;
/**
 *  点击每个btn的回调
 */
@property (nonatomic, copy) void (^ReSendBtn)();
@end
