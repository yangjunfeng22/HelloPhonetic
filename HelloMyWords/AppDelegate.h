//
//  AppDelegate.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/14.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;
@property (nonatomic, strong) Store* store;


@end

