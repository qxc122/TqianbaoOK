//
//  homeTwoVcTwo.m
//  portal
//
//  Created by Store on 2018/1/23.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "homeTwoVcTwo.h"
#import "SDCycleScrollView.h"

@interface homeTwoVcTwo ()<SDCycleScrollViewDelegate>
@property (nonatomic,weak) SDCycleScrollView *cycleScrollView;
@end

@implementation homeTwoVcTwo

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    homeTwoVcTwo *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[homeTwoVcTwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner-2"]];
        self.cycleScrollView = cycleScrollView;
        self.cycleScrollView.autoScroll = YES;
        self.cycleScrollView.infiniteLoop = YES;
        self.cycleScrollView.showPageControl = YES;
        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:cycleScrollView];
        
        [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(PROPORTION_HEIGHT*100));
        }];
//        self.cycleScrollView.imageURLStringsGroup = @[@"图片加载图",@"图片加载图",@"图片加载图",@"图片加载图"];
    }
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.doneONeClick) {
        self.doneONeClick(self.dataArry[index]);
    }
}
- (void)setDataArry:(NSMutableArray *)dataArry{
    _dataArry = dataArry;
    NSMutableArray *muarry = [NSMutableArray array];
    for (bannerInfosOne *one in dataArry) {
        [muarry addObject:one.picture];
    }
    self.cycleScrollView.imageURLStringsGroup = muarry;
}
@end
