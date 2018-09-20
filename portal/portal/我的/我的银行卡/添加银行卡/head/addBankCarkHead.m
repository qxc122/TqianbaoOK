//
//  addBankCarkHead.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "addBankCarkHead.h"
#import "HeaderAll.h"

@interface addBankCarkHead ()
@property (nonatomic,weak) UILabel *head;
@end

@implementation addBankCarkHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOUR_BACK_NORMAL;
        UILabel *head = [UILabel new];
        self.head = head;
        [head setWithColor:NORMOL_GRAY Alpha:1.0 Font:12 ROrM:@"r"];
        [self addSubview:head];
        [head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(13);
            make.bottom.equalTo(self).offset(-13);
        }];
    }
    return self;
}
- (void)setDes:(NSString *)des{
    _des = des;
    self.head.text = des;
}
@end
