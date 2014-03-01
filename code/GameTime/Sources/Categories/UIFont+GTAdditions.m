//
//  UIFont+GTAdditions.m
//  GameTime
//
//  Created by Sean Dougherty on 1/16/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "UIFont+GTAdditions.h"

@implementation UIFont (GTAdditions)

+ (UIFont*)activeNameFont
{
    NSUInteger size = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 25 : 50;
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont*)nameFont
{
    NSUInteger size = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 25 : 50;
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont*)timerFont
{
    NSUInteger size = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 40 : 80;
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}


+ (UIFont*)activeTimerFont
{
    NSUInteger size = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 40 : 80;
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont*)hiddenTimerButtonFont
{
    NSUInteger size = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 15 : 30;
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

@end
