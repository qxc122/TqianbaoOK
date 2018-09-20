//
//  SelectBank.h
//  TourismT
//
//  Created by Store on 2017/4/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"


@interface SelectBank : UIView
/**
 *  点击每个btn的回调
 */
@property (nonatomic, copy) void (^SelectBank)(id bank);
- (void)windosViewshow;

@end
