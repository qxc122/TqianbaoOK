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

#import "ChatViewController.h"
#import "IQKeyboardManager.h"
#import "HeaderAll.h"
//#import "UIImage+Resource.h"
#import "PortalHelper.h"
#import "EaseMessageReadManager.h"
#import "MWPhotoBrowser.h"

//#import "ChatGroupDetailViewController.h"
//#import "ChatroomDetailViewController.h"
//#import "UserProfileViewController.h"
//#import "UserProfileManager.h"
//#import "ContactListSelectViewController.h"
#import "ChatDemoHelper.h"
//#import "EMChooseViewController.h"
//#import "ContactSelectionViewController.h"
#import "EaseBubbleView+Voice.h"


#define maxBuleView  (SCREENWIDTH-2*(48+15))   //气泡的最大宽度
#define leftPading  15.f
#define rightPading  21.f
#define CancelDelete      //定义了就是取消

@interface ChatViewController ()<UIAlertViewDelegate,EMClientDelegate,MWPhotoBrowserDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    UIMenuItem *_transpondMenuItem;
}

@property (nonatomic) BOOL isPlayingAudio;

@property (nonatomic) NSMutableDictionary *emotionDic;
@property (nonatomic, copy) EaseSelectAtTargetCallback selectedCallback;

//@property (nonatomic, weak) moreChaat *allPeo;

@property (nonatomic, weak) UIView *showInView; //记住 菜单栏 的父控件

@property (nonatomic, strong) NSMutableArray *muArry; //查看照片用到的
@end

@implementation ChatViewController
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    return self;
//}
- (void)viewDidLoad {
    UIView *backcc = [UIView new];
    [self.view addSubview:backcc];
    [backcc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [super viewDidLoad];

    self.muArry = [NSMutableArray array];
//    self.messageTimeIntervalTag = 60*5;
//    self.hidesBottomBarWhenPushed = YES;
    
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
//    self.timeCellHeight = 0; //不要时间
    [self _setupBarButtonItem];
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAllMessages:) name:KNOTIFICATIONNAME_DELETEALLMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:@"ExitGroup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage:) name:@"insertCallMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callControllerClose" object:nil];

//    if (self.conversation.type != EMConversationTypeChat) {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(MorepersonalinformationHeadNoticeFunc:)
//                                                     name:MorepersonalinformationNikNameNotice
//                                                   object:nil];
//    }

    self.hidesBottomBarWhenPushed  = YES;
    [self setImageForMsg];
    
    [self.chatBarMoreView removeItematIndex:1];
    [self.chatBarMoreView updateItemWithImage:[UIImage imageNamed:@"图像"] highlightedImage:[UIImage imageNamed:@"图像"] title:@"相册" atIndex:0];
    [self.chatBarMoreView updateItemWithImage:[UIImage imageNamed:@"相机"] highlightedImage:[UIImage imageNamed:@"相机"] title:@"拍照" atIndex:1];
    if (self.conversation.type == EMConversationTypeGroupChat) {

    }else if (self.conversation.type == EMConversationTypeChat){
        [self.chatBarMoreView removeItematIndex:3];
        [self.chatBarMoreView removeItematIndex:2];
    }
    
    
    
//    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:[EaseMessageReadManager defaultManager]];
//    photoBrowser.displayActionButton = NO;
//    photoBrowser.displayNavArrows = NO;
//    photoBrowser.displaySelectionButtons = NO;
//    photoBrowser.alwaysShowControls = NO;
//    photoBrowser.wantsFullScreenLayout = YES;
//    photoBrowser.zoomPhotosToFill = YES;
//    photoBrowser.enableGrid = NO;
//    photoBrowser.startOnGrid = NO;
//    [photoBrowser setCurrentPhotoIndex:0];
    
//    EaseMessageReadManager *tmp = [EaseMessageReadManager defaultManager];
//    tmp.photoBrowser = photoBrowser;
    
    
    [self customBackButton];
    [self customNavigationBar];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    [IQKeyboardManager sharedManager].enable = NO;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 70.f;
}

