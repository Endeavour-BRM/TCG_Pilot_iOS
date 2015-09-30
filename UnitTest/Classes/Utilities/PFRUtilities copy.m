//
//  PFRUtilities.m
//  Unit test sample 
//
//  Created by Maithri V M on 13/11/13.
//  Copyright (c) 2013 Maithri VM. All rights reserved.
//
 
#import "PFRUtilities copy.h"

@implementation PFRUtilities1

#pragma mark-------------------Color from hestring methods---------------------

/***************************************************************************************
 * Method Name  : colorWithHexString : andAlpha :
 * Description  : Get UIcolor from the hexadecimal string.
 * Parameters   : (NSString*)aHexString and (CGFloat)anAlphaValue
 * Return value : UIColor
 ***************************************************************************************/
+(UIColor*) colorWithHexString :(NSString*)aHexString andAlpha :(CGFloat)anAlphaValue
{
    CGFloat theRed, theBlue, theGreen =0.0f;
    theRed   = [self colorComponentFrom: aHexString start: 0 length: 2];
    theGreen = [self colorComponentFrom: aHexString start: 2 length: 2];
    theBlue  = [self colorComponentFrom: aHexString start: 4 length: 2];
    UIColor *theColor =[UIColor colorWithRed:theRed green:theGreen blue:theBlue alpha:anAlphaValue];
    return theColor;
}


/***************************************************************************************
 * Method Name  : colorComponentFrom : start : length:
 * Description  : Parse to get color components from the string.
 * Parameters   : (NSString *) string (NSUInteger) start and (NSUInteger) length
 * Return value : CGFloat
 ***************************************************************************************/
+(CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *theSubstring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? theSubstring : [NSString stringWithFormat: @"%@%@", theSubstring, theSubstring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

/***************************************************************************************
 * Method Name  : getUTCFormateDate :
 * Description  : Gives Date time string in UTC timezone for the given Date object.
 * Parameters   : (NSDate *)localDate, the input date
 * Return value : NSString of the UTC date time
 ***************************************************************************************/
+(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

/***************************************************************************************
 * Method Name  : areNumbersEqual :
 * Description  : Checks for the equality of given numebr objects
 * Parameters   : (NSNumber*)num1 :(NSNumber*)num2, the two number objects to be compared
 * Return value : BOOL, the equality status
 ***************************************************************************************/
+ (BOOL)areNumbersEqual:(NSNumber*)num1 :(NSNumber*)num2
{
    return [num1 isEqual:num2];
}

/***************************************************************************************
 * Method Name  : getCurrentlyLoggedInUserName :
 * Description  : Returns the currently logged in User name
 * Parameters   : None
 * Return value : NSString, the currently logged in user name
 ***************************************************************************************/
-(NSString*)getCurrentlyLoggedInUserName
{
    if ([self fecthListOfUsers].count < 1)
    {
        [NSException raise:NSRangeException format:@"Index beyond bounds"];
        return nil;
    }
    return [[self fecthListOfUsers] objectAtIndex:0];
}

/***************************************************************************************
 * Method Name  : fecthListOfUsers :
 * Description  : Returns the list of all the users initialized with this object
 * Parameters   : None
 * Return value : NSArray, the array of logged in users.
 ***************************************************************************************/
-(NSArray*)fecthListOfUsers
{
    return self.mListOfUsers;
}

+(UIColor*) JustToBreakLongLineConditionColorWithHexString :(NSString*)aHexString andAlpha :(CGFloat)anAlphaValue
{
    return nil;
}
@end
