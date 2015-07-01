//
//  UserNet.m
//  PinyinGame
//
//  Created by yang on 13-11-20.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import "UserNet.h"
#import "HttpClient.h"
#import "UserDAL.h"

#import "OpenUDID.h"
#import "KeyChainHelper.h"
#import "SystemInfoHelper.h"

static UserNet *instance = nil;

@interface UserNet ()
{
    
}

@end

@implementation UserNet

- (void)requestWithIdentifier:(NSString *)identifier completion:(void (^)(BOOL, id, NSError *))completion
{
    if ([identifier isEqualToString:kRegistMethod])
    {
        
    }
    else if ([identifier isEqualToString:kLoginMethod])
    {
        
    }
}

#pragma mark - block
- (void)startLoginWithUserEmail:(NSString *)email password:(NSString *)password completion:(void (^)(BOOL, id, NSError *))completion
{
    NSString *md5 = [[NSString alloc] initWithFormat:@"%@%@%@", email, productID(), kMD5_KEY];
    
    NSString *url = [UserDAL getLoginURLByApKey:[EncryptionHelper md5APKeyWithString:md5] email:email password:password language:currentLanguage() productID:productID()];
    
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            DLog(@"登录的jsonData: %@", jsonData);
        }
        
        if (jsonData) {
            [UserDAL parseUserByData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
    }];
}


- (void)tempUserLoginWithCompletion:(void (^)(BOOL, id, NSError *))completion
{
    NSString *md5 = [[NSString alloc] initWithFormat:@"%@%@%@", productID(),[OpenUDID value], kMD5_KEY];
    
    NSString *url = [UserDAL getTempUserLoginURLByApKey:[EncryptionHelper md5APKeyWithString:md5] Language:currentLanguage() productID:productID() mcKey:[OpenUDID value]];
    
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            //DLog(@"jsonData: %@", jsonData);
        }
        
        if (jsonData) {
            [UserDAL parseUserByData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
        
    }];
}

- (void)startRegistWithUserEmail:(NSString *)email password:(NSString *)password completion:(void (^)(BOOL, id, NSError *))completion
{
    NSString *md5 = [[NSString alloc] initWithFormat:@"%@%@%@", email, productID(), kMD5_KEY];
    NSString *url = [UserDAL getRegistURLByApKey:[EncryptionHelper md5APKeyWithString:md5] email:email password:password language:currentLanguage() productID:productID() mcKey:[OpenUDID value]];
    
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"注册: jsonData: %@", jsonData);
        }
        
        if (jsonData) {
            [UserDAL parseUserByData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
    }];
}

- (void)startThirdLoginWithUserID:(NSString *)userID Email:(NSString *)email name:(NSString *)name token:(NSString *)token img:(NSString *)imgUrl identifier:(NSString *)identifier completion:(void (^)(BOOL, id, NSError *))completion
{
    if (!userID)
    {
        NSError *error = [NSError errorWithDomain:nil code:1 userInfo:nil];
        if (completion) {
            completion(NO, nil, error);
        }
    }
    else
    {
        NSString *url = [UserDAL getThirdLoginURLByUserID:userID userEmail:email name:name token:token img:imgUrl language:currentLanguage() identifier:identifier productID:productID()];

        [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
            
            //DLog(@"error: %@", error.localizedDescription);
            id jsonData = nil;
            if (responseData && error.code == 0) {
                jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                //DLog(@"jsonData: %@", jsonData);
            }
            
            if (jsonData) {
                [UserDAL parseUserByData:jsonData completion:completion];
            }
            else
            {
                if (completion){
                    completion(NO, nil, error);
                }
            }
        }];
    }
}

