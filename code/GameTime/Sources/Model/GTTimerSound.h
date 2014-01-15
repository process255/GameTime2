//
//  GTTimerSound.h
//  GameTime
//
//  Created by Sean Dougherty on 1/13/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTTimerSound : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *file;

+ (GTTimerSound*)sound:(NSString*)file
                  name:(NSString*)name;

@end
