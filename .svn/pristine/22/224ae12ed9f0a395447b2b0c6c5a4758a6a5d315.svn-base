//
//  UserDAL.m
//  PinyinGame
//
//  Created by yang on 13-11-19.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import "UserDAL.h"
#import "URLUtility.h"
#import "KeyChainHelper.h"
#import "APIDefinition.h"

@implementation UserDAL

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    
}

+ (NSString *)getLoginURLByApKey:(NSString *)apKey email:(NSString *)email password:(NSString *)password language:(NSString *)language productID:(NSString *)productID
{
    NSString *url = [kLifeHostUrl stringByAppendingString:kLoginMethod];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"email":email, @"password":password, @"language":language, @"productID":productID}];
}


+ (NSString *)getTempUserLoginURLByApKey:(NSString *)apKey Language:(NSString *)language productID:(NSString *)productID mcKey:(NSString *)mcKey
{
    NSString *url = [kLifeHostUrl stringByAppendingString:kTempUserLoginMethod];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"language":language, @"comefrom":productID, @"mckey":mcKey}];
}

+ (NSString *)getThirdLoginURLByUserID:(NSString *)userID userEmail:(NSString *)userEmail name:(NSString *)name token:(NSString *)token img:(NSString *)imgUrl language:(NSString *)language identifier:(NSString *)identifier productID:(NSString *)productID{
    
    NSString *url = [kLifeHostUrl stringByAppendingString:kThirdLoginMethod];
    return [URLUtility getURL:url fromParams:@{@"userID":userID, @"email":userEmail, @"name":name, @"token":token, @"image":imgUrl, @"language":language, @"identifier":identifier, @"productID":productID}];
}

+ (NSString *)getRegistURLByApKey:(NSString *)apKey email:(NSString *)email password:(NSString *)password language:(NSString *)language productID:(NSString *)productID mcKey:(NSString *)mcKey
{
    NSString *url = [kLifeHostUrl stringByAppendingString:kRegistMethod];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"email":email, @"password":password, @"language":language, @"comefrom":productID, @"mckey":mcKey}];
}


+ (NSString *)getTempUserRegistURLByApKey:(NSString *)apKey eemail:(NSString *)eemail nemail:(NSString *)nemail password:(NSString *)password Language:(NSString *)language productID:(NSString *)productID mcKey:(NSString *)mcKey{
    NSString *url = [kLifeHostUrl stringByAppendingString:kTempUserRegistMethod];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"email":eemail, @"nemail":nemail, @"password":password, @"language":language, @"comefrom":productID, @"mckey":mcKey}];
}


+(NSString *)getThirdRegistURLByApKey:(NSString *)apKey userEmail:(NSString *)userEmail language:(NSString *)language productID:(NSString *)productID UserID:(NSString *)userID name:(NSString *)name identifier:(NSString *)identifier
{
    NSString *url = [kLifeHostUrl stringByAppendingString:kThirdRegistMethod];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"email":userEmail, @"userID":userID, @"name":name, @"identifier":identifier, @"language":language, @"productID":productID}];
}

+ (NSString *)getPasswordBackURLByApKey:(NSString *)apKey email:(NSString *)email language:(NSString *)language productID:(NSString *)productID
{
    NSString *url = [kLifeHostUrl stringByAppendingString:kFindPassword];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"email":email, @"language":language, @"productID":productID}];
}

+ (NSString *)getUserVipProductListURLByApKey:(NSString *)apKey userID:(NSString *)uID language:(NSString *)language productID:(NSString *)productID
{
    NSString *url = [kLifeHostUrl stringByAppendingString:kVipList];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"uID":uID, @"language":language, @"productID":productID}];
}

+ (NSString *)getUserVipBuyURLByApKey:(NSString *)apKey userID:(NSString *)uID vipID:(NSString *)vID language:(NSString *)language productID:(NSString *)productID
{
    NSString *url = [kLifeHostUrl stringByAppendingString:kVipBuy];
    return [URLUtility getURL:url fromParams:@{@"apkey":apKey, @"uID":uID, @"itemID":vID, @"language":language, @"productID":productID}];
}

#pragma mark - block
// 登陆/注册
+ (void)parseUserByData:(id)resultData completion:(void (^)(BOOL, id, NSError *))completion
{
    if ([resultData isKindOfClass:[NSDictionary class]])
    {
        BOOL success = [[resultData objectForKey:@"Success"] boolValue];
        NSString *message = [resultData objectForKey:@"Message"];
        
        id results = [resultData objectForKey:@"User"];
        
        NSInteger errorCode = success ? 0 : 1;
        NSString *domain = (message ? message : @"");
        //NSLog(@"errorCode: %d", errorCode);
        NSError *error = [NSError errorWithDomain:domain code:errorCode userInfo:nil];
        // 目前根据协议, 只有用户登陆才会返回有具体信息。
        if (success)
        {
            [self parseUserLogin:results completion:completion];
        }
        else
        {
            if (completion) {
                completion(success, nil, error);
            }
        }
    }
    else
    {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"数据封装出错!", @"") code:-1 userInfo:nil];
        if (completion) {
            completion(NO, nil, error);
        }
    }
}

