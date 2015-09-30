//
//  ESTTestEstRequestResponse.m
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

#import "ESTDownloadDelegate.h"
#import "ESTRequestResponseHandler.h"
#define SAMPLE_URL @"https://www.agentachieve.com/API/contacts/?$filter=UserID+eq+48822"
#define SUCCESS_CODE 200
#define FAILURE_CODE 404

/******************* Fake  Download delegate ********************/
@interface ESTRequResponseFake:NSObject<ESTDownloadDelegate>
{
}
@property(nonatomic,assign)NSInteger mErrorCode;
@property(nonatomic,strong)NSData *mDownloadedData;
@end
@implementation ESTRequResponseFake
-(void)dataDownloadCompleteWithData:(NSData*)inData
{
    self.mDownloadedData = inData;
}
-(void)dataDownloadFailedWithError:(NSError*)inError
{
    self.mErrorCode = inError.code;
}
@end
/******************* Fake  Download delegate ********************/

/******************* Fake  Response ********************/
@interface ESTFakeResponse : NSHTTPURLResponse
{
    @private
    NSInteger mStatusCode;
}
-(id)initWithStatusCode:(int)inStatusCode;
@end

@implementation ESTFakeResponse
-(id)initWithStatusCode:(int)inStatusCode;
{
    if(self = [super init])
    {
        mStatusCode = inStatusCode;
    }
    return self;
}
- (NSInteger)statusCode
{
    return mStatusCode; //stub code
}
@end
/******************* Fake  Response ********************/


@interface ESTTestEstRequestResponse : XCTestCase
{
    ESTRequResponseFake *mSampleDelegate;
    ESTRequestResponseHandler *mESTRequestResponseManager;
}
@end

@implementation ESTTestEstRequestResponse

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    mSampleDelegate = [[ESTRequResponseFake alloc] init];
    mESTRequestResponseManager = [[ESTRequestResponseHandler alloc] initWithDelegate:mSampleDelegate];

}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testObjectNotNil
{
    ESTRequResponseFake *sampleDelegate = [[ESTRequResponseFake alloc] init];
    ESTRequestResponseHandler *theESTRequestResponseManager = [[ESTRequestResponseHandler alloc] initWithDelegate:sampleDelegate];
    XCTAssertNotNil(theESTRequestResponseManager, @"ESTRequestResponseHandler is nil!!");
}

- (void)testReceivingResponseDiscardsExistingData
{
    [mESTRequestResponseManager downloadDataFromURL:[NSURL URLWithString:SAMPLE_URL]];
    ESTFakeResponse *fakeResponse = [[ESTFakeResponse alloc] initWithStatusCode:SUCCESS_CODE];
    [mESTRequestResponseManager connection:nil didReceiveResponse:fakeResponse];
    [mESTRequestResponseManager connection:nil didReceiveData:[@"Hello" dataUsingEncoding: NSUTF8StringEncoding]];
//    [mESTRequestResponseManager connection:nil didReceiveResponse:nil];
    XCTAssertNotEqual([mESTRequestResponseManager.downloadedData length], (NSUInteger)0,@"Data should have been discarded");
}

- (void)testReceivingResponseWith404StatusPassesErrorToDelegate
{
    [mESTRequestResponseManager downloadDataFromURL:[NSURL URLWithString:SAMPLE_URL]];
    ESTFakeResponse *fakeResponse = [[ESTFakeResponse alloc] initWithStatusCode:FAILURE_CODE];
    [mESTRequestResponseManager connection: nil didReceiveResponse:fakeResponse];
    XCTAssertEqual([mSampleDelegate mErrorCode], FAILURE_CODE,@"Fetch failure was passed through to delegate");
}

-(void)testNoErrorReceivedOn200Status
{
    [mESTRequestResponseManager downloadDataFromURL:[NSURL URLWithString:SAMPLE_URL]];
    ESTFakeResponse *fakeResponse = [[ESTFakeResponse alloc] initWithStatusCode:SUCCESS_CODE];
    [mESTRequestResponseManager connection: nil didReceiveResponse:fakeResponse];
    XCTAssertFalse(([mSampleDelegate mErrorCode] == SUCCESS_CODE),@"No need for error on 200 response");
}

- (void)testConnectionFailingPassesErrorToDelegate
{
    [mESTRequestResponseManager downloadDataFromURL:[NSURL URLWithString:SAMPLE_URL]];
    NSError *error = [NSError errorWithDomain: @"Fake domain" code: 12345 userInfo: nil];
    [mESTRequestResponseManager connection: nil didFailWithError: error];
    XCTAssertEqual([mSampleDelegate mErrorCode], 12345, @"Failure to connect should get passed to the delegate");
}

- (void)testSuccessfulDownloadedDataIsNotNil
{
    [mESTRequestResponseManager downloadDataFromURL:[NSURL URLWithString:SAMPLE_URL]];
    ESTFakeResponse *fakeResponse = [[ESTFakeResponse alloc] initWithStatusCode:SUCCESS_CODE];
    [mESTRequestResponseManager connection:nil didReceiveResponse:fakeResponse];
    [mESTRequestResponseManager connection:nil didReceiveData:[@"Hello" dataUsingEncoding: NSUTF8StringEncoding]];
    [mESTRequestResponseManager connectionDidFinishLoading: nil];
    XCTAssertNotNil([mSampleDelegate mDownloadedData], @"Data downloaded was nil");
}

- (void)testSuccessfulDownloadedDataPassingToDelegate
{
    [mESTRequestResponseManager downloadDataFromURL:[NSURL URLWithString:SAMPLE_URL]];
    ESTFakeResponse *fakeResponse = [[ESTFakeResponse alloc] initWithStatusCode:SUCCESS_CODE];
    [mESTRequestResponseManager connection:nil didReceiveResponse:fakeResponse];
    [mESTRequestResponseManager connection:nil didReceiveData:[@"Hello" dataUsingEncoding: NSUTF8StringEncoding]];
    [mESTRequestResponseManager connectionDidFinishLoading: nil];
    XCTAssertNotNil([mSampleDelegate mDownloadedData], @"Data downloaded was nil");
    NSString *theReceivedData = [[NSString alloc] initWithData:[mSampleDelegate mDownloadedData] encoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(theReceivedData, @"Hello",@"The delegate should have received data on success");
}
@end
