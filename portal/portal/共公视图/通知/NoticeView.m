//
//  NoticeView.m
//  portal
//
//  Created by MiNi on 2018/7/18.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "NoticeView.h"
#import <WebKit/WKFoundation.h>
#import <WebKit/WebKit.h>




@interface NoticeView ()
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) WKWebView *content;
@end


@implementation NoticeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.back.userInteractionEnabled = YES;
        [self.back SetFilletWith:0.0];

        {
            UILabel *title = [[UILabel alloc] init];
            title.text = @"系统维护通知";
            title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
            title.textColor = [UIColor colorWithRed:22/255.0 green:30/255.0 blue:43/255.0 alpha:1];
            self.title = title;
            [self.back addSubview:title];
        }
        {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
            self.line = line;
            [self.back addSubview:line];
        }
        {
            WKWebView *content = [[WKWebView alloc] init];
            self.content = content;
            [self.back addSubview:content];
        }
        
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@378);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.back).offset(20);
            make.centerX.equalTo(self.back);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.mas_bottom).offset(20);
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.height.equalTo(@0.5);
        }];
        [self.close mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.title);
            make.right.equalTo(self.back).offset(-4.5);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
        }];
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back);
            make.right.equalTo(self.back);
            make.top.equalTo(self.line.mas_bottom);
            make.bottom.equalTo(self.back);
        }];
        [self.close setImage:[[UIImage imageNamed:@"关闭"] thumbnailsize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
        self.close.imageEdgeInsets = UIEdgeInsetsMake(14.5, 14.5, 14.5, 14.5);
//        [self.content loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    }
    return self;
}
- (void)setMynoticeData:(noticeData *)MynoticeData{
    _MynoticeData = MynoticeData;
//    [self.content loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:MynoticeData.info]]];
    [self.content loadHTMLString:MynoticeData.info baseURL:nil];
}
@end
