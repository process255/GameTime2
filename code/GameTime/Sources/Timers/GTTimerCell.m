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
#import <QuartzCore/QuartzCore.h>
#import "UIColor+GTAdditions.h"
#import "GTProgressView.h"
#import "GTTimerSound.h"
#import "SKTAudio.h"

@interface GTTimerCell()

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapGesture;

@end


@implementation GTTimerCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

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
                    GTTimerSound *timerSound = [GTPreferences sharedInstance].timerSounds[[GTPreferences sharedInstance].timerSound];
                    [[SKTAudio sharedInstance] playSoundEffect:timerSound.file
                                                        volume:[GTPreferences sharedInstance].volume];
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
                    GTTimerSound *timerSound = [GTPreferences sharedInstance].timerSounds[[GTPreferences sharedInstance].timerSound];
                    [[SKTAudio sharedInstance] playSoundEffect:timerSound.file
                                                        volume:[GTPreferences sharedInstance].volume];
                    [self setInactive];
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
            [self updateProgressView];
            break;
        }
        case GTTimerTypeCountUp:
            break;
    }
}

- (void)updateProgressView
{
    CGFloat timeLeftAsFloat = self.timer.subTime / (CGFloat)[GTPreferences sharedInstance].countDownTime;
    CGFloat width = self.frame.size.width - (self.frame.size.width * timeLeftAsFloat);
    self.progressViewWidthConstraint.constant = width;
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
    self.nameLabel.font = [UIFont activeNameFont];
    self.timerLabel.font = [UIFont activeTimerFont];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTimerStartTapped object:self];
    self.timer.state = GTTimerStateStarted;
    [[GTPreferences sharedInstance] saveTimer:self.timer];
}

- (void)setInactive
{
    self.timer.state = GTTimerStatePaused;
    [[NSNotificationCenter defaultCenter] postNotificationName:kTimerStopTapped object:self];
    [[GTPreferences sharedInstance] saveTimer:self.timer];
    self.nameLabel.font = [UIFont nameFont];
    self.timerLabel.font = [UIFont timerFont];
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

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)setTimer:(GTTimer *)timer
{
    _timer = nil;
    _timer = timer;

    UIColor *darkerColor = [timer.playerColor.rowBackgroundColor darker];

    self.nameLabel.font = [UIFont nameFont];
    self.timerLabel.font = [UIFont timerFont];
    
    self.timerLabel.textColor = [darkerColor compatibleContrastedColor];
    self.nameLabel.textColor = [timer.playerColor.rowBackgroundColor compatibleContrastedColor];
    self.nameLabel.text = timer.name;
    self.timerLabel.text = [GTTimeHelper timeAsHoursMinutesSeconds:timer.timeInSeconds forceHours:NO];
    
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint   = CGPointMake(1, 0.5);

    self.gradientLayer.colors = @[(id)[darkerColor CGColor], (id)[timer.playerColor.rowBackgroundColor CGColor]];
    self.progressView.color = timer.playerColor.rowBackgroundColor;

    [self updateProgressView];
}

@end
