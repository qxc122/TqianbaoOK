//
//  ScansuccessCell.h
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"
#import "UITextFieldAdd.h"

@interface ScansuccessCell : baseCell
@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *inText);
@property (nonatomic,strong) scanQRCodeOk *scanQRCodeOkdata;
@property (nonatomic, weak) UITextFieldAdd *moneyInput;
@end
