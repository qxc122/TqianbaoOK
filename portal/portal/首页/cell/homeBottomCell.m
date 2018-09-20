//
//  homeBottomCell.m
//  portal
//
//  Created by Store on 2017/10/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "homeBottomCell.h"
#import "HeaderAll.h"
#import "BankView.h"
#import "AirTiketView.h"

@interface homeBottomCell ()
@property (nonatomic,weak) UIImageView *head;
@property (nonatomic,weak) UIView *content;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIView *backAll;

@property (nonatomic,weak) UIImageView *contentIcon;
@property (nonatomic,weak) UILabel *contentTitle;
@property (nonatomic,weak) UILabel *contentDes;
@end

@implementation homeBottomCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *backAll = [UIView new];
        self.backAll = backAll;
        [self.contentView addSubview:backAll];

        UIImageView *head = [UIImageView new];
        self.head = head;
        [self.contentView addSubview:head];
        
        UILabel *title = [UILabel new];
        self.title = title;
        [self.contentView addSubview:title];

        UIView *content = [UIView new];
        self.content = content;
        [self.contentView addSubview:content];
        
        UIImageView *contentIcon = [UIImageView new];
        self.contentIcon = contentIcon;
        [self.contentView addSubview:contentIcon];
        
        UILabel *contentTitle = [UILabel new];
        self.contentTitle = contentTitle;
        [self.contentView addSubview:contentTitle];
        
        UILabel *contentDes = [UILabel new];
        self.contentDes = contentDes;
        [self.contentView addSubview:contentDes];

        CGFloat height = SCREENHEIGHT-SCREENWIDTH*250/375.0-80-10-49;
        if (IPoneX) {
            height -= HEIGHT_FOR_X;
        }
        [backAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(height));
        }];
        
        [head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(25);
            make.width.equalTo(@8);
            make.height.equalTo(@9);
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.head.mas_right).offset(12);
            make.centerY.equalTo(self.head);
        }];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(60);
            make.bottom.equalTo(self.contentView).offset(-13);
        }];
        [contentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(60*PROPORTION_WIDTH);
            make.width.equalTo(@(100*PROPORTION_WIDTH));
            make.height.mas_equalTo(contentIcon.mas_width).multipliedBy(95.7/100.0);
        }];
        [contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentIcon.mas_bottom).offset(19*PROPORTION_HEIGHT);
        }];
        [contentDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentTitle.mas_bottom).offset(23*PROPORTION_HEIGHT);
        }];

        [contentDes setWithColor:0xC4C8CE Alpha:1.0 Font:12 ROrM:@"r"];
        [contentTitle setWithColor:0x9DA4AE Alpha:1.0 Font:14 ROrM:@"r"];
        [title setWithColor:0x15191F Alpha:1.0 Font:15 ROrM:@"r"];
        head.backgroundColor = ColorWithHex(0xDCC7AB, 1.0);
//        [self.content addTarget:self action:@selector(contentclick:) forControlEvents:UIControlEventTouchUpInside];
        self.content.userInteractionEnabled = NO;
        contentIcon.image = ImageNamed(PIC_HOME_DATA_PLACE);
        [contentIcon SetContentModeScaleAspectFill];
        //tset
//        backAll.backgroundColor = [UIColor redColor];
        title.text = @"卡票券";
        contentTitle.text = @"暂无卡票券";
        contentDes.attributedText = [@"实名认证后，您当前绑定的银行卡、近三\n个月通过腾邦预定的机票会自动收纳在这里" CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xC4C8CE, 1.0) LineSpacing:8.0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];

//        contentDes.text = @"实名认证后，您当前绑定的银行卡、近三\n个月通过腾邦预定的机票会自动收纳在这里";
        contentDes.numberOfLines = 0;
        contentDes.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)contentclick:(UIButton *)btn{
    if (self.ClicBtn) {
        self.ClicBtn(nil,100);
    }
}

- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;

    for (UIView *tmp in self.contentView.subviews) {
        if ([tmp isKindOfClass:[BankView class]] || [tmp isKindOfClass:[AirTiketView class]]) {
            [tmp removeFromSuperview];
        }
    }

    if (userData) {
        CGFloat contentHeight = SCREENHEIGHT-SCREENWIDTH*250/375.0-80-10-49-60-13;
        NSInteger index = 0;
        
        NSMutableArray *source = [NSMutableArray array];
        for (bankCard *data in userData.Arry_list) {
            if ([data.displayFlag isEqualToString:STRING_1]) {
                [source addObject:data];
            }
        }
        
        if (source.count) {
            self.contentIcon.hidden = YES;
            self.contentTitle.hidden = YES;
            //        [self.content setBackgroundImage:nil forState:UIControlStateNormal];
        } else {
            self.contentIcon.hidden = NO;
            self.contentTitle.hidden = NO;
            //        [self.content setBackgroundImage:ImageNamed(PIC_HOME_DATA_PLACE) forState:UIControlStateNormal];
        }
        
        self.contentDes.hidden = NO;
        for (bankCard *data in source) {
            self.contentDes.hidden = YES;
            if ([data.type isEqualToString:HOME_TYPE_BANK]) {
                BankView *tmp = [BankView new];
                kWeakSelf(self);
                tmp.UIViewClick = ^(bankCard *data,NSInteger tag) {
                    if (weakself.ClicBtn) {
                        weakself.ClicBtn(data,tag);
                    }
                };
                tmp.tagg = index;
                tmp.bankCardOne = data;
                [self.contentView addSubview:tmp];
                [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.content);
                    make.right.equalTo(self.content);
                    if (index ==0) {
                        make.top.equalTo(self.content);
                    }else if (index ==1 && (index != source.count-1)) {
                        if (source.count == 3) {
                            bankCard *tmp = source[index+1];
                            CGFloat height = 0;
                            if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
                                height = (contentHeight - (SCREENWIDTH-40)*160/335.0)*0.5;
                            } else if ([tmp.type isEqualToString:HOME_TYPE_AIR]) {
                                height = (contentHeight - (SCREENWIDTH-40)*120/335.0)*0.5;
                            }
                            make.top.equalTo(self.content).offset(height);
                        } else if (source.count >= 4) {
                            make.top.equalTo(self.content).offset(10*PROPORTION_HEIGHT);
                        }
                    }else if (index ==2 && (index != source.count-1)) {
                        bankCard *tmp = source[index+1];
                        CGFloat height = 0;
                        if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
                            height = (contentHeight - (SCREENWIDTH-40)*160/335.0-10*PROPORTION_HEIGHT)*0.5;
                        } else if ([tmp.type isEqualToString:HOME_TYPE_AIR]) {
                            height = (contentHeight - (SCREENWIDTH-40)*120/335.0-10*PROPORTION_HEIGHT)*0.5;
                        }
                        make.top.equalTo(self.content).offset(height+10*PROPORTION_HEIGHT);
                    }else if (index ==3 || (index == source.count-1)) {
                        make.bottom.equalTo(self.content);
                    }
                    make.height.equalTo(tmp.mas_width).multipliedBy(160/335.0);
                }];
            } else if ([data.type isEqualToString:HOME_TYPE_AIR]) {
                AirTiketView *tmp2 = [AirTiketView new];
                tmp2.tagg = index;
//                if (index == 0) {
                //                    [tmp2 restlogo];
//                }
                kWeakSelf(self);
                tmp2.UIViewClick = ^(bankCard *data,NSInteger tag) {
                    if (weakself.ClicBtn) {
                        weakself.ClicBtn(data,tag);
                    }
                };
                tmp2.bankCardOne = data;
                [self.contentView addSubview:tmp2];
                [tmp2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.content);
                    make.right.equalTo(self.content);
                    if (index ==0) {
                        make.top.equalTo(self.content);
                    }else if (index ==1 && (index != source.count-1)) {
                        if (source.count == 3) {
                            bankCard *tmp = source[index+1];
                            CGFloat height = 0;
                            if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
                                height = (contentHeight - (SCREENWIDTH-40)*160/335.0)*0.5;
                            } else if ([tmp.type isEqualToString:HOME_TYPE_AIR]) {
                                height = (contentHeight - (SCREENWIDTH-40)*120/335.0)*0.5;
                            }
                            make.top.equalTo(self.content).offset(height);
                        } else if (source.count >= 4) {
                            make.top.equalTo(self.content).offset(10*PROPORTION_HEIGHT);
                        }
                    }else if (index ==2 && (index != source.count-1)) {
                        bankCard *tmp = source[index+1];
                        CGFloat height = 0;
                        if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
                            height = (contentHeight - (SCREENWIDTH-40)*160/335.0-10*PROPORTION_HEIGHT)*0.5;
                        } else if ([tmp.type isEqualToString:HOME_TYPE_AIR]) {
                            height = (contentHeight - (SCREENWIDTH-40)*120/335.0-10*PROPORTION_HEIGHT)*0.5;
                        }
                        make.top.equalTo(self.content).offset(height+10*PROPORTION_HEIGHT);
                    }else if (index ==3 || (index == source.count-1)) {
                        make.bottom.equalTo(self.content);
                    }
                    make.height.equalTo(tmp2.mas_width).multipliedBy(120/335.0);
                }];
            }
            index++;
            if (index >3) {
                break;
            }
        }
    }else{
        self.contentDes.hidden = NO;
        self.contentIcon.hidden = NO;
        self.contentTitle.hidden = NO;
    }
    [self.contentView bringSubviewToFront:self.content];
}
@end
