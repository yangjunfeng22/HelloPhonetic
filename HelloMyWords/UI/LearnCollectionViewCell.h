//
//  LearnCollectionViewCell.h
//  HelloMyWords
//
//  Created by junfengyang on 15/6/2.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"
#import "AppDelegate.h"

@interface LearnCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) Record *record;

- (void)prepareForAppearLayout;
- (void)layoutSubviewsAppear;
- (void)layoutSubviewsDisappear;

- (void)resetAudioState;

- (void)playSourceAudio;

@end
