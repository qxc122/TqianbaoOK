//
//  SupportHotel.m
//  portal
//
//  Created by MiNi on 2018/3/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "SupportHotel.h"

@implementation SupportHotel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.back.backgroundColor = [UIColor whiteColor];
        self.back.userInteractionEnabled = YES;
        [self.back SetFilletWith:0.0];
        
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.height.equalTo(@378);
        }];
        [self.close setImage:[UIImage imageNamed:@"关闭提示图标"] forState:UIControlStateNormal];
        [self.close mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@44);
            make.height.equalTo(@44);
            make.top.equalTo(self.back).offset(7.5);
            make.left.equalTo(self.back).offset(5.5);
        }];
        
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentCenter;
        self.title = title;
        [self addSubview:title];
        self.title.text = @"支持酒店";
        self.title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        self.title.textColor = [UIColor colorWithRed:22/255.0 green:30/255.0 blue:43/255.0 alpha:1/1.0];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(0);
            make.right.equalTo(self.back).offset(0);
            make.centerY.equalTo(self.close);
            make.height.equalTo(@17);
        }];
        
        WKWebView *webView = [[WKWebView alloc]init];
        self.webView = webView;
        [self addSubview:webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(0);
            make.right.equalTo(self.back).offset(0);
            make.top.equalTo(self.back).offset(57);
            make.bottom.equalTo(self.back);
        }];

        NSString *url;
#ifdef DEBUG
        NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
        if (!strles) {
            [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
            url = tesetURLAddress;
        }else{
            url = strles;
        }
#else
        url = URLBASIC;
#endif
        url = [url stringByAppendingString:@"/h5/dist/index.html#/hotel-list"];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
    return self;
}

@end
