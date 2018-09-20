//
//  HelpandfeedbackCoCell.m
//  portal
//
//  Created by Store on 2017/10/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "HelpandfeedbackCoCell.h"


@interface HelpandfeedbackCoCell()

@end

@implementation HelpandfeedbackCoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imge = [UIImageView new];
        self.imge = imge;
        [self.contentView addSubview:imge];
        [self.imge SetContentModeScaleAspectFill];
        [imge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}
@end
