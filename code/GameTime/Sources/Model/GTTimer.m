//
//  GTTimer.m
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimer.h"
#import "GTPreferences.h"

@implementation GTTimer

+ (GTTimer*)timerWith:(NSInteger)player
{
    GTTimer *timer = [[GTTimer alloc] init];
    timer.name = [GTPreferences sharedInstance].defaultNames[player];
    timer.playerColor = [GTPreferences sharedInstance].defaultRowColors[player];
    
    timer.type = [GTPreferences sharedInstance].timerType;
    timer.state = GTTimerStatePaused;
    timer.position = player;
    switch (timer.type)
    {
            case GTTimerTypeCountDown:
            case GTTimerTypeCoundDownByTurn:
            timer.timeInSeconds = [GTPreferences sharedInstance].countDownTime;
            timer.subTime = (CGFloat)[GTPreferences sharedInstance].countDownTime;
            break;
        default:
            timer.subTime = 0.0;
            timer.timeInSeconds = 0;
            break;
    }
    
    return timer;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.playerColor forKey:@"playerColor"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInteger:self.type forKey:@"type"];
    [encoder encodeInteger:self.state forKey:@"state"];
    [encoder encodeInteger:self.position forKey:@"position"];
    [encoder encodeInteger:self.timeInSeconds forKey:@"timeInSeconds"];
    [encoder encodeFloat:self.subTime forKey:@"subTime"];
    [encoder encodeFloat:self.startTimeOffset forKey:@"startTimeOffset"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        //decode properties, other class vars
        self.playerColor = [decoder decodeObjectForKey:@"playerColor"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.type = [decoder decodeIntegerForKey:@"type"];
        self.state = [decoder decodeIntegerForKey:@"state"];
        self.position = [decoder decodeIntegerForKey:@"position"];
        self.timeInSeconds = [decoder decodeIntegerForKey:@"timeInSeconds"];
        self.subTime = [decoder decodeFloatForKey:@"subTime"];
        self.startTimeOffset = [decoder decodeFloatForKey:@"startTimeOffset"];
    }
    return self;
}

#pragma mark - Getters/Setters


+ (NSArray*)timerTypes
{
    return @[
             @{
                 @"name" : NSLocalizedString(@"Count Down By Turn", @"counting down time each turn, button text"),
                 @"description" : NSLocalizedString(@"Counts down for each player, resets automatically every turn.", @"description of couting down time each turn"),
                 @"type" : @0
              },

             @{
                 @"name" : NSLocalizedString(@"Count Down", @"counting down time, button text"),
                 @"description" : NSLocalizedString(@"Counts down for each player over the entire game.", @"description of counting text down time"),
                 @"type" : @1
              },

             @{
                 @"name" : NSLocalizedString(@"Count Up", @"time counting up, button text"),
                 @"description" : NSLocalizedString(@"Counts up for each player over the entire game.", @"description of time counting up"),
                 @"type" : @2
              }
             ];
}

@end
