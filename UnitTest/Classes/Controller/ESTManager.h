//
//  ESTManager.h
//  UnitTest
//
//  Created by Maithri VM on 25/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
// 


#import <Foundation/Foundation.h>
#import "ESTDownloadDelegate.h"
@interface ESTManager : NSObject <ESTDownloadDelegate>
-(void)downloadContacts;
@end
