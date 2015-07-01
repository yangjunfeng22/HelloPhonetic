//
//  LearnViewController.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/27.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Store;
@protocol LearnDelegate;

@interface LearnViewController : UIViewController

@property (nonatomic, weak) id<LearnDelegate>delegate;
@property (nonatomic, readonly) LearnCheckPointType type;
@property (nonatomic) BOOL animation;
@property (nonatomic, strong) Store* store;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil learnType:(LearnCheckPointType)type;

@end

@protocol LearnDelegate <NSObject>

- (void)learnQuit:(LearnViewController *)learn;

@end
