//
//  myBankCardFoot.h
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myBankCardFoot : UIView
/**
 *  点击每个btn的回调
 */
@property (nonatomic, copy) void (^addBankCard)();
@end
