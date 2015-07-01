//
//  ToneRecordOperation.m
//  HelloMyWords
//
//  Created by junfengyang on 15/6/12.
//  Copyright (c) 2015年 HSChinese iOS Team. All rights reserved.
//

#import "ToneRecordOperation.h"
#import <CoreData/CoreData.h>
#import "Store.h"
#import "NSString+ParseCSV.h"
#import "Reader.h"
#import "ToneKnowledge.h"
#import "ToneKnowledge+Record.h"

static const int ImportBatchSize = 250;

@interface ToneRecordOperation ()

@property (nonatomic, strong) Record *record;
@property (nonatomic, strong) Store *store;
@property (nonatomic, strong) Reader *reader;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isConcurrent;
@property (nonatomic) BOOL isFineshed;

@end

@implementation ToneRecordOperation

- (id)initWithStore:(Store *)store record:(Record *)record
{
    if (self = [super init]) {
        self.store = store;
        self.record = record;
    }
    return self;
}

- (id)initWithStore:(Store *)store fileName:(NSString *)name
{
    if (self = [super init]) {
        self.store = store;
        self.fileName = name;
    }
    return self;
}

- (void)start
{
    self.isExecuting = YES;
    self.isConcurrent = YES;
    self.isFineshed = NO;
    
    self.context = [self.store privateContext];
    self.context.undoManager = nil;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // NSInputStream 需要在主线程中操作
        [self streamRecord];
    }];
}

- (void)streamRecord
{
    [ToneKnowledge recordToneKnowledge:self.record intoContext:self.context];
    [self.context save:NULL];
}

- (void)streamImport
{
    NSURL *fileURL = [NSURL fileURLWithPath:self.fileName];
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]], @"please download the sample data");
    self.reader = [[Reader alloc] initWithFileAtURL:fileURL];
    [self.reader enumarateLinesWithBlock:^(NSUInteger lineNumber, NSString *line) {
        NSArray *components = [line csvComponents];
        
        if (lineNumber <= 1) {
            return ;
        }
        if ([components count] < 5 || [components count] > 7 ) {
            //NSLog(@"could't parse: %@", components);
            return;
        }
        [ToneKnowledge importToneKnowledgeComponents:components intoContext:self.context];
        
        self.progressCallback(lineNumber / (float)10000);
        if (lineNumber % ImportBatchSize == 0) {
            [self.context save:NULL];
        }
        
    } completionHandler:^(NSUInteger numberOfLines) {
        self.progressCallback(1);
        [self.context save:NULL];
    }];
}

- (void)setIsExecuting:(BOOL)isExecuting
{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = isExecuting;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setIsFineshed:(BOOL)isFineshed
{
    [self willChangeValueForKey:@"isFinished"];
    _isFineshed = isFineshed;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)cancel
{
    [super cancel];
    
    self.isFineshed = YES;
    self.isExecuting = NO;
}

@end
