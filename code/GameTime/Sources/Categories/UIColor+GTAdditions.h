//
//  UIColor+GTAdditions.h
//  GameTime
//
//  Created by Sean Dougherty on 1/6/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GTAdditions)

+ (UIColor*)hex:(NSInteger)hex;
+ (UIColor*)hex:(NSInteger)hex alpha:(CGFloat)alpha;
- (UIColor*)withBrightness:(CGFloat)newBrightness;

@end
