//
//  ToneLabel.h
//  HelloMyWords
//
//  Created by junfengyang on 15/6/15.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToneLabel : UILabel
@property (nonatomic, strong) UIColor *toneTintColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSInteger tone;

- (void)clearTone;

@end
