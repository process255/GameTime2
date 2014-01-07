//
//  GTPlayerColor.m
//  GameTime
//
//  Created by Sean Dougherty on 1/6/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTPlayerColor.h"

@implementation GTPlayerColor

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.rowBackgroundColor forKey:@"rowBackgroundColor"];
    [encoder encodeObject:self.inactiveNameColor forKey:@"inactiveNameColor"];
    [encoder encodeObject:self.activeNameColor forKey:@"activeNameColor"];
    [encoder encodeObject:self.activeTimerColor forKey:@"activeTimerColor"];
    [encoder encodeObject:self.inactiveTimerColor forKey:@"inactiveTimerColor"];
    [encoder encodeObject:self.disclosureColor forKey:@"disclosureColor"];
    [encoder encodeObject:self.textFieldBgColor forKey:@"textFieldBgColor"];
    
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        //decode properties, other class vars
        self.rowBackgroundColor = [decoder decodeObjectForKey:@"rowBackgroundColor"];
        self.inactiveNameColor = [decoder decodeObjectForKey:@"inactiveNameColor"];
        self.activeNameColor = [decoder decodeObjectForKey:@"activeNameColor"];
        self.activeTimerColor = [decoder decodeObjectForKey:@"activeTimerColor"];
        self.inactiveTimerColor = [decoder decodeObjectForKey:@"inactiveTimerColor"];
        self.disclosureColor = [decoder decodeObjectForKey:@"disclosureColor"];
        self.textFieldBgColor = [decoder decodeObjectForKey:@"textFieldBgColor"];        
    }
    return self;
}

@end
