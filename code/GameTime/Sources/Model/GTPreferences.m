//
//  GTPreferences.m
//  GameTime
//
//  Created by Sean Dougherty on 1/8/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTPreferences.h"
#import "GTPlayerColor.h"
#import "GTTimerSound.h"

const struct GTSounds GTSounds = {
	.smallBell = @"small-bell-ringing-02.wav",
	.buzzer1 = @"fail-buzzer-01.wav",
	.buzzer2 = @"fail-buzzer-02.wav",
	.buzzer3 = @"fail-buzzer-04.wav",
	.bell = @"bell-ringing-05.wav",
	.alarm = @"alarm-clock-01.wav",
};

NSString* const kNumberOfPlayersChanged = @"kNumberOfPlayersChanged";
NSString* const kCountDownTimeChanged = @"kCountDownTimeChanged";
NSString* const kTimerStartTapped = @"kTimerStartTapped";
NSString* const kTimerStopTapped = @"kTimerStopTapped";


@implementation GTPreferences

@synthesize numberOfPlayers             = _numberOfPlayers;
@synthesize defaultRowColors            = _defaultRowColors;
@synthesize playerColors                = _playerColors;
@synthesize defaultNames                = _defaultNames;
@synthesize timerType                   = _timerType;
@synthesize playerSelectionColors       = _playerSelectionColors;
@synthesize countDownTime               = _countDownTime;
@synthesize helpViewed                  = _helpViewed;
@synthesize volume                      = _volume;
@synthesize timerSound                  = _timerSound;

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

- (NSUInteger)numberOfPlayers
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *numberOfPlayers = [defaults objectForKey:@"numberOfPlayers"];
    if(numberOfPlayers != nil)
    {
        return [numberOfPlayers integerValue];
    }
    else
    {
        return 6;
    }
}

- (void)setNumberOfPlayers:(NSUInteger)value
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
        return [countDownTime integerValue];
    }
    else
    {
        return 10;
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

- (void)setTimerSound:(NSUInteger)timerSound
{
    if(_timerSound != timerSound)
    {
        _timerSound = timerSound;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithInteger:timerSound] forKey: @"timerSound"];
        [defaults synchronize];
    }
}

- (NSUInteger)timerSound
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *timerSound = [defaults objectForKey:@"timerSound"];
    if(timerSound != nil)
    {
        return [timerSound integerValue];
    }
    else
    {
        return 0;
    }
}


- (NSArray*)timerSounds
{
    if (!_timerSounds)
    {
        _timerSounds = @[[GTTimerSound sound:GTSounds.alarm name:NSLocalizedString(@"Alarm", nil)],
                         [GTTimerSound sound:GTSounds.bell name:NSLocalizedString(@"Bell", nil)],
                         [GTTimerSound sound:GTSounds.buzzer1 name:NSLocalizedString(@"Buzzer 1", nil)],
                         [GTTimerSound sound:GTSounds.buzzer2 name:NSLocalizedString(@"Buzzer 2", nil)],
                         [GTTimerSound sound:GTSounds.buzzer3 name:NSLocalizedString(@"Buzzer 3", nil)],
                         [GTTimerSound sound:GTSounds.smallBell name:NSLocalizedString(@"Small Bell", nil)]
                         ];
    }
    return _timerSounds;
}

- (void)setVolume:(CGFloat)volume
{
    if(_volume != volume)
    {
        _volume = volume;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithFloat:volume] forKey: @"volume"];
        [defaults synchronize];
    }
}

- (CGFloat)volume
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *volume = [defaults objectForKey:@"volume"];
    if(volume != nil)
    {
        return [volume floatValue];
    }
    else
    {
        return 0.25;
    }
}


- (NSUInteger)timerType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *timerType = [defaults objectForKey:@"timerType"];
    if(timerType != nil)
    {
        return [timerType integerValue];
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
        for( NSUInteger i=0 ; i < len ; i++)
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


- (NSArray*)playerColors
{
    if(_playerColors == nil)
    {
        _playerColors = @[
                         [GTPlayerColor bgColor:[UIColor hex:0x00ffba]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:.25]
                                progressColor:[UIColor hex:0x828282]
                               textFieldBgColor:[UIColor hex:0xd2d2d2]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x00d2ff]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0xc8c8c8]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0x1f61ff]
                              inactiveNameColor:[UIColor hex:0xffffff alpha:0.9]
                                activeNameColor:[UIColor hex:0xffffff]
                               activeTimerColor:[UIColor hex:0xffffff]
                             inactiveTimerColor:[UIColor hex:0xffffff alpha:0.1]
                                progressColor:[UIColor hex:0xc8c8c8]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0xae46f9]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x452506]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0xff2d66]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x84151d]
                               textFieldBgColor:[UIColor hex:0xffffff]],
                         
                         [GTPlayerColor bgColor:[UIColor hex:0xffae2d]
                              inactiveNameColor:[UIColor hex:0x000000 alpha:1.0]
                                activeNameColor:[UIColor hex:0x000000]
                               activeTimerColor:[UIColor hex:0x000000]
                             inactiveTimerColor:[UIColor hex:0x000000 alpha:0.1]
                                progressColor:[UIColor hex:0x93650e]
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
