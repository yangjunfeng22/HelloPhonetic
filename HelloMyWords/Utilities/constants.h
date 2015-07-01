//
//  constants.h
//  HelloMyWords
//
//  Created by junfengyang on 15/5/22.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#ifndef HelloMyWords_constants_h
#define HelloMyWords_constants_h

typedef NS_ENUM(NSUInteger, LearnCheckPointType) {
    LearnCheckPointTypeSinglePhone,  // 单音节
    LearnCheckPointTypeExciseFirst,  // 单音节练习
    LearnCheckPointTypeDoublePhone,  // 双音节
    LearnCheckPointTypeExciseSecond, // 双音节练习
    LearnCheckPointTypeVowels,       // 元音
    LearnCheckPointTypeConsonants,   // 辅音
    LearnCheckPointTypeSyllable,     // 音节
    LearnCheckPointTypeExcise        // 练习
};

static NSString * const kUDKEY_Email  = @"Email";
static CGFloat const kAudioTotalWrongTimes = 5;

#define kSetUDUserEamil(email)     ([USER_DEFAULT setObject:email forKey:kUDKEY_Email], [USER_DEFAULT synchronize])
#define kEmail  [USER_DEFAULT objectForKey:kUDKEY_Email]

#define kToneTintColor RGBA(97, 103, 107, 1)
#define kToneBackgroundColor [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]



#endif
