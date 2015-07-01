//
//  EncryptionHelper.m
//  LiveCourse
//
//  Created by junfengyang on 15/1/21.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "EncryptionHelper.h"
#import "MD5Helper.h"

@implementation EncryptionHelper

+ (NSString *)md5APKeyWithString:(NSString *)aString
{
    NSString *apKey = [[MD5Helper md5Digest:aString] uppercaseString];
    return apKey;
}

@end
