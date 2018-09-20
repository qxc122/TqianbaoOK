//
//  teachingPage.m
//  TourismT
//
//  Created by Store on 2017/8/24.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "teachingPage.h"
#import "HeaderAll.h"

@interface teachingPage ()
@property (nonatomic,weak) UIImageView *Box;
@property (nonatomic,weak) UIImageView *Next;
@property (nonatomic,weak) UIButton *NextBtn;

@end

@implementation teachingPage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.back removeFromSuperview];
        [self.close removeFromSuperview];
        
        UIImageView *Box = [UIImageView new];
        [self addSubview:Box];
        
        UIImageView *Next = [UIImageView new];
        [self addSubview:Next];
        
        UIButton *NextBtn = [UIButton new];
        [self addSubview:NextBtn];
        
        self.Box = Box;
        self.Next = Next;
        self.NextBtn = NextBtn;
        [self.Box SetContentModeScaleAspectFill];
        [self.Next SetContentModeScaleAspectFill];
        [self.NextBtn.imageView SetContentModeScaleAspectFill];
//        self.Box.contentMode = UIViewContentModeScaleAspectFill;
//        self.Tip.contentMode = UIViewContentModeScaleAspectFill;
//        self.title.contentMode = UIViewContentModeScaleAspectFill;
//        self.Next.contentMode = UIViewContentModeScaleAspectFill;
//        
//        self.Box.clipsToBounds = YES;
//        self.Tip.clipsToBounds = YES;
//        self.title.clipsToBounds = YES;
//        self.Next.clipsToBounds = YES;
        
        [self oneStep];
        [NextBtn addTarget:self action:@selector(NextBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        99+6-45+45*HEIGHTICON

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(TheTeachingPageIsDisplayedFunc:)
                                                     name:TheTeachingPageIsDisplayed
                                                   object:nil];

    }
    return self;
}

- (void)TheTeachingPageIsDisplayedFunc:(NSNotification *)user{
    self.hidden = NO;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)oneStep{

    [self.Box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(65);
        if (IPoneX) {
            make.top.equalTo(self).offset(63+20);
        } else {
            make.top.equalTo(self).offset(63);
        }
        make.width.equalTo(@(166*PROPORTION_HEIGHT));
        make.height.mas_equalTo(self.Box.mas_width).multipliedBy(89/166.0);
    }];

    [self.Next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Box);
        make.top.equalTo(self.Box.mas_bottom).offset(16*PROPORTION_HEIGHT);
        make.width.equalTo(@(72*PROPORTION_WIDTH));
        make.height.mas_equalTo(self.Next.mas_width).multipliedBy(41/72.0);
    }];
    [self.NextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Next);
        make.top.equalTo(self.Next);
        make.width.equalTo(self.Next);
        make.height.equalTo(self.Next);
    }];
    
    self.Box.image = [UIImage imageNamed:@"step1"];
    self.Next.image = [UIImage imageNamed:@"step好的"];
}

- (void)TwoStep{
    CGFloat tmp = SCREENWIDTH*250/375.0+80+10+25;
    [self.Box mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(tmp);
        make.left.equalTo(self).offset(91);
        make.width.equalTo(@(194*PROPORTION_HEIGHT));
        make.height.mas_equalTo(self.Box.mas_width).multipliedBy(90/194.0);
    }];
    
    [self.Next mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Box);
        make.top.equalTo(self.Box.mas_bottom).offset(14*PROPORTION_HEIGHT);
        make.width.equalTo(@(102*PROPORTION_WIDTH));
        make.height.mas_equalTo(self.Next.mas_width).multipliedBy(41/72.0);
    }];
    [self.NextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Next);
        make.top.equalTo(self.Next);
        make.width.equalTo(self.Next);
        make.height.equalTo(self.Next);
    }];
    
    self.Box.image = [UIImage imageNamed:@"step2"];
    self.Next.image = [UIImage imageNamed:@"step好的"];
}

- (void)ThreeStep{
    [self.Box mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(-20);
        if (IPoneX) {
            make.bottom.equalTo(self).offset(-42-36);
        } else {
            make.bottom.equalTo(self).offset(-42);
        }
        make.width.equalTo(@(152*PROPORTION_HEIGHT));
        make.height.mas_equalTo(self.Box.mas_width).multipliedBy(90/152.0);
    }];
    
    [self.Next mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Box);
        make.bottom.equalTo(self.Box.mas_top).offset(-14*PROPORTION_HEIGHT);
        make.width.equalTo(@(102*PROPORTION_WIDTH));
        make.height.mas_equalTo(self.Next.mas_width).multipliedBy(41/102.0);
    }];
    [self.NextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Next);
        make.top.equalTo(self.Next);
        make.width.equalTo(self.Next);
        make.height.equalTo(self.Next);
    }];
    
    self.Box.image = [UIImage imageNamed:@"step3"];
    self.Next.image = [UIImage imageNamed:@"step知道了"];
}
- (void)windosViewshow{
    [super windosViewshow];
//    self.hidden = YES;
}
- (void)NextBtnClick{
    self.NextBtn.tag ++;
    if (self.NextBtn.tag == 1) {
        [self TwoStep];
    } else if (self.NextBtn.tag == 2) {
        [self ThreeStep];
    } else if (self.NextBtn.tag == 3) {
//        NSNotification *notification =[NSNotification notificationWithName:TheTeachingPageDisappeared object:nil userInfo:nil];
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self closeClisck];
    }
}
@end
