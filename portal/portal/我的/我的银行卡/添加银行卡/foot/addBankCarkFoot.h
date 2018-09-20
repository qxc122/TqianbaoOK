//
//  addBankCarkFoot.h
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"
#import "YYText.h"

@interface addBankCarkFoot : UIView
@property (nonatomic,weak) YYLabel *label;
@property (nonatomic,weak) UIButton *btn;
/**
 *  点击每个btn的回调
 */
@property (nonatomic, copy) void (^doneBtn)();
/**
 *  点击每个btn的回调
 */
@property (nonatomic, copy) void (^openWkWebVc)(id url);
@end
