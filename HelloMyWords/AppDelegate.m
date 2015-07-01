//
//  AppDelegate.m
//  HelloMyWords
//
//  Created by junfengyang on 15/5/14.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "AppDelegate.h"
#import <iflyMSC/IFlySpeechRecognizerDelegate.h>
#import <iflyMSC/IFlySpeechRecognizer.h>
#import <iflyMSC/IFlySpeechUtility.h>

#import "HomeViewController.h"
#import "TestViewController.h"
#import "LearnNavViewController.h"

#define _IPHONE80_ 80000

static BOOL isRunningTests(void) __attribute__((const));

@interface AppDelegate ()

@end

@implementation AppDelegate

/******************************* APNS ***********************************/
- (void)registerPushForIOS8{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

- (void)registerPush{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

/******************************* APNS ***********************************/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [NSThread sleepForTimeInterval:1000];
    
    if (isRunningTests()) {
        return YES;
    }
    
//    NSArray * fontArrays = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    for (NSString * temp in fontArrays)
//    {
//        NSLog(@"Font name  = %@", temp);
//        NSArray *subFontArrays = [UIFont fontNamesForFamilyName:temp];//+ (NSArray *)fontNamesForFamilyName:(NSString *)familyName;
//        for (NSString *subFontName in subFontArrays)
//        {
//            NSLog(@"sub Font name = %@", subFontName);
//        }
//    }
    
    if (kiOS8_OR_LATER) {
        [self registerPushForIOS8];
    }else{
        [self registerPush];
    }
    
    NSDictionary *dicEmail    = @{kUDKEY_Email:@""};
    [USER_DEFAULT registerDefaults:dicEmail];
    [USER_DEFAULT synchronize];
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"555557fc"];
    [IFlySpeechUtility createUtility:initString];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = kColorFFBackground;
    
    HomeViewController *home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    //TestViewController *test = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    //LearnNavViewController *home = [[LearnNavViewController alloc] initWithNibName:@"LearnNavViewController" bundle:nil];
    _window.rootViewController = home;
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/********************************* APNS *****************************/

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //用户已经允许接收以下类型的推送
    //UIUserNotificationType allowedTypes = [notificationSettings types];
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    if ([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]) {
        NSLog(@"ACCEPT_IDENTIFIER IS CLICKED");
    }
    
    completionHandler();
}

#endif

// 消息通知服务
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"regist failed: %@", error);
    /*
     NSString *msg = [[NSString alloc] initWithFormat:@"%@", error];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"failed" message:msg delegate:nil cancelButtonTitle:@"yes" otherButtonTitles:@"no", nil];
     [alert show];
     */
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

/********************************* APNS *****************************/

- (Store *)store
{
    if (!_store) {
        _store = [[Store alloc] init];
    }
    return _store;
}

@end



static BOOL isRunningTests(void)
{
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    //NSLog(@"运行时环境: %@", environment);
    NSString *injectBundle = environment[@"XCInjectBundle"];
    return [[injectBundle pathExtension] isEqualToString:@"xctest"];
}
