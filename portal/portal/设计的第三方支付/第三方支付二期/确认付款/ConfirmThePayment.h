//
//  ConfirmThePayment.h
//  portal
//
//  Created by MiNi on 2018/5/10.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"

@interface ConfirmThePayment : windosView
@property (nonatomic, copy) void (^guanbi)();
@property (nonatomic, copy) void (^type)();
@property (nonatomic, copy) void (^doneOk)();
@property (nonatomic, copy) void (^Tmoneytype)(NSString *tcoinFlag); // @"0"  不用。默认0
- (void)windosViewshowSub:(UIView *)subView;

//@property (nonatomic,strong) NSString *tcoinFlag;
@property (nonatomic,assign) BOOL isOA;
@property (nonatomic,strong) NSDictionary *pasteboarddata;
@property (nonatomic,strong) ThreeOk *ThreeOkdata;
@property (nonatomic,strong) NSString *payMethod;
@end
