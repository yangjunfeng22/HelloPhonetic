//
//  UserDAL.h
//  PinyinGame
//
//  Created by yang on 13-11-19.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDAL : NSObject
@property (nonatomic, strong, readonly)NSError *error;

+ (NSString *)getLoginURLByApKey:(NSString *)apKey email:(NSString *)email password:(NSString *)password language:(NSString *)language productID:(NSString *)productID;

//第三方登陆
+ (NSString *)getTempUserLoginURLByApKey:(NSString *)apKey Language:(NSString *)language productID:(NSString *)productID mcKey:(NSString *)mcKey;


+ (NSString *)getThirdLoginURLByUserID:(NSString *)userID userEmail:(NSString *)userEmail name:(NSString *)name token:(NSString *)token img:(NSString *)imgUrl language:(NSString *)language identifier:(NSString *)identifier productID:(NSString *)productID;

+ (NSString *)getRegistURLByApKey:(NSString *)apKey email:(NSString *)email password:(NSString *)password language:(NSString *)language productID:(NSString *)productID mcKey:(NSString *)mcKey;

+ (NSString *)getTempUserRegistURLByApKey:(NSString *)apKey eemail:(NSString *)eemail nemail:(NSString *)nemail password:(NSString *)password Language:(NSString *)language productID:(NSString *)productID mcKey:(NSString *)mcKey;

//第三方创建个人档案
+ (NSString *)getThirdRegistURLByApKey:(NSString *)apKey userEmail:(NSString *)userEmail language:(NSString *)language productID:(NSString *)productID UserID:(NSString *)userID name:(NSString *)name identifier:(NSString *)identifier;

+ (NSString *)getPasswordBackURLByApKey:(NSString *)apKey email:(NSString *)email language:(NSString *)language productID:(NSString *)productID;

+ (NSString *)getUserVipProductListURLByApKey:(NSString *)apKey userID:(NSString *)uID language:(NSString *)language productID:(NSString *)productID;

+ (NSString *)getUserVipBuyURLByApKey:(NSString *)apKey userID:(NSString *)uID vipID:(NSString *)vID language:(NSString *)language productID:(NSString *)productID;

#pragma mark - Block
+ (void)parseUserByData:(id)resultData completion:(void (^)(BOOL finished, id result, NSError *error))completion;

+ (void)parseUserFindPasswordData:(id)resultData completion:(void (^)(BOOL finished, id result, NSError *error))completion;

+ (void)parseUserVipProductListData:(id)resultData completion:(void (^)(BOOL finished, id result, NSError *error))completion;

+ (void)parseUserVipBuyData:(id)resultData completion:(void (^)(BOOL finished, id result, NSError *error))completion;

+ (void)saveUserLaterStatusWithUserID:(NSString *)uID categoryID:(NSString *)ccID courseID:(NSString *)cID unitID:(NSString *)unitID lessonID:(NSString *)lID checkPointID:(NSString *)cpID nexCheckPointID:(NSString *)nexCpID timeStamp:(NSInteger)timeStamp completion:(void (^)(BOOL finished, id result, NSError *error))completion;


@end
