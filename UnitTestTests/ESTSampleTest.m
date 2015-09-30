//
//  ESTSampleTest.m
//  UnitTest
//
//  Created by Maithri VM on 12/12/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ESTSampleTest : XCTestCase

@end

@implementation ESTSampleTest

+ (void)setUp
{
    NSLog(@"Class initialize");
}
+ (void)tearDown
{
    NSLog(@"Class cleanup");

}
- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTAssert((2+2 != 5), @"2+2 is 5!!!");
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}
- (void)testExample1
{
    XCTAssert((2+2 == 4), @"2+2 is not 4!!!");
    //    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}
@end
