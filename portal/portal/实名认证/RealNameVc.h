//
//  RealNameVc.h
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AddBankCardVc.h"
#import "RealNameHead.h"

@interface RealNameVc : AddBankCardVc

@property (nonatomic,weak) RealNameHead *head;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
