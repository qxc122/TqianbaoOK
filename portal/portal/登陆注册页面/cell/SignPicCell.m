//
//  SignPicCell.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SignPicCell.h"


@interface SignPicCell ()
@property (nonatomic,weak) UIImageView *pic;
@end

@implementation SignPicCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    SignPicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        UIImageView *pic = [UIImageView new];
        self.pic = pic;
        [pic SetContentModeScaleAspectFill];
        [self.contentView addSubview:pic];
        
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line);
            make.bottom.equalTo(self.line);
            make.height.equalTo(@(14+20));
            make.width.equalTo(@(0));
        }];
        [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right);
            make.right.equalTo(self.pic.mas_left).offset(-10);
            make.bottom.equalTo(self.title);
            make.top.equalTo(self.title);
        }];
        
        [pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.line);
            make.width.equalTo(@70);
            make.height.equalTo(@30);
            make.centerY.equalTo(self.contentView);
        }];
//        pic.image = [UIImage imageNamed:@"背景"];
    }
    return self;
}

- (void)setGraphicVerifyCodeUrlInfoinfo:(graphicVerifyCodeUrlInfo *)graphicVerifyCodeUrlInfoinfo{
    _graphicVerifyCodeUrlInfoinfo = graphicVerifyCodeUrlInfoinfo;
    [self.pic sd_setImageWithURL:graphicVerifyCodeUrlInfoinfo.graphicVerifyCodeUrl placeholderImage:[UIImage imageNamed:SD_HEAD_ALTERNATIVE_PICTURES]];
}
@end
