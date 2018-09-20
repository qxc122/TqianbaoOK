//
//  ScansuccessChangeTypeCell.h
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"

@interface ScansuccessChangeTypeCell : baseCell
@property (nonatomic, weak) UIImageView *more;
@property (nonatomic, weak) UIImageView *icon;


@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *des;
@property (nonatomic,strong) scanQRCodeOk *scanQRCodeOkdata;
@property (nonatomic,assign) BOOL isBank; //是银行卡还是余额  YES 表示是银行卡
@end
