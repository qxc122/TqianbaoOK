//
//  BorrowingBillNot.h
//  portal
//
//  Created by Store on 2018/1/22.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "BorrowingBill.h"

@interface BorrowingBillNot : BorrowingBill
+ (instancetype)returnCellWith:(UITableView *)tableView;
/**
 *  按钮
 */
@property (nonatomic, copy) void (^BorrowingMoney)();

@property (nonatomic,weak) UILabel *heightTitle;
@property (nonatomic,weak) UILabel *heightMoney;
@property (nonatomic,weak) UIButton *btn1;
@property (nonatomic,weak) UIButton *btn2;
@property (nonatomic,weak) UIButton *btn3;
@property (nonatomic,weak) UIButton *Borrowing;
@end
