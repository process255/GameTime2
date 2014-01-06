//
//  GTTimerViewController.m
//  GameTime
//
//  Created by Sean Dougherty on 12/30/13.
//  Copyright (c) 2013 Simple Tomato. All rights reserved.
//

#import "GTTimerViewController.h"
#import "GTTimerCollectionDataSource.h"

@interface GTTimerViewController ()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) GTTimerCollectionDataSource *dataSource;

@end

@implementation GTTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Timers", nil);
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters/Setters

- (GTTimerCollectionDataSource*)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [[GTTimerCollectionDataSource alloc] init];
    }
    return _dataSource;
}

@end
