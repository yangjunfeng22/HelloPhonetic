//
//  DataTestCase.m
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/4.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataTestCase.h"

@interface DataTestCase()

@property (nonatomic, strong) NSMutableArray *mocksToVerify;

@end

@implementation DataTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    for (id mock in self.mocksToVerify){
        [mock verify];
    }
    
    self.mocksToVerify = nil;
    [super tearDown];
}

- (NSURL *)URLForResource:(NSString *)name withExtension:(NSString *)ext
{
    NSBundle *bundle = [NSBundle bundleForClass:[DataTestCase class]];
    return [bundle URLForResource:name withExtension:ext];

}

- (id)autoVerifiedMockForClass:(Class)aClass
{
    id mock = [OCMockObject mockForClass:aClass];
    [self verifyDuringTearDown:mock];
    return mock;
}

- (id)autoVerifiedPartialMockForObject:(id)object
{
    id mock = [OCMockObject partialMockForObject:object];
    [self verifyDuringTearDown:mock];
    return mock;
}

- (void)verifyDuringTearDown:(id)mock
{
    if (self.mocksToVerify == nil) {
        self.mocksToVerify = [[NSMutableArray alloc] init];
    }
    [self.mocksToVerify addObject:mock];
}

@end
