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


@interface GTTimerViewController ()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) GTTimerCollectionDataSource *dataSource;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapGesture;

@end

@implementation GTTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Board Game Time", nil);

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    self.navigationController.navigationBar.translucent = NO;

    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processDoubleTap:)];
    [self.doubleTapGesture setNumberOfTapsRequired:2];
    [self.doubleTapGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:self.doubleTapGesture];
}

- (void)processDoubleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        if (indexPath)
        {
            [self.dataSource openTimerPreferencesAtIndexPath:indexPath];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.collectionView reloadData];
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
    if (_dataSource == nil)
    {
        _dataSource = [[GTTimerCollectionDataSource alloc] init];
        _dataSource.collectionView = self.collectionView;
        _dataSource.controller = self;
    }
    return _dataSource;
}

@end
