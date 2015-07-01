//
//  APIDefinition.h
//  LiveCourse
//
//  Created by junfengyang on 15/1/5.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#ifndef LiveCourse_APIDefinition_h
#define LiveCourse_APIDefinition_h

#pragma mark - API

#ifdef DEBUG
//#define kHskHostUrl @"http://api.hellohsk.com/hellohsk/"
#define kLifeHostUrl @"http://api.hellohsk.com/life_test/"

#define kHostUrl @"http://test.hschinese.com/app/api/"

//#define kApiHostUrl @"http://api.hschinese.com/hellohsk_test/"

#else

//#define kHskHostUrl @"http://api.hellohsk.com/hellohsk/"
#define kLifeHostUrl @"http://api.hellohsk.com/life/"

#define kHostUrl @"http://www.hschinese.com/app/api/"
//#define kApiHostUrl @"http://api.hschinese.com/hellohsk/"
#endif

// api的版本。
#define kAPIVersion 3

//------------>登录注册相关<------------------
#define kLoginMethod        @"user/login"
#define kRegistMethod       @"user/register"
#define kVipList            @"vip/list"
#define kVipBuy             @"vip/buy"

//----------->课程相关<----------------------
#define kCourseList         @"course/list"
#define kLessonList         @"lesson/list"
#define kLessonProgress     @"lesson/progress"
#define kLessonText         @"lesson/text"
#define kKnowledge          @"knowledge/list"

//----------->关卡相关<----------------------
#define kCheckPointList     @"checkpoint/list"
#define kCheckPointProgress @"checkpoint/progress"
#define kCheckPointVersion  @"checkpoint/version"
// 关卡与内容之间的关系。
#define kCheckPointRelation @"checkpoint/relation"
// 关卡的词汇数据
#define kCheckPointWord     @"checkpoint/word"
// 关卡的句子数据
#define kCheckPointSentence @"checkpoint/sentences"
// 关卡的课文数据
#define kCheckPointLesson   @"checkpoint/lesson"
// 关卡的知识点数据
#define kCheckPointKnowledge @"checkpoint/knowledge"
// 关卡的测试题
#define kCheckPointExam      @"checkpoint/exercise"

#define kDownloadFile      @"file/checkpoint/address"

#define kTempUserLoginMethod @"user/anonymity/create"
#define kThirdLoginMethod  @"user/thirdLogin"

#define kThirdRegistMethod @"user/anonymity/thirdRegister"
#define kTempUserRegistMethod @"user/anonymity/register"
#define kFindPassword      @"user/passwordBack"
#define kUserInfo          @"user/info"

#define kUpdateApp         @"version/check"
#define KAppRecommend      @"product/list"
#define kHSCoinsIntro      @"task/intro"

//----------->知识点相关<--------------------
#define kKnowledgeList @"knowledge/list"

#define kMessageList       @"message/list"
#define kMessageCount      @"message/count"
#define kMessageContent    @"message/content"
#define kMessageUpdate     @"message/update"

#define kNotificationToken @"notification/token"
#define kNotificationBadge @"notification/badge"
#define kEverydayTaskNet   @"task/list"
#define kEverydayDoTaskNet @"task/do"
#define kInAppPurchaseNet  @"pay/product"
#define kInAppPurchaseOrderNet @"pay/order/create"
#define kInAppPurchaseSuccessNet @"pay/order/update"

// ------------>社区<------------
// 帖子列表
#define kCommunityList @"bbs/list"
// 帖子详情
#define kCommunityDetail @"bbs/detail"
// 回复帖子
#define kCommunityReply @"bbs/reply"
// 更多回复
#define kCommunityMoreReply @"bbs/moreReply"
// 赞/取消赞
#define kCommunityLaud @"bbs/like"
// 发帖
#define kCommunityPost @"bbs/post"

#endif
