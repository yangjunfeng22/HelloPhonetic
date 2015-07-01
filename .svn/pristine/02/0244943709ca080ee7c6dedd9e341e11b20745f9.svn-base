//
//  BaseNet.h
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/9.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIDefinition.h"
#import "HttpClient.h"
#import "EncryptionHelper.h"
#import "SystemInfoHelper.h"


@interface BaseNet : NSObject

@property (nonatomic, strong)HttpClient *requestClient;

/**
 *  统一测试的入口
 *   -- 为了测试的方便性在这添加一个统一的入口，传入identifier作为子类调用的依据。
 *   -- 子类重载该接口，然后判断identifier，以调用自身的网络请求。
 *
 *  @param identifier 标识
 *  @param completion 回调
 */
- (void)requestWithIdentifier:(NSString *)identifier completion:(void (^)(BOOL finished, id result, NSError *error))completion;

@end
