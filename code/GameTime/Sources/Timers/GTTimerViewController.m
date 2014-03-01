//
//  GTTimerViewController.m
//  GameTime
//
//  Created by Sean Dougherty on 12/30/13.
//  Copyright (c) 2013 Simple Tomato. All rights reserved.
//

#import "GTTimerViewController.h"
#import "GTTimerCollectionDataSource.h"
#import "GTSettingsViewController.h"
#import "GTPreferences.h"
#import "GTPlayerColor.h"
#import "GTTimerSettingsViewController.h"
#import "InfColorPickerController.h"
#import "GTTimerCell.h"


@interface GTTimerViewController ()<InfColorPickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) GTTimerCollectionDataSource *dataSource;
@property (nonatomic, strong) GTTimer *editingTimer;

@end

@implementation GTTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Board Game Time", nil);
    UIImage *titleImage = [UIImage imageNamed:@"timer-icon"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:titleImage];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    self.navigationController.navigationBar.translucent = NO;

    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    self.editingTimer = nil;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    [self.collectionView reloadData];

    [[NSNotificationCenter defaultCenter] postNotificationName:RevealCellDidOpenNotification
                                                        object:self];
}

#pragma mark - IBActions
- (IBAction)settingsTapped:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Timers_iPhone" bundle:nil];
    GTSettingsViewController *settingsVC = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([GTSettingsViewController class])];
    NSUInteger randomIndex = (NSUInteger)(arc4random() % self.dataSource.timers.count);
    GTTimer *timer = self.dataSource.timers[randomIndex];
    settingsVC.view.tintColor = [timer.playerColor.rowBackgroundColor darker];

    [self.navigationController pushViewController:settingsVC animated:YES];    
}

#pragma mark - Getters/Setters

- (GTTimerCollectionDataSource*)dataSource
{
    if (_dataSource) return _dataSource;
    _dataSource = [[GTTimerCollectionDataSource alloc] init];
    _dataSource.collectionView = self.collectionView;
    _dataSource.controller = self;
    return _dataSource;
}

#pragma mark - GTTimerCellDelegate

- (void)colorTapped:(GTTimer *)timer
{
    self.editingTimer = timer;
    [self showColorPicker:timer];
}

- (void)editTapped:(GTTimer *)timer
{
    [self openTimerPreferences:timer];
}

#pragma mark - Private Methods

- (void)showColorPicker:(GTTimer*)timer
{
    InfColorPickerController* picker = [InfColorPickerController colorPickerViewController];
    picker.sourceColor = timer.playerColor.rowBackgroundColor;
	picker.delegate = self;
    [self.navigationController pushViewController:picker animated:YES];
}

- (void)openTimerPreferences:(GTTimer*)timer
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Timers_iPhone" bundle:nil];
    GTTimerSettingsViewController *controller = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([GTTimerSettingsViewController class])];
    controller.timer = timer;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - InfColorPickerControllerDelegate Methods

- (void)colorPickerControllerDidChangeColor:(InfColorPickerController*)controller
{
    DDLogVerbose(@"color chosen = %@", controller.resultColor);
    self.editingTimer.playerColor.rowBackgroundColor = controller.resultColor;
    [[GTPreferences sharedInstance] saveTimer:self.editingTimer];
}

@end
