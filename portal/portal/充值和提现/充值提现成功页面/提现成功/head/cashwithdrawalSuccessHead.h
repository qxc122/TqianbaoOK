//
//  cashwithdrawalSuccessHead.h
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface cashwithdrawalSuccessHead : UIView
@property (nonatomic, weak) UIImageView *back;
@property (nonatomic, weak) UIImageView *iconTop;
@property (nonatomic, weak) UIView *LineTop;

@property (nonatomic, weak) UILabel *titleTop;
@property (nonatomic, weak) UILabel *DateTop;


@property (nonatomic, weak) UIImageView *iconBottom;
@property (nonatomic, weak) UIView *LineBottom;

@property (nonatomic, weak) UILabel *titleBottom;
@property (nonatomic, weak) UILabel *DateBottom;


@property (nonatomic,strong) Successincashwithdrawal *data;
@end
