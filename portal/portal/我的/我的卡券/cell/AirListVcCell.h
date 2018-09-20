//
//  AirListVcCell.h
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface AirListVcCell : baseCell
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic,strong) bankCard *one;
@end
