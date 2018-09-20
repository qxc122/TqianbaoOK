//
//  SupportHotel.h
//  portal
//
//  Created by MiNi on 2018/3/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"
#import <WebKit/WKFoundation.h>
#import <WebKit/WebKit.h>

@interface SupportHotel : windosView
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) WKWebView *webView;
@end
