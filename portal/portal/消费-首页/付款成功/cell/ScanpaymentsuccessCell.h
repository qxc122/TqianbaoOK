//
//  ScanpaymentsuccessCell.h
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface ScanpaymentsuccessCell : baseCell

@property (nonatomic,strong) setUpData *dataScan;
@property (nonatomic,weak) UILabel *title;

@property (nonatomic,weak) UILabel *des;
@property (nonatomic,weak) UIView *line;
@end