- (void)customNavigationBar
{
    // 1.2设置所有导航条的标题颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = PingFangSC_Medium(17);
    md[NSForegroundColorAttributeName] = COLOUR_TITLE_NORMAL;
    [navBar setTitleTextAttributes:md];
}
- (void)customBackButton
{
    UIImage* image = [[UIImage imageNamed:PIC_CUSTOM_NAVIGATION_BACK_KING] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma --mark<设置聊天背景图片等>
- (void)setImageForMsg{
//    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"发送Msg"]  stretchableImageWithLeftCapWidth:5 topCapHeight:25]];//设置发送气泡
//
//    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"接收Msg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25]];//设置接收气泡
    
//    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
//    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
//
//    [[EaseBaseMessageCell appearance] setStatusSize:18.f];
//    [[EaseBaseMessageCell appearance] setActivitySize:18.f];
//    [[EaseBaseMessageCell appearance] setBubbleMaxWidth:maxBuleView];
    
//    [[EaseBaseMessageCell appearance] setBubbleMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [[EaseBaseMessageCell appearance] setLeftBubbleMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [[EaseBaseMessageCell appearance] setRightBubbleMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
    
//    [[EaseMessageCell appearance] setMessageVoiceDurationFont:PingFangSC_Regular(14)];//语音消息显示字体
//    [[EaseMessageCell appearance] setMessageVoiceDurationColor:ColorWithHex(0x000000, 0.87)];//语音消息显示颜色
    
//    [[EaseBaseMessageCell appearance] setMessageNameHeight:12];
//    [[EaseBaseMessageCell appearance] setMessageNameFont:PingFangSC_Regular(12)];//昵称显示字体
//    [[EaseBaseMessageCell appearance] setMessageNameColor:ColorWithHex(0x000000, 0.3)];//昵称显示颜色
    
//    [[EaseMessageCell appearance] setMessageTextFont:PingFangSC_Regular(14)];//消息显示字体
//    [[EaseMessageCell appearance] setMessageTextColor:ColorWithHex(0x000000, 0.87)];//消息显示颜色
    
//    [[EaseBaseMessageCell appearance] setRecvMessageVoiceAnimationImages:@[[UIImage imageNamed:@"03"], [UIImage imageNamed:@"03"], [UIImage imageNamed:@"02"], [UIImage imageNamed:@"01"]]];
//    [[EaseBaseMessageCell appearance] setSendMessageVoiceAnimationImages:@[[UIImage imageNamed:@"语音图标03"],[UIImage imageNamed:@"语音图标03"], [UIImage imageNamed:@"语音图标02"], [UIImage imageNamed:@"语音图标01"]]];
}

#pragma --mark<递归底部工具栏 改变 图片 >
-(void)findSubView:(UIView*)view
{
    for (UIButton* subView in view.subviews)
    {
        if ([subView isKindOfClass:[UIButton class]]) {
            if ([subView.accessibilityIdentifier isEqualToString:@"face"]) {
                [subView setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
                [subView setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateHighlighted];
//                [subView setImage:[UIImage imageNamed:@"按键"] forState:UIControlStateSelected];
            } else if ([subView.accessibilityIdentifier isEqualToString:@"record"]) {
//                [subView setBackgroundImage:[[UIImage imageNamed:@"1"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//                [subView setBackgroundImage:[[UIImage imageNamed:@"1"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
            }else if ([subView.accessibilityIdentifier isEqualToString:@"more"]) {
                [subView setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
                [subView setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateHighlighted];
//                [subView setImage:[UIImage imageNamed:@"按键"] forState:UIControlStateSelected];
            }else if ([subView.accessibilityIdentifier isEqualToString:@"style"]) {
                [subView setImage:[UIImage imageNamed:@"语音输入"] forState:UIControlStateNormal];
                [subView setImage:[UIImage imageNamed:@"语音输入"] forState:UIControlStateHighlighted];
//                [subView setImage:[UIImage imageNamed:@"按键"] forState:UIControlStateSelected];
            }

        }else if ([subView isKindOfClass:[EaseTextView class]]){
            EaseTextView *tmp = (EaseTextView *)subView;
            tmp.placeHolder = NSLocalizedString(@"请输入文字",);
//             tmp.placeHolder = @"请输入文字"; sdfa  NSLocalizedString
        }
        [self findSubView:subView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    if (self.conversation.type == EMConversationTypeChatRoom)
    {
        //退出聊天室，删除会话
        if (self.isJoinedChatroom) {
            NSString *chatter = [self.conversation.conversationId copy];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                [[EMClient sharedClient].roomManager leaveChatroom:chatter error:&error];
                if (error !=nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Leave chatroom '%@' failed [%@]", chatter, error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                    });
                }
            });
        }
        else {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:YES completion:nil];
        }
    }
    
    [[EMClient sharedClient] removeDelegate:self];
}
#pragma --mark<创建了cell>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    EaseMessageModel * model = (EaseMessageModel *)object;
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([object isKindOfClass:[EaseMessageModel class]]) {
        if ([cell isKindOfClass:[EaseBaseMessageCell class]]) {
            EaseBaseMessageCell *cellT = (EaseBaseMessageCell *)cell;
            cellT.hasRead.hidden = YES;
//            if (model.isSender) {
//                UILabel *tmp;
//                for (UILabel *tmpOK in cellT.nameLabel.subviews) {
//                    if ([tmpOK isKindOfClass:[UILabel class]]) {
//                        tmp = tmpOK;
//                        break;
//                    }
//                }
//                if (!tmp) {
//                    tmp = [UILabel new];
//                    tmp.font = PingFangSC_Regular(14);
//                    tmp.textColor = ColorWithHex(0x000000, 0.3);
//                    tmp.backgroundColor = [UIColor redColor];
//                    [cellT.nameLabel addSubview:tmp];
//                    [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.right.equalTo(cellT.nameLabel);
//                        make.height.equalTo(@12);
//                        make.width.equalTo(@50);
//                        make.top.equalTo(cellT.nameLabel);
//                    }];
//                }
//                tmp.text = cellT.nameLabel.text;
//            }
            if (model.firstMessageBody.type == EMMessageBodyTypeText) {
                [cellT setLeftBubbleMargin:UIEdgeInsetsMake(10, rightPading, 10, leftPading)];
                [cellT setRightBubbleMargin:UIEdgeInsetsMake(10, leftPading, 10, rightPading)];
                
                EMTextMessageBody *Body = (EMTextMessageBody *)model.message.body;
                CGFloat textWidth = [Body.text WidthWithFont:PingFangSC_Regular(14) withMaxHeight:CGFLOAT_MAX];
//                if (textWidth > (maxBuleView-15-6-15) || [Body.text rangeOfString:@"\r"].location != NSNotFound  || [Body.text rangeOfString:@"\n"].location != NSNotFound) {
//                    cellT.bubbleView.textLabel.textAlignment = NSTextAlignmentLeft;
//                }else{
//                    cellT.bubbleView.textLabel.textAlignment = NSTextAlignmentCenter;
//                }

                if ([object isKindOfClass:[EaseMessageModel class]]) {
                    cellT.bubbleView.textLabel.font = PingFangSC_Regular(14);
                    if (model.isSender) { //发送者
                        [cellT setMessageTextColor:ColorWithHex(0x000000, 0.87)];
                    } else {
                        [cellT setMessageTextColor:ColorWithHex(0x000000, 0.87)];
                    }
                }
//                cellT.bubbleView.textLabel.backgroundColor = [UIColor redColor];
            } else if (model.firstMessageBody.type == EMMessageBodyTypeImage || model.firstMessageBody.type == EMMessageBodyTypeVideo){
                if (model.firstMessageBody.type == EMMessageBodyTypeImage) {
                    cellT.bubbleView.imageView.layer.cornerRadius = 2.0;
                    cellT.bubbleView.imageView.layer.masksToBounds = YES;
                } else {
                    cellT.bubbleView.videoTagView.image = ImageNamed(@"摄像");
                    EMVideoMessageBody *videoBody = (EMVideoMessageBody*)model.message.body;
                    UILabel *timeOk;
                    for (UILabel *time in cellT.bubbleView.videoImageView.subviews) {
                        if ([time isKindOfClass:[UILabel class]] && [time.restorationIdentifier isEqualToString:@"qxctime"]) {
                            timeOk = time;
                            break;
                        }
                    }
                    if (!timeOk) {
                        timeOk = [UILabel new];
                        timeOk.restorationIdentifier = @"qxctime";
                        timeOk.font = PingFangSC_Regular(12);
                        [cellT.bubbleView.videoImageView addSubview:timeOk];
                        [timeOk mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(cellT.bubbleView.videoImageView).offset(-12);
                            make.bottom.equalTo(cellT.bubbleView.videoImageView).offset(-2);
                        }];
                    }
                    if (model.isSender) { //发送者
                        timeOk.textColor = ColorWithHex(0x000000, 0.87);
                    } else {
                        timeOk.textColor = ColorWithHex(0x000000, 0.87);
                    }
                    
                    timeOk.text = [self FormatTime:videoBody.duration];
                    cellT.bubbleView.videoImageView.layer.cornerRadius = 2.0;
                    cellT.bubbleView.videoImageView.layer.masksToBounds = YES;
                }
                [cellT setLeftBubbleMargin:UIEdgeInsetsMake(2, 6+2, 2, 2)];
                [cellT setRightBubbleMargin:UIEdgeInsetsMake(2, 2, 2, 6+2)];
            } else if (model.firstMessageBody.type == EMMessageBodyTypeVoice){
                cellT.bubbleView.isReadView.backgroundColor = RGBACOLOR(255, 107, 78, 1.0);
                if ([object isKindOfClass:[EaseMessageModel class]]) {
                    cellT.bubbleView.voiceDurationLabel.font = PingFangSC_Regular(14);
                    if (model.isSender) { //发送者
                        cellT.bubbleView.voiceImageView.image = [UIImage imageNamed:@"语音图标03"];
                        [cellT setMessageVoiceDurationColor:ColorWithHex(0x000000, 0.87)];
                        [cellT.bubbleView updateVoiceMargin:UIEdgeInsetsMake(10, 10, 10, 21)];
                    } else {
                        cellT.bubbleView.voiceImageView.image = [UIImage imageNamed:@"03"];
                        [cellT setMessageVoiceDurationColor:ColorWithHex(0x000000, 0.87)];
                        [cellT.bubbleView updateVoiceMargin:UIEdgeInsetsMake(10, 21, 10, 10)];
                    }
                }
            }
            
            [cellT.statusButton setImage:[UIImage imageNamed:@"发送失败"] forState:UIControlStateNormal];
        }
    }
    return cell;
}
- (NSString *)FormatTime:(int)time{
    NSString *timeStr;
    if (time>60) {
        timeStr = [NSString stringWithFormat:@"%d:%d",time/60,time%60];
        //        timeStr = [NSString stringWithFormat:@"%d,%d''",time/60,time%60];
    }else{
        timeStr = [NSString stringWithFormat:@"%d",time];
        //        timeStr = [NSString stringWithFormat:@"%d''",time];
    }
    return timeStr;
}
/*
- (UITableViewCell *)messageViewController:(UITableView *)tableView
                       cellForMessageModel:(id<IMessageModel>)messageModel{
    NSString *CellIdentifier = [CusEaseBaseMessageCell cellIdentifierWithModel:messageModel];
    
    CusEaseBaseMessageCell *sendCell = (CusEaseBaseMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (sendCell == nil) {
        sendCell = [[CusEaseBaseMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:messageModel];
        sendCell.selectionStyle = UITableViewCellSelectionStyleNone;
        sendCell.delegate = self;
    }
    
    sendCell.model = messageModel;
    return sendCell;
}
*/

#pragma --mark<计算cell的高度>
/*!
 @method
 @brief 获取消息cell高度
 @discussion 用户根据messageModel判断,是否自定义显示cell的高度
 @param viewController 当前消息视图
 @param messageModel 消息模型
 @param cellWidth 视图宽度
 @result 返回用户自定义cell
 */
- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth{
    
    CGFloat tmp=[EaseBaseMessageCell cellHeightWithModel:messageModel];
    if (messageModel.bodyType == EMMessageBodyTypeText) {
        EMTextMessageBody *Body = (EMTextMessageBody *)messageModel.message.body;
        CGFloat textWidth = [Body.text WidthWithFont:PingFangSC_Regular(14) withMaxHeight:CGFLOAT_MAX];
        tmp += 16.0;
        if (textWidth <= (maxBuleView-15-6-15)) {
            tmp -= 11;
        }else{
//            NSString = [Body.text stringByReplacingOccurrencesOfString:@"\r" withString:@"\n"];
            CGFloat textHeight = [Body.text HeightWithFont:PingFangSC_Regular(14) withMaxWidth:(maxBuleView-rightPading-leftPading)];
            tmp = textHeight+12+16+15+10+10+1;
            
            
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, maxBuleView-rightPading-leftPading, textHeight)];
//            [self.view addSubview:label];
//            label.font = PingFangSC_Regular(14);
//            label.backgroundColor = [UIColor greenColor];
//            label.numberOfLines = 0;
//            label.text = Body.text;
        }
    } else if (messageModel.bodyType == EMMessageBodyTypeVoice){
        tmp = 77;
    }else{
        tmp += 16.0;
    }
