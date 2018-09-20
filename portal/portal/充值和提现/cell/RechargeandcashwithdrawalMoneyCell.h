//
//  RechargeandcashwithdrawalMoneyCell.h
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"
#import "UITextFieldAdd.h"




@interface RechargeandcashwithdrawalMoneyCell : baseCell

@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *money;
@property (nonatomic,weak) UITextFieldAdd *input;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UILabel *des;


@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *inText);
@property (nonatomic,assign)RechargeandcashwithdrawalVcState stateMoney; //默认
@property (nonatomic,strong) UserInfoDeatil *userData;
@property (nonatomic,strong) ThreeOk *ThreeOkData;
@property (nonatomic,strong) Conductfinancialtransactions *ConductfinancialtransactionsData;


@property (nonatomic,strong) NSString *type;

- (void)setTextIN;
@end
