//
//  GTTimeHelper.m
//  GameTime
//
//  Created by Sean Dougherty on 1/8/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimeHelper.h"

@implementation GTTimeHelper


+ (NSString*)timeAsHoursMinutesSeconds:(NSUInteger)timeInSeconds
                            forceHours:(BOOL)forceHours
{
    NSUInteger num_seconds = timeInSeconds;
    NSUInteger days = num_seconds / (60 * 60 * 24);
    num_seconds -= days * (60 * 60 * 24);
    NSUInteger hours = num_seconds / (60 * 60);
    num_seconds -= hours * (60 * 60);
    NSUInteger minutes = num_seconds / 60;
    num_seconds -= minutes * 60;
    
    NSString *hoursAsString;
    if (hours == 0)
    {
        hoursAsString = forceHours ? @"00:" : @"";
    }
    else if( hours < 10 )
    {
        hoursAsString = [NSString stringWithFormat:@"0%lu:", (unsigned long)hours];
    }
    else
    {
        hoursAsString = [NSString stringWithFormat:@"%lu:", (unsigned long)hours];
    }
    
    NSString *minutesAsString;
    if (minutes == 0)
    {
        minutesAsString = @"00:";
    }
    else if( minutes < 10 )
    {
        minutesAsString = [NSString stringWithFormat:@"0%lu:", (unsigned long)minutes];
    }
    else
    {
        minutesAsString = [NSString stringWithFormat:@"%lu:", (unsigned long)minutes];
    }
    
    NSString *secondsAsString;
    if (num_seconds == 0)
    {
        secondsAsString = @"00";
    }
    else if( num_seconds < 10 )
    {
        secondsAsString = [NSString stringWithFormat:@"0%lu", (unsigned long)num_seconds];
    }
    else
    {
        secondsAsString = [NSString stringWithFormat:@"%lu", (unsigned long)num_seconds];
    }
    
    NSString * time = [NSString stringWithFormat:@"%@%@%@", hoursAsString, minutesAsString, secondsAsString];
    
    return time;
}


+ (NSUInteger)hoursFromTimeInSeconds:(NSUInteger)timeInSeconds
{
    NSUInteger num_seconds = timeInSeconds;
    NSUInteger days = num_seconds / (60 * 60 * 24);
    num_seconds -= days * (60 * 60 * 24);
    NSUInteger hours = num_seconds / (60 * 60);
    
    return hours;
}

+ (NSUInteger)minutesFromTimeInSeconds:(NSUInteger)timeInSeconds
{
    NSUInteger num_seconds = timeInSeconds;
    NSUInteger days = num_seconds / (60 * 60 * 24);
    num_seconds -= days * (60 * 60 * 24);
    NSUInteger hours = num_seconds / (60 * 60);
    num_seconds -= hours * (60 * 60);
    NSUInteger minutes = num_seconds / 60;
    
    return minutes;
}

+ (NSUInteger)secondsFromTimeInSeconds:(NSUInteger)timeInSeconds
{
    NSUInteger num_seconds = timeInSeconds;
    NSUInteger days = num_seconds / (60 * 60 * 24);
    num_seconds -= days * (60 * 60 * 24);
    NSUInteger hours = num_seconds / (60 * 60);
    num_seconds -= hours * (60 * 60);
    NSUInteger minutes = num_seconds / 60;
    num_seconds -= minutes * 60;
    
    return num_seconds;
}

@end

