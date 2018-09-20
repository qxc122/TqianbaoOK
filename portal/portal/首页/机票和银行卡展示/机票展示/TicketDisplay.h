//
//  TicketDisplay.h
//  portal
//
//  Created by Store on 2017/10/10.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"


@interface TicketDisplay : UICollectionViewCell
@property (nonatomic,strong) bankCard *bankCardOne;
@property (nonatomic,strong) id AirInfoOne;
@property (nonatomic,assign) NSInteger indexx;
@property (nonatomic, copy) void (^loadSucces)(AirInfo *data,NSInteger indexx,bankCard *atuData);
@end
