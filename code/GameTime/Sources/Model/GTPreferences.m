//
//  GTPreferences.m
//  GameTime
//
//  Created by Sean Dougherty on 1/8/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTPreferences.h"
#import "GTPlayerColor.h"

NSString* const kNumberOfPlayersChanged = @"kNumberOfPlayersChanged";
NSString* const kCountDownTimeChanged = @"kCountDownTimeChanged";


@implementation GTPreferences

@synthesize numberOfPlayers             = _numberOfPlayers;
@synthesize defaultRowColors            = _defaultRowColors;
@synthesize playerColors                = _playerColors;
@synthesize defaultNames                = _defaultNames;
@synthesize timerType                   = _timerType;
@synthesize playerSelectionColors       = _playerSelectionColors;
@synthesize countDownTime               = _countDownTime;
@synthesize helpViewed                  = _helpViewed;

#pragma mark - Initialization

+ (GTPreferences*)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


#pragma mark - Getters/Setters

- (NSInteger)numberOfPlayers
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *numberOfPlayers = [defaults objectForKey:@"numberOfPlayers"];
    if(numberOfPlayers != nil)
    {
        return [numberOfPlayers intValue];
    }
    else
    {
        return 2;
    }
}

- (void)setNumberOfPlayers:(NSInteger)value
{
    if(_numberOfPlayers != value)
    {
        _numberOfPlayers = value;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithInteger:value] forKey: @"numberOfPlayers"];
        [defaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNumberOfPlayersChanged object:self];
    }
}

- (BOOL)helpViewed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *helpViewed = [defaults objectForKey:@"helpViewed"];
    if(helpViewed != nil)
    {
        return [helpViewed boolValue];
    }
    else
    {
        return NO;
    }
}

- (void)setHelpViewed:(BOOL)value {
    if(_helpViewed != value)
    {
        _helpViewed = value;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:value] forKey: @"helpViewed"];
        [defaults synchronize];
    }
}

- (NSUInteger)countDownTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *countDownTime = [defaults objectForKey:@"countDownTime"];
    if(countDownTime != nil)
    {
        return [countDownTime intValue];
    }
    else
    {
        return 60;
    }
}

- (void)setCountDownTime:(NSUInteger)value
{
    if(_countDownTime != value)
    {
        _countDownTime = value;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithInteger:value] forKey: @"countDownTime"];
        [defaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:kCountDownTimeChanged object:self];
    }
}

- (NSUInteger)timerType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *timerType = [defaults objectForKey:@"timerType"];
    if(timerType != nil)
    {
        return [timerType intValue];
    }
    else
    {
        return 0;
    }
}

- (void)setTimerType:(NSUInteger)timerType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:timerType] forKey: @"timerType"];
    [defaults synchronize];
}

- (GTTimer*)loadTimerForPlayer:(NSUInteger)player
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedTimer = [defaults objectForKey:[NSString stringWithFormat:@"player%luTimer", (unsigned long)player]];
    GTTimer *timer = (GTTimer *)[NSKeyedUnarchiver unarchiveObjectWithData: encodedTimer];
    return timer;
}

- (void)saveTimer:(GTTimer*)timer
{
    NSData *encodedTimer = [NSKeyedArchiver archivedDataWithRootObject:timer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedTimer forKey:[NSString stringWithFormat:@"player%luTimer", (unsigned long)timer.position]];
    [defaults synchronize];
}

- (NSArray*)defaultRowColors
{
    if(_defaultRowColors == nil)
    {
        NSMutableArray *defColors = [NSMutableArray arrayWithCapacity:6];
        NSUInteger len = [self.playerColors count];
        for( NSUInteger i=4 ; i < len ; i++)
        {
            [defColors addObject:[self.playerColors objectAtIndex:i]];
        }
        _defaultRowColors = [defColors copy];
    }
    
    return _defaultRowColors;
}

- (NSArray*)playerSelectionColors
{
    if(_playerSelectionColors == nil)
    {
        _playerSelectionColors = @[[UIColor hex:0xc3dfe9],
                                   [UIColor hex:0x9fcbdd],
                                   [UIColor hex:0x7bb8d0],
                                   [UIColor hex:0x57a4c3],
                                   [UIColor hex:0x3391b6],
                                   [UIColor hex:0x0f7ea9]];
    }
    return _playerSelectionColors;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray*)playerColors {
    if(_playerColors == nil){
        _playerColors = @[
                         [GTPlayerColor bgColor:[UIColor hex:0xffffff]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:.25]
                                progressColor:[UIColor hex:0x828282]
                               textFieldBgColor:[UIColor hex:0xd2d2d2]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x8f8f8f]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0xc8c8c8]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x00000]
                              inactiveNameColor:[UIColor hex:0xffffff alpha:0.9]
                                activeNameColor:[UIColor hex:0xffffff]
                               activeTimerColor:[UIColor hex:0xffffff]
                             inactiveTimerColor:[UIColor hex:0xffffff alpha:0.1]
                                progressColor:[UIColor hex:0xc8c8c8]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x603913]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x452506]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0xCC202D]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x84151d]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0xF7AB1B]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x93650e]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0xFCEE1F]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0xb4aa18]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x33A849]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x1c6129]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x065AA7]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x074681]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x5E2C84]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x472065]
                               textFieldBgColor:[UIColor hex:0xffffff]]];
    }
    return _playerColors;
}

- (NSArray*)defaultNames
{
    if(_defaultNames == nil)
    {
        NSString* player = NSLocalizedString(@"Player", @"default for player");
        _defaultNames = @[
                         [NSString stringWithFormat:@"%@ %@", player, NSLocalizedString(@"1", @"the number 1")],
                         [NSString stringWithFormat:@"%@ %@", player, NSLocalizedString(@"2", @"the number 2")],
                         [NSString stringWithFormat:@"%@ %@", player, NSLocalizedString(@"3", @"the number 3")],
                         [NSString stringWithFormat:@"%@ %@", player, NSLocalizedString(@"4", @"the number 4")],
                         [NSString stringWithFormat:@"%@ %@", player, NSLocalizedString(@"5", @"the number 5")],
                         [NSString stringWithFormat:@"%@ %@", player, NSLocalizedString(@"6", @"the number 6")]];
    }
    return _defaultNames;
}


@end