//第三方创建个人档案
-(void)startThirdRegistWithUserID:(NSString *)userID name:(NSString *)name identifier:(NSString *)identifier completion:(void (^)(BOOL, id, NSError *))completion
{
    if (!userID)
    {
        NSError *error = [NSError errorWithDomain:nil code:1 userInfo:nil];
        if (completion) {
            completion(NO, nil, error);
        }
    }
    else
    {
        NSString *oldemail = [KeyChainHelper getUserNameWithService:KEY_USERNAME];
        NSString *md5 = [[NSString alloc] initWithFormat:@"%@%@%@", productID(),oldemail, kMD5_KEY];
        
        NSString *url = [UserDAL getThirdRegistURLByApKey:[EncryptionHelper md5APKeyWithString:md5] userEmail:oldemail language:currentLanguage() productID:productID() UserID:userID name:name identifier:identifier];
        
        [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
            
            //DLog(@"error: %@", error.localizedDescription);
            id jsonData = nil;
            if (responseData && error.code == 0) {
                jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                //DLog(@"jsonData: %@", jsonData);
            }
            
            if (jsonData) {
                [UserDAL parseUserByData:jsonData completion:completion];
            }
            else
            {
                if (completion){
                    completion(NO, nil, error);
                }
            }
        }];
    }
}

//临时用户注册
- (void)startRegistTempUserWithUserEmail:(NSString *)newEmail password:(NSString *)password completion:(void (^)(BOOL, id, NSError *))completion
{
    
    NSString *oldemail = [KeyChainHelper getUserNameWithService:KEY_USERNAME];
    NSString *md5 = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@", productID(),[OpenUDID value],oldemail,newEmail,password, kMD5_KEY];
    
    NSString *url =[UserDAL getTempUserRegistURLByApKey:[EncryptionHelper md5APKeyWithString:md5] eemail:newEmail nemail:oldemail password:password Language:currentLanguage() productID:productID() mcKey:[OpenUDID value]];
    
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            //DLog(@"jsonData: %@", jsonData);
        }
        
        if (jsonData) {
            [UserDAL parseUserByData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
    }];
}

- (void)startFindBackUserPasswordWithEmail:(NSString *)email completion:(void (^)(BOOL, id, NSError *))completion
{

    NSString *md5 = [[NSString alloc] initWithFormat:@"%@%@%@", email, productID(), kMD5_KEY];
    NSString *url = [UserDAL getPasswordBackURLByApKey:[EncryptionHelper md5APKeyWithString:md5] email:email language:currentLanguage() productID:productID()];
    
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            //DLog(@"jsonData: %@", jsonData);
        }
        
        if (jsonData) {
            [UserDAL parseUserFindPasswordData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
    }];
}

- (void)requestUserInfoWithEmail:(NSString *)email completion:(void (^)(BOOL, id, NSError *))completion
{
    NSString *md5 = [[NSString alloc] initWithFormat:@"%@%@%@", email, productID(), kMD5_KEY];
    NSString *url = [UserDAL getPasswordBackURLByApKey:[EncryptionHelper md5APKeyWithString:md5] email:email language:currentLanguage() productID:productID()];
    
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            //DLog(@"jsonData: %@", jsonData);
        }
        
        if (jsonData) {
            [UserDAL parseUserByData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
    }];
}

- (void)requestUserVipProductListWithUserID:(NSString *)uID completion:(void (^)(BOOL, id, NSError *))completion
{
    NSString *url = [UserDAL getUserVipProductListURLByApKey:[EncryptionHelper md5APKeyWithString:@""] userID:uID language:currentLanguage() productID:productID()];
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            DLog(@"vip产品数据 jsonData: %@; 源数据: %@", jsonData, responseString);
        }
        
        if (jsonData) {
            [UserDAL parseUserVipProductListData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
    }];
}

- (void)requestUserVipBuyWithUserID:(NSString *)uID vipID:(NSString *)vID completion:(void (^)(BOOL, id, NSError *))completion
{
    NSString *url = [UserDAL getUserVipBuyURLByApKey:[EncryptionHelper md5APKeyWithString:@""] userID:uID vipID:vID language:currentLanguage() productID:productID()];
    [self.requestClient postRequestFromURL:url identifier:@"" completion:^(BOOL finished, NSData *responseData, NSString *responseString, NSError *error) {
        
        //DLog(@"error: %@", error.localizedDescription);
        id jsonData = nil;
        if (responseData && error.code == 0) {
            jsonData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
            DLog(@"vip购买数据 jsonData: %@; 源数据: %@", jsonData, responseString);
        }
        
        if (jsonData) {
            [UserDAL parseUserVipBuyData:jsonData completion:completion];
        }
        else
        {
            if (completion){
                completion(NO, nil, error);
            }
        }
    }];
}

#pragma mark - Cancel
- (void)cancelLogin
{
    [self.requestClient cancelAllRequest];
}

@end
