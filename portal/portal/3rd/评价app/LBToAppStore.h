//
//  LBToAppStore.h
//  TourismT
//
//  Created by Store on 2017/1/12.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LBToAppStore : NSObject
{

UIAlertController *alertController;


}

@property (nonatomic,strong) NSString * myAppID;//appID


-(void)alertUserCommentView:(UIViewController *)VC;
//- (void)showGotoAppStore:(UIViewController *)VC;
@end
