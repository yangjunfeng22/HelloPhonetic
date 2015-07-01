//
//  ToneRecordOperation.h
//  HelloMyWords
//
//  Created by junfengyang on 15/6/12.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Store;
@class Record;
@interface ToneRecordOperation : NSOperation
- (id)initWithStore:(Store *)store record:(Record *)record;
- (id)initWithStore:(Store *)store fileName:(NSString *)name;
@property (nonatomic)float progress;
@property (nonatomic, copy) void (^ progressCallback)(float);

@end
