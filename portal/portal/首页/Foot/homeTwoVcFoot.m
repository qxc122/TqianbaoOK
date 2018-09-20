//
//  homeTwoVcFoot.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcFoot.h"
#import "MAsonry.h"
#import "MACRO_PORTAL.h"
#import "PortalHelper.h"
@interface homeTwoVcFoot ()

@end


@implementation homeTwoVcFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"logohome.png"];
            [self addSubview:imageView];
            
            
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
            //            label.text = @"腾邦国际旗下服务平台\n安全 I 快捷 ";
            label.numberOfLines = 0;
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:1/1.0];
            
            if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self);
                    make.width.equalTo(@70);
                    make.height.equalTo(@10);
                }];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self);
                    make.right.equalTo(self);
                    make.top.equalTo(imageView.mas_bottom).offset(5);
                    make.bottom.equalTo(self).offset(-20);
                }];
            } else {
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self);
                    make.top.equalTo(self).offset(30);
                    make.width.equalTo(@70);
                    make.height.equalTo(@10);
                }];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self);
                    make.right.equalTo(self);
                    make.top.equalTo(imageView.mas_bottom).offset(5);
                }];
            }
            
            //闪退。qxc
            if ([PHONEVERSION doubleValue]<9.0) {
                label.text = @"腾邦国际旗下服务平台\n安全 I 快捷 ";
            } else {
                NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
                [paragraphStyle1 setLineSpacing:5];
                [paragraphStyle1 setAlignment:NSTextAlignmentCenter];
                NSDictionary *dic = @{
                                      NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:10],
                                      NSForegroundColorAttributeName: [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.3],
                                      NSParagraphStyleAttributeName: paragraphStyle1,
                                      };
                [label setAttributedText:[[NSMutableAttributedString alloc] initWithString:@"腾邦国际旗下服务平台\n安全 I 快捷 " attributes:dic]];
            }
            //            [label sizeToFit];
            
        }
    }
    return self;
}

@end
