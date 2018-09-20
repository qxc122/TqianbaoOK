//
//  YHGesturePasswordView.m
//  手势密码
//
//  Created by mrlee on 2017/3/5.
//  Copyright © 2017年 mrlee. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "YHCustomButton.h"
#import "YHGesturePasswordView.h"
#import <CommonCrypto/CommonDigest.h>
#import "HeaderAll.h"
@interface YHGesturePasswordView(){
    /** 判断是当设置密码用，还是解锁密码用*/
    PasswordState Amode;
}
///错误时的图片
@property (nonatomic,strong)UIImage *normalImg;
/** 所有的按钮集合*/
@property (nonatomic,assign)BOOL isError;

/** 所有的按钮集合*/
@property (nonatomic,strong)NSMutableArray * allBtnsArray;

/** 解锁时手指经过的所有的btn集合*/
@property (nonatomic,strong)NSMutableArray * btnsArray;

/** 手指当前的触摸位置*/
@property (nonatomic,assign)CGPoint currentPoint;

@end

@implementation YHGesturePasswordView

-(instancetype)initWithFrame:(CGRect)frame WithNormalImg:(UIImage *)normalImg WithSelectedImg:(UIImage *)selectedImg WithState:(PasswordState)state{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        Amode = state;
        self.passWordLeng = 4;
        self.normalImg = normalImg;
        for (int i = 0; i<9; i++) {
            YHCustomButton *btn = [[YHCustomButton alloc]init];
            [btn setTag:i];
            [btn setImage:normalImg forState:UIControlStateNormal];
            [btn setImage:selectedImg forState:UIControlStateHighlighted];
            [btn setImage:selectedImg forState:UIControlStateSelected];
            
            btn.userInteractionEnabled = NO;
            [self addSubview:btn];
        }
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    //  每次调用这个方法的时候如果背景颜色是default会产生缓存，如果设置了颜色之后就没有缓存，绘制之前需要清除缓存
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);//清空上下文
    for (int i = 0; i<self.btnsArray.count; i++) {
        UIButton *btn = self.btnsArray[i];
        if (i == 0) {
            CGContextMoveToPoint(ctx, btn.center.x, btn.center.y);
        }else{
            CGContextAddLineToPoint(ctx, btn.center.x, btn.center.y);
        }
    }
    if (!CGPointEqualToPoint(self.currentPoint, CGPointZero)) {//如果起点不是CGPointZero的话才来划线
        CGContextAddLineToPoint(ctx, self.currentPoint.x, self.currentPoint.y);
    }
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    if (self.isError) {
        [self.lineColorError set];
    }else{
        [self.lineColor set];
    }
    CGContextStrokePath(ctx);
}
-(void)layoutSubviews{

     [self.allBtnsArray removeAllObjects];
    for (int index =0; index<self.subviews.count; index ++) {
        if ([self.subviews[index] isKindOfClass:[YHCustomButton class]]) {
           
            [self.allBtnsArray addObject:self.subviews[index]];
        }
    }
    // button 绘制九宫格
    [self drawUi];
    
    
}
#pragma mark Private method
-(void)drawUi{
    for (int index = 0; index<self.allBtnsArray.count; index ++) {
        //拿到每个btn
        UIButton *btn = self.subviews[index];
        //设置frame
        CGFloat btnW = 60*PROPORTION_HEIGHT;
        CGFloat btnH = 60*PROPORTION_HEIGHT;
        CGFloat margin = (self.frame.size.width - (btnW *3))/2;
        //x = 间距 + 列号*（间距+btnW）
        CGFloat btnX =(index % 3)*(margin + btnW);
        CGFloat btnY =(index / 3)*(margin + btnH);
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}
//设置密码
-(SetPwdState)pwdValue:(NSString *)str{
    if (self.pwdValue == nil)  {
        //第一次设置
        self.pwdValue = str;
        [self clear];
        return FristPwd;
    }
    if ([str isEqualToString:self.pwdValue]) {
        //设置成功
        [self showSucces];
        return SetPwdSuccess;
    }
    if (![str isEqualToString:self.pwdValue]) {
        //二次设置不一样
//        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pwdValue"];
        self.isError = YES;
        [self showError];
        return PwdNoValue;
    }
    return Other;
}

- (void)reset{
    self.isError = NO;
    for (int i = 0; i<self.btnsArray.count; i++) {
        UIButton *btn = self.btnsArray[i];
        [btn setImage:self.normalImg forState:UIControlStateNormal];
    }
    [self clear];
}
//清空
-(void)clear{
    for (int i = 0; i<self.btnsArray.count; i++) {
        UIButton *btn = self.btnsArray[i];
        btn.selected = NO;
    }
    [self.btnsArray removeAllObjects];
    self.currentPoint = CGPointZero;
    [self setNeedsDisplay];
    self.userInteractionEnabled = YES;
}
//获取触摸的点
-(CGPoint)getCurrentTouch:(NSSet<UITouch*> *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    return point;
}

-(UIButton *)getCurrentBtnWithPoint:(CGPoint) currentPoint{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, currentPoint)) {
            return btn;
        }
    }
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self getCurrentTouch:touches];
    UIButton *btn = [self getCurrentBtnWithPoint:point];
    if (btn && btn.selected != YES) {
        btn.selected = YES;
        [self.btnsArray addObject:btn];
        NSLog(@" array is value %@",self.btnsArray);
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint movePoint = [self getCurrentTouch:touches];
    UIButton *btn = [self getCurrentBtnWithPoint:movePoint];
    if (btn && btn.selected !=YES) {
        btn.selected = YES;
        [self.btnsArray addObject:btn];
        NSLog(@"btn is value %@",self.btnsArray);
        
        if (Amode == GestureSetPassword && self.times == 0) {
            NSMutableArray *result = [NSMutableArray array];
            for (UIButton *btn in self.btnsArray) {
                [result addObject:[NSNumber numberWithUnsignedInteger:btn.tag]];
            }
            if (result && result.count && self.sendReaultDataWhenMoved) {
                self.sendReaultDataWhenMoved(result);
            }
        }
    }
    
    self.currentPoint = movePoint;
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIButton *btn in self.btnsArray) {
        [btn setSelected:NO];
    }
    NSMutableString *result = [NSMutableString string];
    for (UIButton *btn in self.btnsArray) {
        [result appendString: [NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    self.times ++;
    switch (Amode) {
        case GestureSetPassword:{
            //设置手势密码
            //返回结果
            if (result.length < self.passWordLeng && self.times == 1) {
                self.times = 0;
                [self showError];
                self.setPwdBlock(WrongLength,nil);
            }else{
                self.setPwdBlock([self pwdValue:result],result);
            }
        }
            break;
        case GestureResultPassword :{
            //获取手势密码结果
            if (self.sendReaultData) {
                if (self.sendReaultData(result) == YES) {
                    NSLog(@"success");
                    [self showSucces];
                    self.isError = NO;
                }else{
                    self.isError = YES;
                    [self showError];
                    NSLog(@"手势有误");
                }
                
            }
        }
            break;
            
        default:
            break;
    }

}

-(void)showSucces{
    [self setNeedsDisplay];
    self.userInteractionEnabled = NO;
    for (int i = 0; i<self.btnsArray.count; i++) {
        UIButton *btn = self.btnsArray[i];
        btn.selected = YES;
    }
}
//显示错误
-(void)showError{
    [self setNeedsDisplay];
    self.userInteractionEnabled = NO;
    for (int i = 0; i<self.btnsArray.count; i++) {
        UIButton *btn = self.btnsArray[i];
        [btn setImage:self.btnSelectImageError forState:UIControlStateNormal];
//        [btn setBackgroundImage:self.btnSelectImageError forState:UIControlStateNormal];
    }
}


#pragma mark 延时加载
-(NSMutableArray *)btnsArray{
    if (_btnsArray == nil) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}
-(NSMutableArray *)allBtnsArray{
    if (_allBtnsArray == nil) {
        _allBtnsArray = [NSMutableArray array];
    }
    return _allBtnsArray;
}
- (UIColor *)lineColorError{
    if (_lineColorError == nil) {
        _lineColorError = [UIColor redColor];
    }
    return _lineColorError;
}
- (UIColor *)lineColor{
    if (_lineColor == nil) {
        _lineColor = [UIColor grayColor];
    }
    return _lineColor;
}
@end
