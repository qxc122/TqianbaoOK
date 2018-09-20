//
//  paySussessTicon.h
//  portal
//
//  Created by MiNi on 2018/5/10.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paySussessTicon : UIView
@property (nonatomic, copy) void (^leaveBtnBlock)();
@property (nonatomic, copy) void (^StayTBtnBlock)();
@property (nonatomic,strong) NSString *WhoCalls;
@end
