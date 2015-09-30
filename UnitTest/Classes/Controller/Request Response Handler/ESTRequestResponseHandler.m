//
//  ESTRequestResponseHandler.m
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//   


#import "ESTRequestResponseHandler.h"
#import "ESTDownloadDelegate.h"
#define ESTCommunicatorErrorDomain @"ESTCommunicatorErrorDomain"
#define SUCCESS_CODE 200
@interface ESTRequestResponseHandler()
{
    NSURLConnection *mFetchingConnection;
    NSMutableData *mReceivedData;

}
//Attributes
@property(nonatomic,weak)id<ESTDownloadDelegate> mDelegate;
@end
@implementation ESTRequestResponseHandler
@synthesize downloadedData = mReceivedData;
/***************************************************************************************
 * Method Name  : initWithDelegate
 * Description  : Initializes the ESTRequestResponseHandler object with given delegate
 * Parameters   : (id<ESTDownloadDelegate>)inDelegate, the delegate object.
 * Return value : id, the reference to self
 ***************************************************************************************/
-(id)initWithDelegate:(id<ESTDownloadDelegate>)inDelegate
{
    if (self = [super init])
    {
        self.mDelegate = inDelegate;
    }
    return self;
}

/***************************************************************************************
 * Method Name  : downloadDataFromURL
 * Description  : Downloads data from given URL, by initializing the URL connection object with appropriate request
 * Parameters   : (NSURL*)inDownloadURL, the URL for data request.
 * Return value : None
 ***************************************************************************************/
-(void)downloadDataFromURL:(NSURL*)inDownloadURL
{

    NSMutableURLRequest *therequest = [[NSMutableURLRequest alloc] initWithURL:inDownloadURL
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:50.0];
    
    [therequest setHTTPMethod:@"GET"];
    
    [therequest setAllHTTPHeaderFields:@{
                                         @"AuthenticationToken":@"4f42fe50-6782-45c6-ac6f-c612c067f93b",
                                         @"Content-type":@"application/json",
                                         }];

    mFetchingConnection= [[NSURLConnection alloc] initWithRequest:therequest delegate:self startImmediately:NO];
    [mFetchingConnection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [mFetchingConnection start];
}

/***************************************************************************************
 * Method Name  : connection:didReceiveResponse:
 * Description  : This is URLConnectionDelegate method, called on receiving response
 * Parameters   : (NSURLConnection *)connection, the connection object; (NSURLResponse *)response, the response.
 * Return value : None
 ***************************************************************************************/
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    mReceivedData = nil;
    NSHTTPURLResponse *theHTTPResponse = ((NSHTTPURLResponse*)response);
    
    if ([theHTTPResponse statusCode] != SUCCESS_CODE)
    {
        NSError *error = [NSError
                          errorWithDomain:ESTCommunicatorErrorDomain
                          code:[theHTTPResponse statusCode]
                          userInfo:nil];
        [self dataDownloadFailedWithError:error];
        [self cancelAndDiscardURLConnection];
      
    }
    else
    {
        mReceivedData = [[NSMutableData alloc] init];
        [mReceivedData setLength:0];
    }

    NSLog(@"Status code = %d %@",theHTTPResponse.statusCode,[NSHTTPURLResponse localizedStringForStatusCode:theHTTPResponse.statusCode]);

    
}

- (void)cancelAndDiscardURLConnection
{
    [mFetchingConnection cancel];
    mFetchingConnection = nil;
}

/***************************************************************************************
 * Method Name  : connection:didReceiveData:
 * Description  : This is URLConnectionDelegate method, called on receiving data
 * Parameters   : (NSURLConnection *)connection, the connection object; (NSData *)data, the data received.
 * Return value : None
 ***************************************************************************************/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mReceivedData appendData:data];
    
}

/***************************************************************************************
 * Method Name  : connection:didFailWithError:
 * Description  : This is URLConnectionDelegate method, called on receiving error
 * Parameters   : (NSURLConnection *)connection, the connection object; (NSError *)error, the error object.
 * Return value : None
 ***************************************************************************************/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Did fail with error = %@",error);
    mReceivedData = nil;
    mFetchingConnection = nil;
    [self dataDownloadFailedWithError:error];

}

/***************************************************************************************
 * Method Name  : connectionDidFinishLoading:
 * Description  : This is URLConnectionDelegate method, called after finishing loaidng successfully
 * Parameters   : (NSURLConnection *)connection, the connection object.
 * Return value : None
 ***************************************************************************************/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    mFetchingConnection = nil;
    [self dataDownloadRequestCompleted];
}

/***************************************************************************************
 * Method Name  : dataDownloadRequestCompleted:
 * Description  : This method calls the corresponding delegate method on download completion
 * Parameters   : None
 * Return value : None
 ***************************************************************************************/
-(void)dataDownloadRequestCompleted
{
    [self.mDelegate dataDownloadCompleteWithData:mReceivedData];
}


/***************************************************************************************
 * Method Name  : dataDownloadFailedWithError:
 * Description  : This method is called on download failure and this calls the corresponding delegate method
 * Parameters   : (NSError*)inError, the error object
 * Return value : None
 ***************************************************************************************/
-(void)dataDownloadFailedWithError:(NSError*)inError
{
    [self.mDelegate dataDownloadFailedWithError:inError];
}

@end
