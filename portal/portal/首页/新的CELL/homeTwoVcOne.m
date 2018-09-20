//
//  homeTwoVcOne.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcOne.h"
#import "oneHome.h"

@interface homeTwoVcOne ()
@property (nonatomic,strong) NSMutableArray *arry;
@end

@implementation homeTwoVcOne

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    homeTwoVcOne *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[homeTwoVcOne alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSInteger index = 0;
        for (oneHome *one in self.contentView.subviews) {
            if ([one isKindOfClass:[oneHome class]]) {
                [one removeFromSuperview];
            }
        }
        for (oneHomeData *one in self.arry) {
            oneHome *tmp = [oneHome new];
            tmp.one = one;
            [self.contentView addSubview:tmp];
            CGFloat topOf = (index / 4) * (53+12+6);
            CGFloat LeftOf = (index % 4) * (SCREENWIDTH/4.0);
            [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(topOf);
                make.left.equalTo(self.contentView).offset(LeftOf);
                make.width.equalTo(@(SCREENWIDTH/4.0));
                make.height.equalTo(@(53+12+6));
                if (index == _arry.count - 1) {
                    make.bottom.equalTo(self.contentView).offset(-14);
                }
            }];
            
            index++;
        }
    }
    return self;
}
- (void)setDoneONeClick:(void (^)(oneHomeData *))doneONeClick{
    _doneONeClick = doneONeClick;
    for (oneHome *one in self.contentView.subviews) {
        if ([one isKindOfClass:[oneHome class]]) {
            one.doneClick = self.doneONeClick;
        }
    }
}
-(NSMutableArray *)arry{
    if (!_arry) {
        _arry = [NSMutableArray array];
        {
            oneHomeData *data = [oneHomeData new];
            data.icon = @"定期";
            data.title = @"定期";
            data.redPoint = @"加息";
            [_arry addObject:data];
        }
        {
            oneHomeData *data = [oneHomeData new];
            data.icon = @"腾邦宝Home";
            data.title = @"腾邦宝";
            data.redPoint = @"支持快赎";
            [_arry addObject:data];
        }
        {
            oneHomeData *data = [oneHomeData new];
            data.icon = @"员工福利";
            data.title = @"员工福利";
            data.redPoint = @"随借随还home";
            [_arry addObject:data];
        }
        {
            oneHomeData *data = [oneHomeData new];
            data.icon = @"高端理财";
            data.title = @"高端理财";
            [_arry addObject:data];
        }
        {
            oneHomeData *data = [oneHomeData new];
            data.icon = @"票券";
            data.title = @"票券";
            [_arry addObject:data];
        }
        {
            oneHomeData *data = [oneHomeData new];
            data.icon = @"零钱HOme";
            data.title = @"零钱";
            [_arry addObject:data];
        }
        {
            oneHomeData *data = [oneHomeData new];
            data.icon = @"付款";
            data.title = @"付款";
            data.redPoint = @"戳我付款";
            [_arry addObject:data];
        }
        if ([[[PortalHelper sharedInstance]get_Globaldata].iosDeployVerCode integerValue] == [APP_BUILD integerValue]) {
            [_arry removeObjectAtIndex:0];
            [_arry removeObjectAtIndex:1];
            [_arry removeObjectAtIndex:1];
            [_arry exchangeObjectAtIndex:3 withObjectAtIndex:2];
        }
    }
    return _arry;
}
@end
