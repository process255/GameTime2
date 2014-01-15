//
//  GTProgressView.m
//  GameTime
//
//  Created by Sean Dougherty on 1/13/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTProgressView.h"
#import "UIColor+GTAdditions.h"

@interface GTProgressView()

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

@end

@implementation GTProgressView

- (void)layoutSubviews
{
    self.layer.frame = self.bounds;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)setColor:(UIColor *)color
{
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint   = CGPointMake(1, 0.5);
    
    UIColor *darkColor = [color withBrightness:.50];
    
    UIColor *darkerColor = [color withBrightness:.80];
    
    self.gradientLayer.colors = @[(id)[darkColor CGColor], (id)[darkerColor CGColor]];
}

@end
