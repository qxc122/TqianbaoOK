//
//  newsListVc.m
//  portal
//
//  Created by Store on 2017/9/27.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "newsListVc.h"
#import "newsListCell.h"

@interface newsListVc ()

@end

@implementation newsListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"消息", @"");
    // Do any additional setup after loading the view.
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    self.registerClasss = @[[newsListCell class]];
}

#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    newsListCell *cell = [newsListCell returnCellWith:tableView];
    [self configurenewsListCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configurenewsListCell:(newsListCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.empty_type == succes_empty_num) {
        return 1;
    }
    return 0;
}
@end
