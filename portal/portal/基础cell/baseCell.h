//
//  baseCell.h
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

typedef enum {
    baseCell_Click_type_one_Sendsms,
} baseCell_Click_type;


@interface baseCell : UITableViewCell
/**
 *  按钮
 */
@property (nonatomic, copy) void (^doneClick)(baseCell_Click_type type);


@property (nonatomic,strong)id data;
+ (instancetype)returnCellWith:(UITableView *)tableView;
- (void)setData:(id)data;
@end