//    NSLog(@"cellWidth=%f",cellWidth);
//    NSLog(@"[EaseBaseMessageCell cellHeightWithModel:messageModel]+16=%f",tmp);
    return tmp;
}

- (void)sendTextMessage:(NSString *)text withExt:(NSDictionary*)ext
{
    if ([self.conversation.conversationId isEqualToString:@"kefu"]) {
        if (!ext) {
            ext = @{
                    //                @"visitor":@{
                    //                        @"trueName":[[PortalHelper sharedInstance]get_userInfo].userName,
                    //                        @"userNickname":[[PortalHelper sharedInstance]get_userInfo].nickname,
                    //                        @"description":[[PortalHelper sharedInstance]get_userInfo].fullMobile,
                    //                        },
                    @"weichat":@{
                            @"queueName":@"T钱包客服",
                            },
                    };
        }
    }
                                 
    [super sendTextMessage:text withExt:ext];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.scrollToBottomWhenAppear = NO;
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
//   [IQKeyboardManager sharedManager].enable  =NO;
    if (self.conversation.type == EMConversationTypeGroupChat) {
        NSDictionary *ext = self.conversation.ext;
        if ([[ext objectForKey:@"subject"] length])
        {
            self.title = [ext objectForKey:@"subject"];
        }
        
        if (ext && ext[kHaveUnreadAtMessage] != nil)
        {
            NSMutableDictionary *newExt = [ext mutableCopy];
            [newExt removeObjectForKey:kHaveUnreadAtMessage];
            self.conversation.ext = newExt;
        }
    }
    

    EaseChatToolbar *chatToolbar= (EaseChatToolbar *)self.chatToolbar;
    [self findSubView:chatToolbar];
}

