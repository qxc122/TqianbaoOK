//
//  BankView.h
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface BankView : UIView
@property (nonatomic, copy) void (^UIViewClick)(bankCard *data,NSInteger tag);
@property (nonatomic,assign) NSInteger tagg;

@property (nonatomic,strong) bankCard *bankCardOne;
@property (nonatomic,weak) UIImageView *back;

@property (nonatomic,weak) UIImageView *logo;
@property (nonatomic,weak) UILabel *cardNumber;
@end
