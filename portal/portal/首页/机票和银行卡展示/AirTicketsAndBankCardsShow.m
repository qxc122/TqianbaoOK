//
//  AirTicketsAndBankCardsShow.m
//  portal
//
//  Created by Store on 2017/10/11.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AirTicketsAndBankCardsShow.h"
#import "BankCardDisplay.h"
#import "TicketDisplay.h"
#import "KTPageControl.h"

@interface AirTicketsAndBankCardsShow ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) KTPageControl *page;
@property (nonatomic,strong) NSMutableArray *resArry;

@property (nonatomic,strong) UIColor *currentColor;
@property (nonatomic,strong) UIColor *nomalColor;
@end



@implementation AirTicketsAndBankCardsShow
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nomalColor = ColorWithHex(0xFFFFFF, 0.5);
        self.currentColor = ColorWithHex(0xFFFFFF, 1.0);
        [self.blcak setBackgroundImage:[ColorWithHex(0x000000, 0.8) imageWithColor] forState:UIControlStateNormal];
        self.resArry = [NSMutableArray array];
        self.back.hidden = YES;
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
        self.collectionView = collectionView;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[BankCardDisplay class] forCellWithReuseIdentifier:NSStringFromClass([BankCardDisplay class])];
        [collectionView registerClass:[TicketDisplay class] forCellWithReuseIdentifier:NSStringFromClass([TicketDisplay class])];
        
        [self addSubview:collectionView];
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [self bringSubviewToFront:self.close];
    }
    return self;
}

-(KTPageControl *)page{
    if (!_page) {
//        KTPageControl * page = [[KTPageControl alloc] initWithFrame:CGRectMake(0, 47*PROPORTION_HEIGHT-12, SCREENWIDTH*0.5, 15)];
        KTPageControl * page = [[KTPageControl alloc] initWithFrame:CGRectMake(0, 47*PROPORTION_HEIGHT-12, 0, 15)];
        page.backgroundColor = [UIColor clearColor];
        //        page.backgroundColor = [UIColor redColor];
        page.pageIndicatorTintColor =self.nomalColor;
        page.currentPageIndicatorTintColor = self.currentColor;
        
        page.currentPage = 0;
        page.defersCurrentPageDisplay = YES;
        page.pageSize = CGSizeMake(15, 15);
        [self addSubview:page];
        self.page  =page;
        CGFloat tmp = 47*PROPORTION_HEIGHT-12;
        if (IPoneX) {
            tmp += 22;
        }
        [page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(tmp);
            make.height.equalTo(@15);
        }];
    }
    return _page;
}

