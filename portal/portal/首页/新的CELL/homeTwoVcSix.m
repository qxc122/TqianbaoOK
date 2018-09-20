//
//  homeTwoVcSix.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcSix.h"


@interface homeTwoVcSix ()
@property (nonatomic, weak) UILabel *des;
@property (nonatomic, weak) UIImageView *moreIcon;

@property (nonatomic, weak) UIButton *more;
@end

@implementation homeTwoVcSix

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    homeTwoVcSix *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[homeTwoVcSix alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.icon.image = [UIImage imageNamed:@"贷款.png"];
        self.title.text = @"随行借";
        self.heightMoney.text = @"100000.00";
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(20);
            make.width.equalTo(@8);
            make.height.equalTo(@9);
        }];
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"提前还款无手续费";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:30/255.0 green:46/255.0 blue:71/255.0 alpha:0.5];
            [self.contentView addSubview:label];
            self.des = label;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.icon);
                make.right.equalTo(self.contentView).offset(-37);
            }];
        }
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"更多.png"];
            [self.contentView addSubview:imageView];
            self.moreIcon = imageView;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.des);
                make.left.equalTo(self.des.mas_right).offset(10);
                make.width.equalTo(@6);
                make.height.equalTo(@11);
            }];
        }
        UIButton *imageView = [[UIButton alloc] init];
        [self.contentView addSubview:imageView];
        self.more = imageView;
        self.more.userInteractionEnabled = NO;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.line.mas_top);
            make.left.equalTo(self.des);
            make.right.equalTo(self.moreIcon);
        }];
        [imageView addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        

        {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = ColorWithHex(0xEEEEEE, 1.0);
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView);
                make.top.equalTo(self.btn1.mas_bottom).offset(20);
                make.height.equalTo(@0.5);
            }];
            
            [self.Borrowing mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@100);
                make.height.equalTo(@56);
                make.top.equalTo(view.mas_bottom);
                make.centerX.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView);
            }];
            self.Borrowing.userInteractionEnabled = NO;
            [self.Borrowing setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    return self;
}
- (void)moreClick{
    if (self.moreViewClick) {
        self.moreViewClick();
    }
}
@end
