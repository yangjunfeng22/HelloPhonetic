//
//  Reader.m
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/18.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import "Reader.h"
#import "NSData+EnumerateComponents.h"

@interface Reader ()<NSStreamDelegate>
@property (nonatomic, strong) NSInputStream *inputStream;
@property (nonatomic, strong) NSURL *fileURL;
@property (nonatomic, copy) NSData *delimiter;
@property (nonatomic, strong) NSMutableData *remainder;
@property (nonatomic, copy) void (^callBack)(NSUInteger lineNumber, NSString *line);
@property (nonatomic, copy) void (^completion)(NSUInteger numberOfLines);
@property (nonatomic) NSUInteger lineNumber;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation Reader

- (void)enumarateLinesWithBlock:(void (^)(NSUInteger, NSString *))block completionHandler:(void (^)(NSUInteger))completion
{
    if (self.queue == nil) {
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
    }
    
    NSAssert(self.queue.maxConcurrentOperationCount == 1, @"Queue can't be concurrent.");
    NSAssert(self.inputStream == nil, @"Can not process multiple input streams in parallel");
    
    self.callBack    = block;
    self.completion  = completion;
    self.inputStream = [[NSInputStream alloc] initWithURL:self.fileURL];
    self.inputStream.delegate = self;
    
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.inputStream open];
}

- (id)initWithFileAtURL:(NSURL *)fileURL
{
    if (![fileURL isFileURL]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.fileURL   = fileURL;
        self.delimiter = [@"\n" dataUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

#pragma mark - NSInputStream Delegate
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventOpenCompleted:{
            break;
        }
        case NSStreamEventEndEncountered:{
            [self emitLineWithData:self.remainder];
            self.remainder = nil;
            [self.inputStream close];
            self.inputStream = nil;
            [self.queue addOperationWithBlock:^{
                self.completion(self.lineNumber + 1);
            }];
            break;
        }
        case NSStreamEventErrorOccurred:{
            NSLog(@"error");
            break;
        }
        case NSStreamEventHasBytesAvailable:{
            NSMutableData *buffer = [NSMutableData dataWithLength:4*1024];
            NSUInteger length = (NSUInteger)[self.inputStream read:[buffer mutableBytes] maxLength:[buffer length]];
            if (length > 0) {
                [buffer setLength:length];
                __weak id weakSelf = self;
                [self.queue addOperationWithBlock:^{
                    // 过滤获取到的数据
                    [weakSelf processDataChunk:buffer];
                }];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)processDataChunk:(NSMutableData *)buffer
{
    if (self.remainder != nil) {
        [self.remainder appendData:buffer];
    }else{
        self.remainder = buffer;
    }
    
    [self.remainder obj_enumerateComponentsSeparatedBy:self.delimiter usingBlock:^(NSData *component, BOOL finalBlock) {
        if (!finalBlock) {
            [self emitLineWithData:component];
        }else if (component.length > 0){
            self.remainder = [component mutableCopy];
        }else{
            self.remainder = nil;
        }
    }];
}

- (void)emitLineWithData:(NSData *)data
{
    NSUInteger lineNumber = self.lineNumber;
    self.lineNumber = lineNumber+1;
    if (data.length > 0) {
        NSString *line = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.callBack(lineNumber, line);
    }
}

@end
