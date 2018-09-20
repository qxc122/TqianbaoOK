//
//  addBankCard_selectBankcell.h
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseFillCell.h"

@interface addBankCardselectBankcell : baseFillCell
@property (nonatomic,weak) bankCard *bankCarddata;
/**
 *  按钮
 */
@property (nonatomic, copy) void (^selectBank)();
@end
