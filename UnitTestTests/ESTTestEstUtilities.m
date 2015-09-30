//
//  ESTTestEstUtilities.m
//  UnitTestTests
//
//  Created by Maithri VM on 09/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ESTAppDelegate.h"
#import "PFRUtilities.h"

@interface ESTTestEstUtilities : XCTestCase
{
    ESTAppDelegate *mDelegate;
}
@end

@implementation ESTTestEstUtilities

- (void)setUp
{
    [super setUp];
    mDelegate = [[UIApplication sharedApplication] delegate];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNil
{
    NSObject *emptyObject;
    XCTAssertNil(emptyObject, @"Object is not nil!!");
}

- (void)testNotNil
{
    XCTAssertNotNil(mDelegate, @"Appdelegate is nil!!");
}

-(void)testAssert
{
    BOOL isEqual = [PFRUtilities areNumbersEqual:@1 :@1];
    XCTAssert((isEqual==YES), @"Numbers equation failed!!");
}

-(void)testAssertTrue
{
    NSString *theDate = [PFRUtilities getUTCFormateDate:[NSDate date]];
    XCTAssertTrue((theDate.length>0), @"theDate length is less than 1!!");
}

-(void)testAssertFalse
{
    BOOL isEqual = [PFRUtilities areNumbersEqual:@2 :@1];
    XCTAssertFalse((isEqual==YES), @"Numbers equation failed!!");
}

-(void)testAssertEqualsObjects
{
    UIColor *theColor1 = [PFRUtilities colorWithHexString:@"ffffff" andAlpha:1.0];
    UIColor *theColor2 = [PFRUtilities colorWithHexString:@"ffffff" andAlpha:1.0];
    XCTAssertEqualObjects(theColor1, theColor2, @"Same Color objects are not matching!!");
}

-(void)testAssertNotEqualsObjects
{
    UIColor *theColor1 = [PFRUtilities colorWithHexString:@"ffffff" andAlpha:1.0];
    UIColor *theColor2 = [PFRUtilities colorWithHexString:@"000000" andAlpha:1.0];
    XCTAssertNotEqualObjects(theColor1, theColor2, @"Different Color objects are matching!!");
}

-(void)testAssertNil
{
    PFRUtilities *theUtilityObj = [[PFRUtilities alloc] init];
    theUtilityObj.mListOfUsers = nil;
    NSString *theUserName = nil;
    @try
    {
        theUserName = [theUtilityObj getCurrentlyLoggedInUserName];
    }
    @catch (NSException *r)
    {
        XCTAssertNil(theUserName, @"Returned Not nil!!");
 
    }
}

-(void)testAssertThrows
{
    PFRUtilities *theUtilityObj = [[PFRUtilities alloc] init];
    theUtilityObj.mListOfUsers = [NSArray array];
    XCTAssertThrows([theUtilityObj getCurrentlyLoggedInUserName], @"Did not throw exception");

}


-(void)testAssertNoThrow
{
    PFRUtilities *theUtilityObj = [[PFRUtilities alloc] init];
    theUtilityObj.mListOfUsers = @[@"User1",@"User2"];
    XCTAssertNoThrow([theUtilityObj getCurrentlyLoggedInUserName], @"Did not throw exception");
}

@end
