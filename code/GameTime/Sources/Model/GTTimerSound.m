//
//  GTTimerSound.m
//  GameTime
//
//  Created by Sean Dougherty on 1/13/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimerSound.h"

@implementation GTTimerSound

+ (GTTimerSound*)sound:(NSString*)file
                  name:(NSString*)name
{
    GTTimerSound *timerSound = [[GTTimerSound alloc] init];
    timerSound.name = name;
    timerSound.file = file;
    return timerSound;
}

@end
