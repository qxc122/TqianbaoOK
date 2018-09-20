//
//  homeBottomCell.h
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface homeBottomCell : baseCell
@property (nonatomic,strong) UserInfoDeatil *userData;
@property (nonatomic, copy) void (^ClicBtn)(bankCard *data,NSInteger tag);
@end
