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

//const CGFloat kRevealWidth = 160;
NSString * const RevealCellDidOpenNotification = @"RevealCellDidOpenNotification";

@interface GTTimerCell()<UIScrollViewDelegate>
{
    BOOL _isOpen;
}


@property (nonatomic, readonly) CAGradientLayer *gradientLayer;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *innerContentView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *innerContentWidthContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *innerContentHeightContraint;
@property (nonatomic, strong) UIView *buttonContainerView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *colorButton;

@end


@implementation GTTimerCell

- (void)awakeFromNib
{
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.titleLabel.font = [UIFont hiddenTimerButtonFont];
    self.editButton.backgroundColor = [UIColor hex:0x848082];
    self.editButton.frame = CGRectMake(0, 0, self.bounds.size.width / 2.0, self.contentView.frame.size.height);
    [self.editButton addTarget:self action:@selector(editButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton setTitle:NSLocalizedString(@"Name", nil) forState:UIControlStateNormal];

    self.colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.colorButton.titleLabel.font = [UIFont hiddenTimerButtonFont];
    self.colorButton.backgroundColor = [UIColor whiteColor];
    self.colorButton.frame = CGRectMake(self.editButton.frame.size.width, 0, self.bounds.size.width / 2.0, self.contentView.frame.size.height);
    [self.colorButton setTitle:NSLocalizedString(@"Color", nil) forState:UIControlStateNormal];
    [self.colorButton setTitleColor:self.editButton.backgroundColor forState:UIControlStateNormal];
    [self.colorButton addTarget:self action:@selector(colorButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    self.buttonContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width/2, self.colorButton.frame.size.height)];
    [self.buttonContainerView addSubview:self.editButton];
    [self.buttonContainerView addSubview:self.colorButton];

    [self.scrollView insertSubview:self.buttonContainerView
                      belowSubview:self.innerContentView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onOpen:)
                                                 name:RevealCellDidOpenNotification
                                               object:nil];
}

- (void)onOpen:(NSNotification *)notification
{
    if (notification.object != self)
    {
        if (_isOpen)
        {
            [self close];
        }
    }
}

- (void)close
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25
                         animations:^{
                             self.scrollView.contentOffset = CGPointZero;
                         }];
    });
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.innerContentWidthContraint.constant = self.bounds.size.width;
    self.innerContentHeightContraint.constant = self.bounds.size.height;
    self.innerContentView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.editButton.frame = CGRectMake(0, 0, self.bounds.size.width/4, self.bounds.size.height);
    self.colorButton.frame = CGRectMake(self.bounds.size.width * .25, 0, self.bounds.size.width/4, self.bounds.size.height);
    self.buttonContainerView.frame = CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.colorButton.frame.size.height);
    DDLogVerbose(@"color button frame = %@", NSStringFromCGRect(self.editButton.frame));
    self.contentView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width + self.bounds.size.width/2, self.bounds.size.height);
//    DDLogVerbose(@"contentSize = %@", NSStringFromCGSize(self.scrollView.contentSize));
    [self repositionButtons];
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
    return (CAGradientLayer *)self.innerContentView.layer;
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

    self.backgroundColor = timer.playerColor.rowBackgroundColor;
    [self updateProgressView];
}

- (void)repositionButtons
{
    CGRect frame = self.buttonContainerView.frame;
    frame.origin.x = self.contentView.frame.size.width - self.bounds.size.width/2 + self.scrollView.contentOffset.x;
    self.buttonContainerView.frame = frame;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self repositionButtons];

    if (scrollView.contentOffset.x < 0)
    {
        scrollView.contentOffset = CGPointZero;
    }

    if (scrollView.contentOffset.x >= self.bounds.size.width/2)
    {
        _isOpen = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:RevealCellDidOpenNotification
                                                            object:self];
    }
    else
    {
        _isOpen = NO;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.x > 0)
    {
        (*targetContentOffset).x = self.bounds.size.width/2;
    }
    else
    {
        (*targetContentOffset).x = 0;
    }
}

#pragma mark - IBActions

- (void)editButtonTapped:(id)sender
{
    [self close];
    [self.delegate editTapped:self.timer];
}

- (void)colorButtonTapped:(id)sender
{
    [self close];
    [self.delegate colorTapped:self.timer];
}

@end