#pragma mark - setup subviews

- (void)_setupBarButtonItem
{
    
    //UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    //backButton.accessibilityIdentifier = @"back";
    //[backButton setImage:[UIImage imageNamed:IMAGE_back] forState:UIControlStateNormal];
    //[backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:ImageNamed(@"返回金色") style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    backItem.accessibilityIdentifier = @"back";
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    //单聊
    if (self.conversation.type == EMConversationTypeChat) {
        self.title = @"客服";
    }
}
//#pragma --mark<获取群成员所有信息>
//- (void)loadGroupMeberInfo{
//    NSString *pathUserTmp = [NSString stringWithFormat:@"%@.data",self.conversation.conversationId];
//    NSString *pathUser = [PATH_OF_DOCUMENT stringByAppendingPathComponent:pathUserTmp];
//    membersGroupS *embersPeo = [NSKeyedUnarchiver unarchiveObjectWithFile:pathUser];
//    if (embersPeo) {
//        [self.tableView reloadData];
//        self.title = embersPeo.name;
//    }
//
//    kWeakSelf(self);
//    [[ToolRequest sharedInstance] appuseremchatmembersWithidd:self.conversation.conversationId NONEsuccess:^(id dataDict, NSString *msg, NSInteger code) {
//        weakself.embersPeo = [membersGroupS mj_objectWithKeyValues:dataDict];
//        membersGroupS *embersPe = [membersGroupS mj_objectWithKeyValues:dataDict];
//        weakself.embersPeo = embersPe;
//        [weakself.tableView reloadData];
//        weakself.title = embersPeo.name;
//    } failure:^(NSInteger errorCode, NSString *msg) {
//        XAlertView *aler =[[XAlertView alloc]initWithTitle:@"群成员加载失败" message:@"重新加载" clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
//            if (!canceled) {
//                [weakself loadGroupMeberInfo];
//            }
//        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [aler show];
//    }];
//}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        self.messageTimeIntervalTag = -1;
        [self.conversation deleteAllMessages:nil];
        [self.dataArray removeAllObjects];
        [self.messsagesSource removeAllObjects];
        
        [self.tableView reloadData];
    }
}

