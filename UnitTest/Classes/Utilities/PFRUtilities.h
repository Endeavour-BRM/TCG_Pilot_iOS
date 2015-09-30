//
//  PFRUtilities.m
//  Unit test sample
//
//  Created by Maithri V M on 13/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
// 

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PFRUtilities : NSObject
@property(nonatomic,strong)NSArray *mListOfUsers;
+(UIColor*) colorWithHexString :(NSString*)aHexString andAlpha :(CGFloat)anAlphaValue;
+(NSString*)getUTCFormateDate:(NSDate *)localDate;
+(BOOL)areNumbersEqual:(NSNumber*)num1 :(NSNumber*)num2;
-(NSString*)getCurrentlyLoggedInUserName;
@end