//- (void)windosViewshow{
//    [super windosViewshow];
//    if (self.indexx != 0) {
//        self.page.currentPage = self.indexx;
//        [self.collectionView setContentOffset:CGPointMake(self.indexx*SCREENWIDTH, 0)];
//    }
//}
- (void)setIndexx:(NSInteger)indexx{
    _indexx = indexx;
    [self performSelector:@selector(scrollToItemAtIndexPath) withObject:nil afterDelay:0.02f];
}
- (void)scrollToItemAtIndexPath{
    if (self.indexx != 0) {
        self.page.currentPage = self.indexx;
        [self.collectionView setContentOffset:CGPointMake(self.indexx*SCREENWIDTH, 0)];
    }
}
#pragma mark--<点击了cell>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma mark----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.userData.Arry_list.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    bankCard *tmp = self.userData.Arry_list[indexPath.row];
    if ([tmp.type isEqualToString:HOME_TYPE_BANK]) {
        BankCardDisplay *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BankCardDisplay class]) forIndexPath:indexPath];
        cell.bankCardOne = tmp;
        return cell;
    } else {//
        TicketDisplay *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TicketDisplay class]) forIndexPath:indexPath];

        kWeakSelf(self);
        cell.loadSucces = ^(AirInfo *data,NSInteger indexx,bankCard *atuData) {
            NSInteger index = 0;
            for (bankCard *tmp in weakself.userData.Arry_list) {
                if ([atuData.airName isEqualToString:tmp.airName] &&
                    [atuData.arrCityCode isEqualToString:tmp.arrCityCode] &&
                    [atuData.arrCityName isEqualToString:tmp.arrCityName] &&
                    [atuData.arrTime isEqualToString:tmp.arrTime] &&
                    [atuData.depCityCode isEqualToString:tmp.depCityCode] &&
                    [atuData.depCityName isEqualToString:tmp.depCityName] &&
                    [atuData.depDate isEqualToString:tmp.depDate] &&
                    [atuData.depTime isEqualToString:tmp.depTime] &&
                    [atuData.duration isEqualToString:tmp.duration] &&
                    [atuData.flightNo isEqualToString:tmp.flightNo] &&
                    [atuData.passengerName isEqualToString:tmp.passengerName] &&
                    [atuData.ticketNo isEqualToString:tmp.ticketNo]) {
                    [weakself.resArry replaceObjectAtIndex:index withObject:data];
                    NSLog(@"weakcell.indexx=%ld \n\n\n\n\n\n\n\n\n\n  wwww",index);
                    break;
                }
                index++;
            }
            NSLog(@"sdf");
        };
        cell.indexx = indexPath.row;
        cell.AirInfoOne = self.resArry[indexPath.row];
        cell.bankCardOne = tmp;
        return cell;
    }
}
- (void)setUserData:(UserInfoDeatil *)userData{
    _userData = userData;
    self.page.numberOfPages = userData.Arry_list.count;
    self.resArry = [NSMutableArray array];
    
//    bankCard *bankCardOne = userData.Arry_list.lastObject;
//    kWeakSelf(self);
//    [[ToolRequest sharedInstance]URLBASIC_flightqueryGssFlightDynamicWithdepDate:bankCardOne.depDate flightNo:bankCardOne.flightNo depTime:bankCardOne.depTime arrTime:bankCardOne.arrTime success:^(id dataDict, NSString *msg, NSInteger code) {
//        AirInfo *data = [AirInfo mj_objectWithKeyValues:dataDict];
//#ifdef DEBUG
//        NSString *strTmp = [dataDict DicToJsonstr];
//        NSLog(@"strTmp=%@",strTmp);
//#endif
//    } failure:^(NSInteger errorCode, NSString *msg) {
//        NSLog(@"msg=%@",msg);
//
//    }];
    
    for (bankCard *tmp in userData.Arry_list) {
        [self.resArry addObject:@"-"];
//        kWeakSelf(self);
//        [[ToolRequest sharedInstance]URLBASIC_flightqueryGssFlightDynamicWithdepDate:tmp.depDate flightNo:tmp.flightNo depTime:tmp.depTime arrTime:tmp.arrTime success:^(id dataDict, NSString *msg, NSInteger code) {
//            AirInfo *data = [AirInfo mj_objectWithKeyValues:dataDict];
//            //                weakcell.AirInfoOne = data;
////            [weakself.resArry replaceObjectAtIndex:weakcell.indexx withObject:data];
//            [weakself.collectionView reloadData];
//#ifdef DEBUG
//            NSString *strTmp = [dataDict DicToJsonstr];
//            NSLog(@"strTmp=%@",strTmp);
//#endif
//        } failure:^(NSInteger errorCode, NSString *msg) {
//            NSLog(@"msg=%@",msg);
//
//        }];
    }

}
#pragma mark----UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREENWIDTH,SCREENHEIGHT);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int cuttentIndex = (int)(scrollView.contentOffset.x + SCREENWIDTH/2)/SCREENWIDTH;
    self.page.currentPage = cuttentIndex;
}
//#pragma mark - KVO监测值的变化
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"currentColor"]) {
//        self.page.currentPageIndicatorTintColor = self.currentColor;
//    }
//    if ([keyPath isEqualToString:@"nomalColor"]) {
//        self.page.pageIndicatorTintColor = self.nomalColor;
//    }
//}
@end