#pragma mark - EaseMessageViewControllerDelegate

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}

- (void)messageViewController:(EaseMessageViewController *)viewController
               selectAtTarget:(EaseSelectAtTargetCallback)selectedCallback
{
    _selectedCallback = selectedCallback;
    EMGroup *chatGroup = nil;
    NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
    for (EMGroup *group in groupArray) {
        if ([group.groupId isEqualToString:self.conversation.conversationId]) {
            chatGroup = group;
            break;
        }
    }
    
    if (chatGroup == nil) {
        chatGroup = [EMGroup groupWithId:self.conversation.conversationId];
    }
    
    if (chatGroup) {
        if (!chatGroup.occupants) {
            __weak ChatViewController* weakSelf = self;
            [self showHudInView:self.view hint:@"Fetching group members..."];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                EMGroup *group = [[EMClient sharedClient].groupManager fetchGroupInfo:chatGroup.groupId includeMembersList:YES error:&error];
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong ChatViewController *strongSelf = weakSelf;
                    if (strongSelf) {
                        [strongSelf hideHud];
                        if (error) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Fetching group members failed [%@]", error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        else {
                            NSMutableArray *members = [group.occupants mutableCopy];
                            NSString *loginUser = [EMClient sharedClient].currentUsername;
                            if (loginUser) {
                                [members removeObject:loginUser];
                            }
                            if (![members count]) {
                                if (strongSelf.selectedCallback) {
                                    strongSelf.selectedCallback(nil);
                                }
                                return;
                            }
//                            ContactSelectionViewController *selectController = [[ContactSelectionViewController alloc] initWithContacts:members];
//                            selectController.mulChoice = NO;
//                            selectController.delegate = self;
//                            [self.navigationController pushViewController:selectController animated:YES];
                        }
                    }
                });
            });
        }
        else {
            NSMutableArray *members = [chatGroup.occupants mutableCopy];
            NSString *loginUser = [EMClient sharedClient].currentUsername;
            if (loginUser) {
                [members removeObject:loginUser];
            }
            if (![members count]) {
                if (_selectedCallback) {
                    _selectedCallback(nil);
                }
                return;
            }
//            ContactSelectionViewController *selectController = [[ContactSelectionViewController alloc] initWithContacts:members];
//            selectController.mulChoice = NO;
//            selectController.delegate = self;
//            [self.navigationController pushViewController:selectController animated:YES];
        }
    }
}

