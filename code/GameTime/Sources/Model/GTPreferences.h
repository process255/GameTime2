//
//  GTPreferences.h
//  GameTime
//
//  Created by Sean Dougherty on 1/8/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTTimer.h"

extern NSString* const kNumberOfPlayersChanged;
extern NSString* const kCountDownTimeChanged;


@interface GTPreferences : NSObject

@property (nonatomic, assign) NSInteger numberOfPlayers;
@property (nonatomic, assign) NSUInteger timerType;
@property (nonatomic, assign) BOOL helpViewed;
@property (nonatomic, copy) NSArray * defaultRowColors;
@property (nonatomic, copy) NSArray * defaultNames;
@property (nonatomic, copy) NSArray * playerColors;
@property (nonatomic, copy) NSArray * playerSelectionColors;
@property (nonatomic, assign) NSUInteger countDownTime;

- (GTTimer*)loadTimerForPlayer:(NSUInteger)player;
- (void)saveTimer:(GTTimer*)timer;
+ (GTPreferences*)sharedInstance;

@end
