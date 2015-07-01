//
//  UserInfoTestCases.m
//  LiveInShanghai
//
//  Created by junfengyang on 15/3/9.
//  Copyright (c) 2015年 junfengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "DataTestCase.h"
#import "UserNet.h"

@interface UserInfoTestCases : DataTestCase
{
    //UserNet *userNet;
}
@property (nonatomic, strong)UserNet *userNet;


@end

@implementation UserInfoTestCases
- (UserNet *)userNet
{
    if (!_userNet) {
        _userNet = [[UserNet alloc] init];
    }
    return _userNet;
}

- (void)setUp {
    [super setUp];
    
    //userNet = [[UserNet alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _userNet = nil;
    
    [super tearDown];
}

- (void)testUserRegist {
    // This is an example of a functional test case.
    TestNeedsToWaitForBlock();
    [self.userNet startRegistWithUserEmail:@"yy88@126.com" password:@"123456" completion:^(BOOL finished, id result, NSError *error) {
        // 当expression计算结果为false时报错。
        XCTAssertTrue(finished, @"注册出错!");
        BlockFinished();
    }];
    WaitForBlock();
}

- (void)testUserLogin
{
    TestNeedsToWaitForBlock();
    [self.userNet startLoginWithUserEmail:@"yy22@126.com" password:@"123456" completion:^(BOOL finished, id result, NSError *error) {
        XCTAssertTrue(finished, @"登录出错!");
        BlockFinished();
    }];
    WaitForBlock();
}

/*
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
 */

@end