#pragma mark - EaseMessageViewControllerDataSource

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
#pragma --mark<设置 头像>
    if (model.isSender) {
        if ([[PortalHelper sharedInstance]get_userInfo].headUrl) {
            model.avatarURLPath = [[[PortalHelper sharedInstance]get_userInfo].headUrl absoluteString];
        }else{
            model.avatarImage = [UIImage imageNamed:SD_HEAD_ALTERNATIVE_PICTURES];
        }
        model.nickname = [[PortalHelper sharedInstance]get_userInfo].nickname;
    }else{
        model.avatarImage = [UIImage imageNamed:@"客服头像"];
        model.nickname = @"客服";
    }
    model.failImageName = SD_HEAD_ALTERNATIVE_PICTURES;
    return model;
}
/*
- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    return @[managerDefault,managerGif];
}

- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
                                    messageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}

- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
                                      messageModel:(id<IMessageModel>)messageModel
{
    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
    if (emotion == nil) {
        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
    }
    return emotion;
}

- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
                                        easeEmotion:(EaseEmotion*)easeEmotion
{
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}
*/
- (void)messageViewControllerMarkAllMessagesAsRead:(EaseMessageViewController *)viewController
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
}

#pragma mark - EaseMob

#pragma mark - EMClientDelegate

- (void)userAccountDidLoginFromOtherDevice
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)userAccountDidRemoveFromServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)userDidForbidByServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

#pragma mark - action

- (void)backAction
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    [[ChatDemoHelper shareHelper] setChatVC:nil];
    
    if (self.deleteConversationIfNull) {
        //判断当前会话是否为空，若符合则删除该会话
        EMMessage *message = [self.conversation latestMessage];
        if (message == nil) {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:NO completion:nil];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma --mark<处理 点击的 更多  每个按钮>
- (void)hangcse:(moreChaat_ENMU)type{
    if (type == WXPYQ_moreChaat_ENMU || type == WXHY_moreChaat_ENMU) {
        if (self.embersPeo) {
            [self WXshare:type];
        }else{
            kWeakSelf(self);
            [MBProgressHUD showLoadingMessage:@"加载中..." toView:self.view];
            [[ToolRequest sharedInstance] appuseremchatmembersWithidd:self.conversation.conversationId NONEsuccess:^(id dataDict, NSString *msg, NSInteger code) {
                weakself.embersPeo = [membersGroupS mj_objectWithKeyValues:dataDict];
                //            if (type == WXPYQ_moreChaat_ENMU) {
                //
                //            } else if(type == WXHY_moreChaat_ENMU){
                //
                //            }
                [weakself WXshare:type];
                [MBProgressHUD hideHUDForView:weakself.view];
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view];
                XAlertView *aler =[[XAlertView alloc]initWithTitle:@"群成员加载失败" message:@"重新加载" clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
                    if (!canceled) {
                        [weakself hangcse:type];
                    }
                } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [aler show];
            }];
        }
    } else if (type == ALLPEO_moreChaat_ENMU){
        myContactsPeoples *vc =[[myContactsPeoples alloc]init];
        vc.embersPeo = self.embersPeo;
        vc.type = ALL_myContactsPeoples_ENMU;
        vc.oneIdd = self.conversation.conversationId;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (type == DELET_moreChaat_ENMU){
        kWeakSelf(self);
        XAlertView *alet = [[XAlertView alloc]initWithTitle:@"删除聊天记录" message:nil clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
            if (!canceled) {
                EMGroup *chatGroup = nil;
                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:weakself.conversation.conversationId]) {
                        chatGroup = group;
                        break;
                    }
                }
                if (chatGroup == nil) {
                    chatGroup = [EMGroup groupWithId:self.conversation.conversationId];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllMessages" object:chatGroup.groupId];
            }
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alet show];
    } else if (type == QUXIAO_moreChaat_ENMU){
        
    }
    [self.allPeo closeClisck];
}

