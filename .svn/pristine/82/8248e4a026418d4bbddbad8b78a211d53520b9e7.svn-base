//
//  ImportOperation.h
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/18.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DataImportType) {
    DataImportTypeNormal,
    DataImportTypeToneKnowledge,
};

@class Store;
@interface ImportOperation : NSOperation
- (id)initWithStore:(Store *)store fileName:(NSString *)name;
- (id)initWithStore:(Store *)store fileName:(NSString *)name type:(DataImportType)type;
@property (nonatomic)float progress;
@property (nonatomic, copy) void (^ progressCallback)(float);


@end
