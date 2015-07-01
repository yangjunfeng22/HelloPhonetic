//
//  HomeViewController.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/21.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSPinyinLabel.h"
#import "AudioRecordAndPlayView.h"

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet HSPinyinLabel *lblExample;

@property (weak, nonatomic) IBOutlet AudioRecordAndPlayView *audioControlView;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIView *borderView;

@end
