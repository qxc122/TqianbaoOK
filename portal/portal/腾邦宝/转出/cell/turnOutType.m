//
//  turnOutType.m
//  portal
//
//  Created by Store on 2018/1/26.
//  Copyright © 2018年 qxc122@126.com. All rights reserved.
//

#import "turnOutType.h"



@interface turnOutType ()
@property (nonatomic,weak) UILabel *title;

@property (nonatomic,weak) UIImageView *type1;
@property (nonatomic,weak) UILabel *title1;
@property (nonatomic,weak) UILabel *des1;
@property (nonatomic,weak) UIButton *btn1;

@property (nonatomic,weak) UIView *line;

@property (nonatomic,weak) UIImageView *type2;
@property (nonatomic,weak) UILabel *title2;
@property (nonatomic,weak) UILabel *des2;
@property (nonatomic,weak) UIButton *btn2;
@end

@implementation turnOutType
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    turnOutType *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.backgroundColor = [UIColor whiteColor];
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"转出方式";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
            label.textColor = [UIColor colorWithRed:71/255.0 green:84/255.0 blue:104/255.0 alpha:1/1.0];
            self.title = label;
            [self.contentView addSubview:label];
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20);
                make.top.equalTo(self.contentView).offset(20);
            }];
        }
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"为选中状态.png"];
            imageView.highlightedImage = [UIImage imageNamed:@"选中状态.png"];
            self.type1 = imageView;
            [self.contentView addSubview:imageView];
            [self.type1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.title);
                make.top.equalTo(self.title.mas_bottom).offset(20);
                make.width.equalTo(@15);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"快速到账";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
            label.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
            self.title1 = label;
            [self.contentView addSubview:label];
            [self.title1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.type1.mas_right).offset(15);
                make.top.equalTo(self.type1);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"预计2小时内到账";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:133/255.0 green:142/255.0 blue:155/255.0 alpha:1/1.0];
            self.des1 = label;
            [self.contentView addSubview:label];
            [self.des1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.title1);
                make.right.equalTo(self.contentView).offset(-20);
                make.top.equalTo(self.title1.mas_bottom).offset(10);
            }];
        }
        {
            UIButton *label = [[UIButton alloc] init];
            self.btn1 = label;
            [self.contentView addSubview:label];
            [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.type1);
                make.top.equalTo(self.type1);
                make.right.equalTo(self.des1);
                make.bottom.equalTo(self.des1);
            }];
            [label addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = ColorWithHex(0xE9EBEE, 1.0);
            self.line = view;
            [self.contentView addSubview:view];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.type1);
                make.right.equalTo(self.contentView).offset(-20);
                make.top.equalTo(self.des1.mas_bottom).offset(20);
                make.height.equalTo(@0.5);
            }];
        }
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"为选中状态.png"];
            imageView.highlightedImage = [UIImage imageNamed:@"选中状态.png"];
            self.type2 = imageView;
            [self.contentView addSubview:imageView];
            [self.type2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.title);
                make.top.equalTo(self.line.mas_bottom).offset(20);
                make.width.equalTo(@15);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"普通到账";
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
            label.textColor = [UIColor colorWithRed:58/255.0 green:69/255.0 blue:84/255.0 alpha:1/1.0];
            self.title2 = label;
            [self.contentView addSubview:label];
            [self.title2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.type2.mas_right).offset(15);
                make.top.equalTo(self.type2);
                make.height.equalTo(@15);
            }];
        }
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"预计11月28日(1天后) 23:59前到账，无限额，11月27日仍有收益";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            label.textColor = [UIColor colorWithRed:133/255.0 green:142/255.0 blue:155/255.0 alpha:1/1.0];
            self.des2 = label;
            [self.contentView addSubview:label];
            [self.des2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.title2);
                make.right.equalTo(self.contentView).offset(-20);
                make.top.equalTo(self.title2.mas_bottom).offset(10);
                make.bottom.equalTo(self.contentView);
            }];
        }
        {
            UIButton *label = [[UIButton alloc] init];
            self.btn2 = label;
            [self.contentView addSubview:label];
            [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.type2);
                make.top.equalTo(self.type2);
                make.right.equalTo(self.des2);
                make.bottom.equalTo(self.des2);
            }];
            [label addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        self.btn1.accessibilityIdentifier = @"1";
        self.btn2.accessibilityIdentifier = @"0";
        self.des1.numberOfLines = 0;
        self.des2.numberOfLines = 0;
    }
    return self;
}
-(void)typeClick:(UIButton *)btn{
    if (self.typeClicks) {
        self.typeClicks(btn.accessibilityIdentifier);
    }
    if ([self.btn1.accessibilityIdentifier isEqualToString:btn.accessibilityIdentifier]) {
        self.type1.highlighted = YES;
        self.type2.highlighted = NO;
    } else if ([self.btn2.accessibilityIdentifier isEqualToString:btn.accessibilityIdentifier]) {
        self.type1.highlighted = NO;
        self.type2.highlighted = YES;
    }
}
- (void)setOuttype:(NSString *)Outtype{
    _Outtype = Outtype;
    if ([self.btn1.accessibilityIdentifier isEqualToString:Outtype]) {
        self.type1.highlighted = YES;
        self.type2.highlighted = NO;
    } else if ([self.btn2.accessibilityIdentifier isEqualToString:Outtype]) {
        self.type1.highlighted = NO;
        self.type2.highlighted = YES;
    }
}

- (void)setPayMethodData:(tpTreasurequeryPayMethod *)PayMethodData{
    _PayMethodData = PayMethodData;
//    self.title1.text = PayMethodData.fastTranOutDesc;
//        self.title2.text = PayMethodData.tranOutDesc;
    
    NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
    NSAttributedString *title = [PayMethodData.fastTranOutDesc CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x1E2E47, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    [all appendAttributedString:title];
    NSAttributedString *title2 = [PayMethodData.fastTranOutRedDesc CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];

    [all replaceCharactersInRange:[PayMethodData.fastTranOutDesc rangeOfString:PayMethodData.fastTranOutRedDesc] withAttributedString:title2];
    self.des1.attributedText = all;
    
    {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [PayMethodData.tranOutDesc CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x1E2E47, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        NSAttributedString *title2 = [PayMethodData.tranOutRedDesc CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xF4333C, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        
        [all replaceCharactersInRange:[PayMethodData.tranOutDesc rangeOfString:PayMethodData.tranOutRedDesc] withAttributedString:title2];
        self.des2.attributedText = all;
    }

}
@end
