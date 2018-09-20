//
//  ThirdpartypaymentindesignHead.m
//  portal
//
//  Created by Store on 2017/10/21.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ThirdpartypaymentindesignHead.h"

@interface ThirdpartypaymentindesignHead ()

@end


@implementation ThirdpartypaymentindesignHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * icon = [[UIImageView alloc]init];
        self.icon = icon;
        [self addSubview:icon];
        
        UILabel * titlee = [[UILabel alloc]init];
        self.titlee = titlee;
        [self addSubview:titlee];

        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(30*PROPORTION_WIDTH);
            make.height.equalTo(@(60*PROPORTION_WIDTH));
            make.width.equalTo(@(60*PROPORTION_WIDTH));
        }];
        
        [titlee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.icon);
            make.top.equalTo(self.icon.mas_bottom).offset(15*PROPORTION_HEIGHT);
        }];

        titlee.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor  =ColorWithHex(0xD8D8D8,0.22);
        [icon SetContentModeScaleAspectFill];
        [icon SetFilletWith:60*PROPORTION_WIDTH];
        [titlee setWithColor:0x000000 Alpha:1.0 Font:24 ROrM:@"m"];
        icon.image = [UIImage imageNamed:@"logo"];
//        titlee.text = @"转账成功";
    }
    return self;
}

- (void)setPasteboarddata:(NSDictionary *)pasteboarddata{
    _pasteboarddata = pasteboarddata;
    self.titlee.text = [NSString stringWithFormat:@"%@%@",@"￥",pasteboarddata[@"money"]];
}
@end
