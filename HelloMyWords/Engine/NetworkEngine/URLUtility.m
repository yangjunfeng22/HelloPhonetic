//
//  URLUtility.m
//  PinyinGame
//
//  Created by yang on 13-11-19.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import "URLUtility.h"

@implementation URLUtility

#pragma mark - 
+ (NSString *)getURLParams:(NSDictionary *)params
{
    NSString *url = @"";
    for (NSString *key in [params allKeys])
    {
        NSString *value = [params objectForKey:key];
        url = [url stringByAppendingFormat:@"%@=%@&", key, value];
    }
    return [url substringToIndex:[url length]-1];
}

+ (NSString *)getURL:(NSString *)aUrl fromParams:(NSDictionary *)params
{
    NSString *url = [aUrl copy];
    
    // 查看所传url最后是不是以?结尾的。
    NSString *last = [aUrl substringFromIndex:[aUrl length]-1];
    if (!([last isEqualToString:@"?"] || [last isEqualToString:@"？"])){
        url = [url stringByAppendingString:@"?"];
    }
    
    // 构建标准的url。
    for (NSString *key in [params allKeys])
    {
        NSString *value = [params objectForKey:key];
        url = [url stringByAppendingFormat:@"%@=%@&", key, value];
    }
    // 返回构建好的url。
    return [url substringToIndex:[url length]-1];
}


@end
