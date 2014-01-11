//
//  GTTimeHelper.h
//  GameTime
//
//  Created by Sean Dougherty on 1/8/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTTimeHelper : NSObject

+ (NSString*)timeAsHoursMinutesSeconds:(NSUInteger)timeInSeconds
                            forceHours:(BOOL)forceHours;
+ (NSUInteger)hoursFromTimeInSeconds:(NSUInteger)timeInSeconds;
+ (NSUInteger)minutesFromTimeInSeconds:(NSUInteger)timeInSeconds;
+ (NSUInteger)secondsFromTimeInSeconds:(NSUInteger)timeInSeconds;

@end
