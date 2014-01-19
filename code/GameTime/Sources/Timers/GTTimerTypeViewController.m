//
//  GTTimerTypeViewController.m
//  GameTime
//
//  Created by Sean Dougherty on 1/17/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimerTypeViewController.h"
#import "GTTimerTypeDataSource.h"

@interface GTTimerTypeViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) GTTimerTypeDataSource *dataSource;

@end


@implementation GTTimerTypeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Timer Type", nil);
	self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupObservers];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - Observers

- (void)setupObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)preferredFontChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

#pragma mark - Getters/Setters

- (GTTimerTypeDataSource *)dataSource
{
    if (_dataSource) return _dataSource;

    _dataSource = [[GTTimerTypeDataSource alloc] init];
    _dataSource.tableView = self.tableView;
    return _dataSource;
}

@end
