//
//  GTTimerCell.m
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimerCell.h"
#import "GTTimeController.h"
#import "GTTimer.h"
#import "GTPreferences.h"
#import "GTTimeHelper.h"
#import "GTPlayerColor.h"


@implementation GTTimerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(timeTicReceived:)
                                                 name:kGGTimeTicNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(subTimeTicReceived:)
                                                 name:kGGTimeSubTicNotification
                                               object:nil];
}


-(void)timeTicReceived:(NSNotification *) notification
{
    if(self.timer.state != GTTimerStateStarted) return;
    switch (self.timer.type)
    {
        case GTTimerTypeCoundDownByTurn:
        {
            if(self.timer.timeInSeconds > 0)
            {
                if(self.timer.timeInSeconds == 1)
                {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kPlayBellSoundNotification object:self];
                }
                [self updateTimer:self.timer.timeInSeconds - 1 shouldSave:YES updateSubTime:NO];
            }
            break;
        }
        case GTTimerTypeCountDown:
        {
            if(self.timer.timeInSeconds > 0)
            {
                if(self.timer.timeInSeconds == 1)
                {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kPlayBellSoundNotification object:self];
                }
                [self updateTimer:self.timer.timeInSeconds - 1 shouldSave:YES updateSubTime:NO];
            }
            break;
        }
        case GTTimerTypeCountUp:
            [self updateTimer:self.timer.timeInSeconds + 1 shouldSave:YES updateSubTime:NO];
            break;
    }
}

-(void)subTimeTicReceived:(NSNotification *) notification
{
    if(self.timer.state != GTTimerStateStarted) return;

    switch (self.timer.type)
    {
        case GTTimerTypeCoundDownByTurn:
        case GTTimerTypeCountDown:
        {
            if(self.timer.subTime > 0)
            {
                self.timer.subTime -= kSubTimeIncrement;
            }
            CGFloat timeLeftAsFloat = self.timer.subTime / (CGFloat)[GTPreferences sharedInstance].countDownTime;
            CGFloat width = self.frame.size.width - (self.frame.size.width * timeLeftAsFloat);
            self.progressViewWidthConstraint.constant = width;
            break;
        }
        case GTTimerTypeCountUp:
            break;
    }
}

#pragma mark - Public Methods

- (void)stop
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)start
{
    [self setupObservers];
}

- (void)setActive
{
    self.timer.state = GTTimerStateStarted;
    [[GTPreferences sharedInstance] saveTimer:self.timer];
}

- (void)setInactive
{
    self.timer.state = GTTimerStatePaused;
    [[GTPreferences sharedInstance] saveTimer:self.timer];
}


#pragma mark - Private Methods

- (void)updateTimer:(NSUInteger)timeInSeconds
         shouldSave:(BOOL)shouldSave
      updateSubTime:(BOOL)updateSubTime
{
    self.timer.timeInSeconds = timeInSeconds;
    if(updateSubTime)
    {
        self.timer.subTime = (CGFloat)timeInSeconds;
    }
    
    self.timerLabel.text = [GTTimeHelper timeAsHoursMinutesSeconds:self.timer.timeInSeconds forceHours:NO];
    if(shouldSave)
    {
        [[GTPreferences sharedInstance] saveTimer:self.timer];
    }
    
}

#pragma mark - Getters/Setters

- (void)setTimer:(GTTimer *)timer
{
    _timer = nil;
    _timer = timer;
    self.nameLabel.text = timer.name;
    self.timerLabel.text = [GTTimeHelper timeAsHoursMinutesSeconds:timer.timeInSeconds forceHours:NO];
    self.contentView.backgroundColor = timer.playerColor.rowBackgroundColor;
    self.progressView.backgroundColor = timer.playerColor.progressColor;
}

@end
