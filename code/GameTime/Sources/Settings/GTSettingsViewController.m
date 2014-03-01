//
//  GTSettingsViewController.m
//  GameTime
//
//  Created by Sean Dougherty on 1/10/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTSettingsViewController.h"
#import "GTPreferences.h"
#import "GTTimerSound.h"
#import "SKTAudio.h"


@interface GTSettingsViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *numberOfTimerSegmentedControl;
@property (nonatomic, weak) IBOutlet UISlider *volumeSlider;
@property (nonatomic, weak) IBOutlet UILabel *soundLabel;
@property (nonatomic, weak) IBOutlet UILabel *timerTypeLabel;

@end


@implementation GTSettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings", nil);
    [self setupNumberOfTimers];
    [self setupVolume];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupSelectedSound];
    [self setupObservers];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}


- (void)preferredFontChanged:(NSNotification *)notification
{
    self.soundLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.timerTypeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}


#pragma mark - Private Methods

- (void)setupNumberOfTimers
{
    self.numberOfTimerSegmentedControl.selectedSegmentIndex = [GTPreferences sharedInstance].numberOfPlayers - 1;
}

- (void)setupVolume
{
    self.volumeSlider.value = [GTPreferences sharedInstance].volume;
}

- (void)setupSelectedSound
{
    GTTimerSound *timerSound = [GTPreferences sharedInstance].timerSounds[[GTPreferences sharedInstance].timerSound];
    self.soundLabel.text = timerSound.name;
}

#pragma mark - IBActions

- (IBAction)numberOfTimerSegmentsChanged:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    [GTPreferences sharedInstance].numberOfPlayers = segmentedControl.selectedSegmentIndex + 1;
}

- (IBAction)volumeChanged:(id)sender
{
    UISlider *volumeSlider = (UISlider *)sender;
    DDLogVerbose(@"volume = %f", volumeSlider.value);
    [GTPreferences sharedInstance].volume = volumeSlider.value;
    GTTimerSound *timerSound =[GTPreferences sharedInstance].timerSounds[[GTPreferences sharedInstance].timerSound];
    [[SKTAudio sharedInstance] playSoundEffect:timerSound.file
                                        volume:volumeSlider.value];
}

@end
