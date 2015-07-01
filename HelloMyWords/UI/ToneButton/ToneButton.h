//
//  ToneButton.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/29.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToneButton : UIButton
@property (nonatomic, strong) UIColor *toneTintColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSInteger tone;

- (void)clearTone;

@end
