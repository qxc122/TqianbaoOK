//
//  homeTwoVcTwo.h
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface homeTwoVcTwo : baseCell
@property (nonatomic,strong) NSMutableArray *dataArry;
@property (nonatomic, copy) void (^doneONeClick)(bannerInfosOne *one);
@end