#pragma --mark<微信分享>
- (void)WXshare:(moreChaat_ENMU)type{
    [[tourHelper sharedInstance]WXShareWithtitle:self.embersPeo.shareTitle description:self.embersPeo.shareContent  webpageUrl:self.embersPeo.shareUrl ThumbImage:nil  ThumbImage:self.embersPeo.shareImage scene:type];
}

#pragma --mark<处理 点击的 更多>
- (void)deleteAllMessages:(id)sender
{
    if (self.dataArray.count == 0) {
        [MBProgressHUD showPrompt:@"消息已经清空" toView:self.view];
//        [self showHint:@"消息已经清空"];
//        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *groupId = (NSString *)[(NSNotification *)sender object];
        BOOL isDelete = [groupId isEqualToString:self.conversation.conversationId];
        if (self.conversation.type != EMConversationTypeChat && isDelete) {
            self.messageTimeIntervalTag = -1;
            [self.conversation deleteAllMessages:nil];
            [self.messsagesSource removeAllObjects];
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
//            [self showHint:@"消息已清空"];
            [MBProgressHUD showPrompt:@"消息已清空" toView:self.view];
        }
    }
    else if ([sender isKindOfClass:[UIButton class]]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定删除聊天记录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}
*/
- (void)transpondMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
//        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
//        ContactListSelectViewController *listViewController = [[ContactListSelectViewController alloc] initWithNibName:nil bundle:nil];
//        listViewController.messageModel = model;
//        [listViewController tableViewDidTriggerHeaderRefresh];
//        [self.navigationController pushViewController:listViewController animated:YES];
    }
    self.menuIndexPath = nil;
}

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation deleteMessageWithId:model.message.messageId error:nil];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        if ([self.dataArray count] == 0) {
            self.messageTimeIntervalTag = -1;
        }
    }
    
    self.menuIndexPath = nil;
}

#pragma mark - notification
- (void)exitGroup
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCallMessage:(NSNotification *)notification
{
    id object = notification.object;
    if (object) {
        EMMessage *message = (EMMessage *)object;
        [self addMessageToDataSource:message progress:nil];
        [[EMClient sharedClient].chatManager importMessages:@[message] completion:nil];
    }
}

- (void)handleCallNotification:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        //开始call
        self.isViewDidAppear = NO;
    } else {
        //结束call
        self.isViewDidAppear = YES;
    }
}

#pragma mark - private

- (void)showMenuViewController:(UIView *)showInView
                   andIndexPath:(NSIndexPath *)indexPath
                    messageType:(EMMessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"delete", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"copy", @"Copy") action:@selector(copyMenuAction:)];
    }
    
//    if (_transpondMenuItem == nil) {
//        _transpondMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"transpond", @"Transpond") action:@selector(transpondMenuAction:)];
//    }
    
    if (messageType == EMMessageBodyTypeText) {
        [self.menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    } else if (messageType == EMMessageBodyTypeImage){
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    } else {
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    }
    
//    if (messageType == EMMessageBodyTypeText) {
//        [self.menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem,_transpondMenuItem]];
//    } else if (messageType == EMMessageBodyTypeImage){
//        [self.menuController setMenuItems:@[_deleteMenuItem,_transpondMenuItem]];
//    } else {
//        [self.menuController setMenuItems:@[_deleteMenuItem]];
//    }
    self.showInView = showInView;
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
}

#pragma mark - EMChooseViewDelegate
//
//- (BOOL)viewController:(EMChooseViewController *)viewController didFinishSelectedSources:(NSArray *)selectedSources
//{
//    if ([selectedSources count]) {
//        EaseAtTarget *target = [[EaseAtTarget alloc] init];
//        target.userId = selectedSources.firstObject;
////        UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:target.userId];
////        if (profileEntity) {
////            target.nickname = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
////        }
//        
//        
//        target.nickname = @"名字";
//        if (_selectedCallback) {
//            _selectedCallback(target);
//        }
//    }
//    else {
//        if (_selectedCallback) {
//            _selectedCallback(nil);
//        }
//    }
//    return YES;
//}
//
//- (void)viewControllerDidSelectBack:(EMChooseViewController *)viewController
//{
//    if (_selectedCallback) {
//        _selectedCallback(nil);
//    }
//}

#pragma mark - public

