//
//  turnOutType.h
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface turnOutType : baseCell
@property (nonatomic,assign) NSString *Outtype;   //转出方式
//更改方式  快速 和 非快速
@property (nonatomic, copy) void (^typeClicks)(NSString *type);

@property (nonatomic,strong) tpTreasurequeryPayMethod *PayMethodData;
@end
