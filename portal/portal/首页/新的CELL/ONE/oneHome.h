//
//  oneHome.h
//  portal
//
//  Created by Store on 2018/1/24.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface oneHome : UIView
@property (nonatomic,strong) oneHomeData *one;
@property (nonatomic, copy) void (^doneClick)(oneHomeData *one);
@end
