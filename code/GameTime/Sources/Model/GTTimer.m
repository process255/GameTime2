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

- (NSString*)description
{
    return [NSString stringWithFormat:@"position = %lu, name = %@", (unsigned long)self.position, self.name];
}

+ (GTTimer*)timerWith:(NSInteger)player
{
    GTTimer *timer = [[GTTimer alloc] init];
    timer.name = [[GTPreferences sharedInstance].defaultNames objectAtIndex:player];
    timer.playerColor = [[GTPreferences sharedInstance].defaultRowColors objectAtIndex:player];
    
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

//- (NSTimer*)timer
//{
//    if (!_timer)
//    {
//        _timer = [NSTimer timerWithTimeInterval:1.0 invocation:<#(NSInvocation *)#> repeats:<#(BOOL)#>]
//    }
//}

@end
