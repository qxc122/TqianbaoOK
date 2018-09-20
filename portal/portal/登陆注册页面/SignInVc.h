//
//  SignInVc.h
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"

@interface SignInVc : basicUiTableView
@property (nonatomic,copy) LoadSuccess block;
@property (nonatomic,strong) NSMutableArray *Arry_data;


- (void)sendVerifyCodeWithmobile:(NSString *)phone;
@end
