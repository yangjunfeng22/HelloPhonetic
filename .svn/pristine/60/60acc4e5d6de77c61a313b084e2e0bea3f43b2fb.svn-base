//
//  LanguageController.h
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/19.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LANGUAGE_STATE_NOTIFICATION   @"LANGUAGE_STATE_NOTIFICATION"
#define LANGUAGE_STATE                @"LANGUAGE_STATE"
@protocol LanguageControllerDelegate<NSObject>
@required
@optional
-(void)updateLanguage;
@end

/**
 * 首先在更改语言的按钮事件中添加语言切换通知语句：
 *
 * [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_STATE_NOTIFICATION object:nil];
 *
 * 然后在所有需要刷新页面的viewController的viewDidLoad函数中加入设置代理的语句：
 *
 * [LanguageController languageController].delegate = self;
 *
 * 再在这些viewController类中实现LanguageControllerDelegate的方法-(void)updateLanguage;所有因语言切换而需要更新或刷新的工作都放着这个代理方法中实现即可。
 */
@interface LanguageController : NSObject
@property(nonatomic,assign) id<LanguageControllerDelegate> delegate;
+(LanguageController *)languageController;
-(void)setDelegate:(id<LanguageControllerDelegate>)delegate;

@end
