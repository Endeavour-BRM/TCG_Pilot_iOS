//
//  ESTTestEstManager.m
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ESTManager.h"

@interface ESTTestEstManager : XCTestCase
{
}
@end

@implementation ESTTestEstManager

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testObjectNotNil
{
    ESTManager *theESTManager = [[ESTManager alloc] init];
    XCTAssertNotNil(theESTManager, @"ESTManager is nil!!");
}

/*- (void)testDownloadContacts
{
    ESTManager *theESTManager = [[ESTManager alloc] init];
    [theESTManager downloadContacts];
    XCTAssertNotNil(theESTManager, @"ESTManager is nil!!");
}*/
@end
