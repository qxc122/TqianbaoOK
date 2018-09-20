/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */
         
#import "EaseMessageViewController.h"


#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"

@interface ChatViewController : EaseMessageViewController <EaseMessageViewControllerDelegate,   EaseMessageViewControllerDataSource>


- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;
//
//@property (nonatomic,strong) membersGroupS *embersPeo;  //群组 成员
//
//
////@property (nonatomic,strong) NSMutableArray *groupsA;  //群成员  群聊
//
//@property (nonatomic,strong) UserS *UserOne;    //群成员  单聊
//
//
//@property (nonatomic,strong)Class classNmae; //要关闭的控制器
@end
