//
//  AboutUsViewController.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/25.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutUsDelegate;

@interface AboutUsViewController : UIViewController
@property (weak, nonatomic) id<AboutUsDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgvLogo;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
@property (weak, nonatomic) IBOutlet UIButton *btnFeedback;

@end

@protocol AboutUsDelegate <NSObject>

- (void)userLogout:(id)sender;

@end