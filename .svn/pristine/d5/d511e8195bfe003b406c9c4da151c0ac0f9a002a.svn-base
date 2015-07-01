//
//  HttpClient.h
//  PinyinGame
//
//  Created by yang on 13-11-16.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface HttpClient : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic, readonly)NSInteger statuCode;
@property (nonatomic, readonly)BOOL isRequestCanceled;

@property (nonatomic, strong)NSError *error;

- (void)getRequestFromURL:(NSString *)url identifier:(NSString *)identifier completion:(void (^)(BOOL finished, NSData *responseData, NSString *responseString, NSError *error))completion;

- (void)postRequestFromURL:(NSString *)url identifier:(NSString *)identifier completion:(void (^)(BOOL finished, NSData *responseData, NSString *responseString, NSError *error))completion;

- (void)cancelRequestWithIdentifier:(NSString *)identifier;

- (void)cancelAllRequest;

- (BOOL)isRequestAllCanceled;

@end
