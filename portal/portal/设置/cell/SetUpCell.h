//
//  SetUpCell.h
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"
#import "HeaderAll.h"





@interface SetUpCell : baseCell
@property (nonatomic, copy) void (^switchBtnClick)(NSString *type,BOOL onOrOff);

@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *des;
@property (nonatomic,weak) UIImageView *more;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UISwitch *switchBtn;

@property (nonatomic,assign) BOOL hidenswitchBtn;
@property (nonatomic,assign) BOOL hidenMoreAndDes;
@end
