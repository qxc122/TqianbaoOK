//
//  BorrowingBillNotOverdue.h
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BorrowingBill.h"

@interface BorrowingBillNotOverdue : BorrowingBill
@property (nonatomic,strong) UserInfoDeatil *userData;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
