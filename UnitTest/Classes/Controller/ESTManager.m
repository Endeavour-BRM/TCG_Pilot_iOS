// 
//  ESTManager.m
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved
 


#import "ESTManager.h"
#import "ESTRequestResponseHandler.h"
#import "ESTUserProfileManager.h" 


@implementation ESTManager

/***************************************************************************************
 * Method Name  : downloadContacts
 * Description  : Initializes the contacts data download.
 * Parameters   : None
 * Return value : None
 ***************************************************************************************/
-(void)downloadContacts
{
    ESTRequestResponseHandler *theReqResponseHandler = [[ESTRequestResponseHandler alloc] initWithDelegate:self];
    NSString *theContactsAPI = [self getContactsQueryAPI];
    NSURL *theContactsDownloadURL = [NSURL URLWithString:theContactsAPI];
    [theReqResponseHandler downloadDataFromURL:theContactsDownloadURL];
}

/***************************************************************************************
 * Method Name  : getContactsQueryAPI
 * Description  : Composes and returns the contacts Query API
 * Parameters   : None
 * Return value : NSString, the contact query API
 ***************************************************************************************/
-(NSString*)getContactsQueryAPI
{
    ESTUserProfileManager *theUserProfileManager = [[ESTUserProfileManager alloc]init];
    NSString *theUserID = [theUserProfileManager getCurrentlyLoggedInUserID];
    return [NSString stringWithFormat:@"%@contacts/?$filter=UserID+eq+%@",BASE_URL,theUserID];
}

/***************************************************************************************
 * Method Name  : dataDownloadCompleteWithStatusCode
 * Description  : Delegate method called after completing the data dwonload operation
 * Parameters   : (NSData)inData, the downloaded data
 * Return value : None
 ***************************************************************************************/
-(void)dataDownloadCompleteWithData:(NSData*)inData
{
    NSLog(@"Received data %@",inData);
}

/***************************************************************************************
 * Method Name  : dataDownloadFailedWithError
 * Description  : Delegate method called download operation failes
 * Parameters   : (NSError*)inError, the error object
 * Return value : None
 ***************************************************************************************/

-(void)dataDownloadFailedWithError:(NSError*)inError
{
    NSLog(@"Received Error %@",inError);
}
@end
