//
//  UIScreen+GTAdditions.m
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "UIScreen+GTAdditions.h"

@implementation UIScreen (GTAdditions)

+ (CGFloat)screenWidth {
    return [self mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [self mainScreen].bounds.size.height;
}

+ (CGSize)screenSize {
    return [self mainScreen].bounds.size;
}

+ (CGRect)screenFrame {
    return [self mainScreen].bounds;
}

@end
