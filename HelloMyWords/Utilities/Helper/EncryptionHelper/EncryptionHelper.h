//
//  EncryptionHelper.h
//  LiveCourse
//
//  Created by junfengyang on 15/1/21.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMD5_KEY @"hansheng"

@interface EncryptionHelper : NSObject

/**
 *  采用md5的形式对aString进行加密
 *
 *  @param aString 待加密的字符串
 *
 *  @return md5加密后的字符串。
 */
+ (NSString *)md5APKeyWithString:(NSString *)aString;

@end
