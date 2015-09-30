//
//  ESTGcovTestObserver.m
//  UnitTest
//
//  Created by Maithri VM on 26/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ESTGcovTestObserver : XCTestObserver

@end

@implementation ESTGcovTestObserver

- (void) stopObserving
{
    [super stopObserving];
    UIApplication* application = [UIApplication sharedApplication];
    [application.delegate applicationWillTerminate:application];
}

@end
