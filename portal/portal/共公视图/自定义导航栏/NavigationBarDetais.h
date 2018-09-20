//
//  NavigationBarDetais.h
//  TourismT
//
//  Created by Store on 2017/7/28.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavigationBarDetais : UIView
@property (nonatomic,weak) UIButton *returnBtn;
@property (nonatomic,weak) UIView *HeadBack;
@property (nonatomic,weak) UILabel *titleNa;
@property (nonatomic,weak) UIButton *RightBtn;
@property (nonatomic, copy) void (^ClickreturnBtn)();
@property (nonatomic, copy) void (^ClickRightBtn)();
@end
