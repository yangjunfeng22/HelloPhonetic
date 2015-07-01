//
//  BaseNet.m
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/9.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "BaseNet.h"

@implementation BaseNet

- (HttpClient *)requestClient
{
    if (!_requestClient) _requestClient = [[HttpClient alloc] init];
    return _requestClient;
}

-(void)dealloc
{
    [_requestClient cancelAllRequest];
    _requestClient=nil;
}


- (void)requestWithIdentifier:(NSString *)identifier completion:(void (^)(BOOL, id, NSError *))completion
{
    
}

@end
