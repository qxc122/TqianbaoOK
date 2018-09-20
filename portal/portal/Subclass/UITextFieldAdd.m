//
//  UITextFieldAdd.m
//  portal
//
//  Created by Store on 2017/10/17.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "UITextFieldAdd.h"

@implementation UITextFieldAdd
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))//禁止粘贴
        return NO;
    if (action == @selector(select:))// 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    return [super canPerformAction:action withSender:sender];
}
@end
