//
//  BorrowingBill.h
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface BorrowingBill : baseCell
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIView *line;
+ (instancetype)returnCellWith:(UITableView *)tableView;

@end
