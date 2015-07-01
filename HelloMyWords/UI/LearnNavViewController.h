//
//  LearnNavViewController.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/25.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearnNavBackgroundView.h"
#import "HSPinyinLabel.h"

@protocol learnNavDelegate;

@interface LearnNavViewController : UIViewController
@property (weak, nonatomic) id<learnNavDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnAboutUs;
@property (weak, nonatomic) IBOutlet UIButton *btnReports;
@property (weak, nonatomic) IBOutlet HSPinyinLabel *lblTitle;


@property (weak, nonatomic) IBOutlet UIScrollView *checkPointScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *checkPointPageControl;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIButton *btnSinglePhone;
@property (weak, nonatomic) IBOutlet UIButton *btnDoublePhone;

@property (weak, nonatomic) IBOutlet UIButton *btnExciseFirst;
@property (weak, nonatomic) IBOutlet UIButton *btnExciseSecond;
// 元音
@property (weak, nonatomic) IBOutlet UIButton *btnVowels;

// 音节
@property (weak, nonatomic) IBOutlet UIButton *btnSyllable;

// 辅音
@property (weak, nonatomic) IBOutlet UIButton *btnConsonants;

@property (weak, nonatomic) IBOutlet UIButton *btnExcise;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet LearnNavBackgroundView *navBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *imgvTitle;


@end

@protocol learnNavDelegate <NSObject>

@optional
- (void)userLogout:(id)sender;

@end
