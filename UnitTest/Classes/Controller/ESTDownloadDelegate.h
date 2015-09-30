//
//  ESTDownloadDelegate.h
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//   

#import <Foundation/Foundation.h>

@protocol ESTDownloadDelegate <NSObject>
@required
-(void)dataDownloadCompleteWithData:(NSData*)inData;
-(void)dataDownloadFailedWithError:(NSError*)inError;
@end
