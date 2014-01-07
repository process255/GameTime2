//
//  GTTimer.h
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTPlayerColor;


@interface GTTimer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger position;
@property (nonatomic, strong) GTPlayerColor *playerColor;

@end
