//
//  ESTTestEstUserProfile.m
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ESTUserProfileManager.h"

@interface ESTTestEstUserProfile : XCTestCase

@end

@implementation ESTTestEstUserProfile

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
    ESTUserProfileManager *theESTUserProfileManager = [[ESTUserProfileManager alloc] init];
    XCTAssertNotNil(theESTUserProfileManager, @"ESTUserProfileManager is nil!!");
}

- (void)testUserIDNotNil
{
    ESTUserProfileManager *theESTUserProfileManager = [[ESTUserProfileManager alloc] init];
    NSString *theUserID = [theESTUserProfileManager getCurrentlyLoggedInUserID];
    XCTAssertNotNil(theUserID, @"UserID is nil!!");
}

- (void)testUserIDLength
{
    ESTUserProfileManager *theESTUserProfileManager = [[ESTUserProfileManager alloc] init];
    NSString *theUserID = [theESTUserProfileManager getCurrentlyLoggedInUserID];
    XCTAssert((theUserID.length > 0), @"UserID is empty string!!");
}
@end
