//
//  ESTRequestResponseHandler.h
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ESTDownloadDelegate;

@interface ESTRequestResponseHandler : NSObject<NSURLConnectionDelegate>
{
}
@property(nonatomic,readonly)NSData *downloadedData;
//Operations
-(id)initWithDelegate:(id<ESTDownloadDelegate>)inDelegate;
-(void)downloadDataFromURL:(NSURL*)inDownloadURL;
- (void)cancelAndDiscardURLConnection;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
@end
