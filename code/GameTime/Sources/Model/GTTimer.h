//
//  GTTimer.h
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

typedef enum GTTimerState {
    GTTimerStateStopped = 0,
    GTTimerStateStarted,
    GTTimerStatePaused
} GTTimerState;

typedef enum GTTimerType {
    GTTimerTypeCoundDownByTurn,
    GTTimerTypeCountDown,
    GTTimerTypeCountUp
} GTTimerType;

#import <Foundation/Foundation.h>

@class GTPlayerColor;


@interface GTTimer : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger position;
@property (nonatomic, assign) GTTimerType type;
@property (nonatomic, strong) GTPlayerColor *playerColor;
@property (nonatomic, assign) GTTimerState state;
@property (nonatomic, assign) NSUInteger timeInSeconds;
@property (nonatomic, assign) CGFloat subTime;
@property (nonatomic, assign) CGFloat startTimeOffset;
@property (nonatomic, strong) NSTimer *timer;

+ (GTTimer*)timerWith:(NSInteger)player;
+ (NSArray*)timerTypes;

@end
