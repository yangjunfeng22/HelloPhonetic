//
//  DataTestCase.h
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/4.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#ifndef LiveInShanghai_DataTestCase_h
#define LiveInShanghai_DataTestCase_h
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

// This little block can probably go away with the next version of developer tools:
#ifndef NS_REQUIRES_SUPER
# if __has_attribute(objc_requires_super)
#  define NS_REQUIRES_SUPER __attribute((objc_requires_super))
# else
#  define NS_REQUIRES_SUPER
# endif
#endif

#define TestNeedsToWaitForBlock() __block BOOL blockFinished = NO
#define BlockFinished() blockFinished = YES
#define WaitForBlock() while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !blockFinished)

@interface DataTestCase : XCTestCase

- (void)setUp NS_REQUIRES_SUPER;
- (void)tearDown NS_REQUIRES_SUPER;

// Returns the URL for a resource that's been added to the test target
- (NSURL *)URLForResource:(NSString *)name withExtension:(NSString *)ext;

// Calls +[OCMockObject mockForClass:] and adds the mock and call -verify on it during -tearDown
- (id)autoVerifiedMockForClass:(Class)aClass;
// C.f. -autoVerifiedMockForClass:
- (id)autoVerifiedPartialMockForObject:(id)object;

// Calls -verify on the mock during -tearDown
- (void)verifyDuringTearDown:(id)mock;

@end

#endif
