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

#import <Foundation/Foundation.h>
#import "EaseUI.h"
#import <HyphenateLite/HyphenateLite.h>
#define DEMO_CALL 0
#import "ChatViewController.h"
//#import "ContactListViewController.h"
//#import "MainViewController.h"
#import "mainTableVc.h"

#define kHaveUnreadAtMessage    @"kHaveAtMessage"
#define kAtYouMessage           1
#define kAtAllMessage           2

@interface ChatDemoHelper : NSObject <EMClientDelegate,EMChatManagerDelegate,EMContactManagerDelegate,EMGroupManagerDelegate,EMChatroomManagerDelegate>

//@property (nonatomic, weak) ContactListViewController *contactViewVC;

//@property (nonatomic, weak) ConversationListController *conversationListVC;

@property (nonatomic, weak) mainTableVc *mainVC; //主控制器

@property (nonatomic, weak) ChatViewController *chatVC;

+ (instancetype)shareHelper;

- (void)asyncPushOptions;

- (void)asyncGroupFromServer;

- (void)asyncConversationFromDB;

@end
