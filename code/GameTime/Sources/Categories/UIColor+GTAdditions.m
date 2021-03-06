//
//  UIColor+GTAdditions.m
//  GameTime
//
//  Created by Sean Dougherty on 1/6/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "UIColor+GTAdditions.h"

@implementation UIColor (GTAdditions)

- (UIColor*)withBrightness:(CGFloat)newBrightness
{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    BOOL success = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    if (success)
    {
        brightness = newBrightness;
    }
    brightness = fmaxf(brightness, 0.0);
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

- (UIColor*)compatibleContrastedColor
{
    CGFloat alpha;
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    BOOL success = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    if (success)
    {
        BOOL isDark = brightness < 0.5;
        if (isDark)
        {
            brightness += 0.6;
            brightness = fminf(brightness, 1.0);
        }
        else
        {
            brightness -= 0.5;
            brightness = fmaxf(brightness, 0.0);
        }
    }

    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

- (UIColor*)darker
{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    BOOL success = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    if (success)
    {
        brightness = fmaxf(0.0, brightness - 0.20);
    }
    brightness = fmaxf(brightness, 0.0);

    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

@end
