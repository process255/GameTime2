//
//  GTTextField.m
//  GameTime
//
//  Created by Sean Dougherty on 1/17/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTextField.h"
#import <QuartzCore/QuartzCore.h>


@implementation GTTextField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        self.layer.borderWidth = 1;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 10);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 10);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 10);
}

@end
