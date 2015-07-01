//
//  Reader.h
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/18.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reader : NSObject

- (id)initWithFileAtURL:(NSURL *)fileURL;
- (void)enumarateLinesWithBlock:(void (^)(NSUInteger lineNumber, NSString *line))block
              completionHandler:(void(^)(NSUInteger numberOfLines))completion;

@end