- (NSArray *)formatMessages:(NSArray *)messages
{
    NSMutableArray *formattedArray = [[NSMutableArray alloc] init];
    if ([messages count] == 0) {
        return formattedArray;
    }
    
    for (EMMessage *message in messages) {
        //Calculate time interval
        CGFloat interval = (self.messageTimeIntervalTag - message.timestamp) / 1000;
        if (self.messageTimeIntervalTag < 0 || interval > 60*5 || interval < -60*5) {
            NSDate *messageDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            NSString *timeStr = @"";
            
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(messageViewController:stringForDate:)]) {
                timeStr = [self.dataSource messageViewController:self stringForDate:messageDate];
            }
            else{
                timeStr = [messageDate formattedTime];
            }
            [formattedArray addObject:timeStr];
            self.messageTimeIntervalTag = message.timestamp;
        }
        
        //Construct message model
        id<IMessageModel> model = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(messageViewController:modelForMessage:)]) {
            model = [self.dataSource messageViewController:self modelForMessage:message];
        }
        else{
            model = [[EaseMessageModel alloc] initWithMessage:message];
            model.avatarImage = [UIImage imageNamed:@"sdf"];
//            model.avatarImage = [UIImage easeImageNamed:@"EaseUIResource.bundle/user"];
//            model.avatarImage = [UIImage easeImageNamed:@"EaseUIResource.bundle/user"];
            model.failImageName = @"imageDownloadFail";
        }
        
        if (model) {
            [formattedArray addObject:model];
        }
    }
    
    return formattedArray;
}

//有新人加入群组是没有通知的，但是如果有新人发送加群申请是可以收到通知的，这个方法：
/*! @Method @brief 收到加入群组的申请 @param groupId 要加入的群组ID @param groupname 申请人的用户名 @param username 申请人的昵称 @param reason 申请理由 @discussion */
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId groupname:(NSString *)groupname applyUsername:(NSString *)username reason:(NSString *)reason error:(EMError *)error{
    NSLog(@"有人加群了啊");
}


#pragma --mark<SDCycleScrollViewDelegate  照片浏览器的回调   有多少个>
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return self.muArry.count;
}
#pragma --mark<SDCycleScrollViewDelegate  照片浏览器的回调  每个MWPhoto>
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    MWPhoto *oen;
    EaseMessageModel *tmp = self.muArry[index];
    if (tmp.bodyType == EMMessageBodyTypeImage) {
        EMImageMessageBody *Body = (EMImageMessageBody *)tmp.message.body;
        UIImage *tmpImage;
        if (Body.thumbnailDownloadStatus == EMDownloadStatusSuccessed && Body.downloadStatus == EMDownloadStatusSuccessed) {
            tmpImage = [UIImage imageWithContentsOfFile:tmp.message == nil ? tmp.fileLocalPath : [Body localPath]];
        }
        if (tmpImage) {
            oen = [MWPhoto photoWithImage:tmpImage];
        } else {
            oen = [MWPhoto photoWithURL:[NSURL URLWithString:Body.thumbnailRemotePath]];
        }
//        oen = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://s11.sinaimg.cn/bmiddle/4f0516b944cdb850877ca"]];
    }
    return oen;
}
- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
    return [NSString stringWithFormat:@"%lu/%ld",index+1,self.muArry.count];
}
#pragma <页面消失的时候移除 menuController 控件 比如点击头像 打开了个人主页>
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    if (self.menuController) {
        [self.menuController setMenuVisible:NO animated:YES];
    }
}
#pragma <UIScrollViewDelegate 滑动的时候移除 menuController 控件>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.menuController) {
        [self.menuController setMenuVisible:NO animated:YES];
    }
}
#pragma <重写父类方法  设置点击cell 中的 气泡 有效 而不是点击整个cell>
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan && [self.dataArray count] > 0)
    {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[EaseBaseMessageCell class]]) {
            EaseBaseMessageCell *MessageCell = (EaseBaseMessageCell *)cell;
            CGPoint point = [recognizer locationInView:MessageCell.bubbleView];
            if (point.x < 0 ||point.y < 0 || point.x >MessageCell.bubbleView.frame.size.width ||point.y > MessageCell.bubbleView.frame.size.height) {
                return;
            }
        }else{
            return;
        }
        
        BOOL canLongPress = NO;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(messageViewController:canLongPressRowAtIndexPath:)]) {
            canLongPress = [self.dataSource messageViewController:self
                                   canLongPressRowAtIndexPath:indexPath];
        }
        
        if (!canLongPress) {
            return;
        }
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(messageViewController:didLongPressRowAtIndexPath:)]) {
            [self.dataSource messageViewController:self
                    didLongPressRowAtIndexPath:indexPath];
        }
        else{
            id object = [self.dataArray objectAtIndex:indexPath.row];
            if (![object isKindOfClass:[NSString class]]) {
                EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                [cell becomeFirstResponder];
                self.menuIndexPath = indexPath;
                [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
            }
        }
    }
}

- (void)loadNewDataConversationListController{
    [self tableViewDidTriggerHeaderRefresh];
}
@end
