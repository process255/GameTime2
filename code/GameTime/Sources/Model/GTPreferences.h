//
//  GTPreferences.h
//  GameTime
//
//  Created by Sean Dougherty on 1/8/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTTimer.h"

extern const struct GTSounds {
	__unsafe_unretained NSString *smallBell;
	__unsafe_unretained NSString *buzzer1;
	__unsafe_unretained NSString *buzzer2;
	__unsafe_unretained NSString *buzzer3;
	__unsafe_unretained NSString *bell;
	__unsafe_unretained NSString *alarm;
} GTSounds;

extern NSString* const kNumberOfPlayersChanged;
extern NSString* const kCountDownTimeChanged;
extern NSString* const kTimerStopTapped;
extern NSString* const kTimerStartTapped;

@interface GTPreferences : NSObject

@property (nonatomic, assign) NSUInteger numberOfPlayers;
@property (nonatomic, assign) NSUInteger timerSound;
@property (nonatomic, assign) CGFloat volume;
@property (nonatomic, assign) NSUInteger timerType;
@property (nonatomic, assign) BOOL helpViewed;
@property (nonatomic, copy) NSArray * defaultRowColors;
@property (nonatomic, copy) NSArray * defaultNames;
@property (nonatomic, copy) NSArray * playerColors;
@property (nonatomic, copy) NSArray * timerSounds;
@property (nonatomic, copy) NSArray * playerSelectionColors;
@property (nonatomic, assign) NSUInteger countDownTime;

- (GTTimer*)loadTimerForPlayer:(NSUInteger)player;
- (void)saveTimer:(GTTimer*)timer;
+ (GTPreferences*)sharedInstance;

@end