+ (void)parseUserLogin:(id)resultData completion:(void (^)(BOOL, id, NSError *))completion
{
    if ([resultData isKindOfClass:[NSDictionary class]])
    {
        //NSLog(@"结果数据: %@", resultData);
        NSString *userID    = [resultData objectForKey:@"Uid"];
        NSString *userEmail = [resultData objectForKey:@"Email"];
        NSString *endDate   = [resultData objectForKey:@"Enddate"];
        NSString *image     = [resultData objectForKey:@"Avatars"];
        NSString *name      = [resultData objectForKey:@"Nickname"];
        NSString *role      = [resultData objectForKey:@"Role"];
        NSInteger coin      = [[resultData objectForKey:@"Balance"] integerValue];
        // vip过期的时间
        NSUInteger endTime   = [[resultData objectForKey:@"EndTime"] integerValue];
        
        BOOL enabled        = [[resultData objectForKey:@"Enabled"] boolValue];
        
        NSString *null = @"(null)";
        userID = [userID isEqualToString:null] ? nil:userID;
        userEmail = [userEmail isEqualToString:null] ? nil:userEmail;
        endDate = [endDate isEqualToString:null] ? nil:endDate;
        image = [image isEqualToString:null] ? nil:image;
        name = [name isEqualToString:null] ? nil:name;
        role = [role isEqualToString:null] ? nil:role;
        
        
        BOOL emptyEmail = [[userEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || !userEmail;
        if (!emptyEmail)
        {
            [KeyChainHelper saveUserName:userEmail userNameService:KEY_USERNAME password:@"" passwordService:KEY_PASSWORD];
        }
        
        if (completion) {
            completion(YES, nil, nil);
        }
    }
    else
    {
        NSError *error = [NSError errorWithDomain:MyLocal(@"数据封装出错!", @"") code:-1 userInfo:nil];
        if (completion) {
            completion(NO, nil, error);
        }
    }
}

// 找回密码
+ (void)parseUserFindPasswordData:(id)resultData completion:(void (^)(BOOL, id, NSError *))completion
{
    if ([resultData isKindOfClass:[NSDictionary class]])
    {
        BOOL success = [[resultData objectForKey:@"Success"] boolValue];
        NSString *message = [resultData objectForKey:@"Message"];
        
        NSInteger errorCode = success ? 0 : 1;
        NSString *domain = (message ? message : @"");
        //NSLog(@"errorCode: %d", errorCode);
        NSError *error = [NSError errorWithDomain:domain code:errorCode userInfo:nil];
        
        if (completion) {
            completion(success, nil, error);
        }
    }
    else
    {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"数据封装出错!", @"") code:-1 userInfo:nil];
        if (completion) {
            completion(NO, nil, error);
        }
    }
}

+ (void)parseUserVipProductListData:(id)resultData completion:(void (^)(BOOL, id, NSError *))completion
{
    if ([resultData isKindOfClass:[NSDictionary class]])
    {
        BOOL success = [[resultData objectForKey:@"Success"] boolValue];
        NSString *message = [resultData objectForKey:@"Message"];
        // 特权
        //NSString *prerogative = [resultData objectForKey:@"Prerogative"];
        id results = [resultData objectForKey:@"Records"];
        
        NSInteger errorCode = success ? 0 : 1;
        NSString *domain = (message ? message : @"");
        NSError *error = [NSError errorWithDomain:domain code:errorCode userInfo:nil];
        if (success)
        {
            if ([results isKindOfClass:[NSArray class]])
            {
                NSMutableArray *arrVip = [[NSMutableArray alloc] initWithCapacity:2];
                for (NSDictionary *dicRecord in results)
                {
                    NSString *vID = [[NSString alloc] initWithFormat:@"%@", [dicRecord objectForKey:@"Vid"]];
                    NSString *duration     = [dicRecord objectForKey:@"Duration"];
                    NSString *price  = [dicRecord objectForKey:@"Price"];
                    NSString *explain  = [dicRecord objectForKey:@"Description"];
                    
                }
                
                if (completion){
                    completion(YES, arrVip, error);
                }
            }
            else
            {
                NSError *error = [NSError errorWithDomain:MyLocal(@"数据封装出错!", @"") code:-1 userInfo:nil];
                if (completion) {
                    completion(NO, nil, error);
                }
            }
        }
        else
        {
            if (completion) {
                completion(success, nil, error);
            }
        }
    }
    else
    {
        NSError *error = [NSError errorWithDomain:MyLocal(@"数据封装出错!", @"") code:-1 userInfo:nil];
        if (completion) {
            completion(NO, nil, error);
        }
    }
}

+ (void)parseUserVipBuyData:(id)resultData completion:(void (^)(BOOL, id, NSError *))completion
{
    if ([resultData isKindOfClass:[NSDictionary class]])
    {
        BOOL success = [[resultData objectForKey:@"Success"] boolValue];
        NSString *message = [resultData objectForKey:@"Message"];
        id results = [resultData objectForKey:@"Result"];
        
        NSInteger errorCode = success ? 0 : 1;
        NSString *domain = (message ? message : @"");
        NSError *error = [NSError errorWithDomain:domain code:errorCode userInfo:nil];
        if (success)
        {
            if ([results isKindOfClass:[NSDictionary class]])
            {
                //NSString *duration     = [results objectForKey:@"Duration"];
                //NSString *price  = [results objectForKey:@"Price"];
                NSString *role = [[NSString alloc] initWithFormat:@"%@", [results objectForKey:@"Role"]];
                NSUInteger endTime  = [[results objectForKey:@"EndTime"] integerValue];
                NSInteger coin      = [[results objectForKey:@"Balance"] integerValue];
                //DLog(@"duration: %@, price: %@, endTiem: %@", duration, price, endTime);
                
                if (completion){
                    completion(YES, @(coin), error);
                }
            }
            else
            {
                NSError *error = [NSError errorWithDomain:MyLocal(@"数据封装出错!", @"") code:-1 userInfo:nil];
                if (completion) {
                    completion(NO, nil, error);
                }
            }
        }
        else
        {
            if (completion) {
                completion(success, nil, error);
            }
        }
    }
    else
    {
        NSError *error = [NSError errorWithDomain:MyLocal(@"数据封装出错!", @"") code:-1 userInfo:nil];
        if (completion) {
            completion(NO, nil, error);
        }
    }
}

@end
