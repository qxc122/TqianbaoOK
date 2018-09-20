//
//  homeHead.h
//  portal
//
//  Created by Store on 2018/1/24.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"
@interface homeHead : UIView
/**
 *  按钮
 */
@property (nonatomic, copy) void (^moreViewClick)();
@property (nonatomic,strong) HomeDataNew *dataNew;
@property (nonatomic,weak) UIImageView *backPng;
@end
