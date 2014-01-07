//
//  GTTimer.m
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimer.h"

@implementation GTTimer

- (NSString*)description
{
    return [NSString stringWithFormat:@"position = %lu, name = %@", (unsigned long)self.position, self.name];
}

@end
