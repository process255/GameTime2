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


@interface GTTimerViewController ()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) GTTimerCollectionDataSource *dataSource;

@end

@implementation GTTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Board Game Time", nil);
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    
    [self.navigationController pushViewController:settingsVC animated:YES];    
}

#pragma mark - Getters/Setters

- (GTTimerCollectionDataSource*)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [[GTTimerCollectionDataSource alloc] init];
        _dataSource.collectionView = self.collectionView;
    }
    return _dataSource;
}

@end
