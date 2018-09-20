//
//  AirTiketView.h
//  portal
//
//  Created by Store on 2017/10/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface AirTiketView : UIView
@property (nonatomic, copy) void (^UIViewClick)(bankCard *data,NSInteger tag);
@property (nonatomic,strong) bankCard *bankCardOne;
@property (nonatomic,assign) NSInteger tagg;
//- (void)restlogo;
@end
