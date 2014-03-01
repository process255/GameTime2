//
//  GTSoundsViewController.m
//  GameTime
//
//  Created by Sean Dougherty on 1/11/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTSoundsViewController.h"
#import "GTPreferences.h"
#import "SKTAudio.h"
#import "GTTimerSound.h"
#import "SingleSectionArrayDataSource.h"
#import "UITableViewCell+SoundCell.h"

static NSString * const kSoundCellIdentifier = @"SoundCell";


@interface GTSoundsViewController ()

@property (nonatomic, strong) SingleSectionArrayDataSource *dataSource;

@end


@implementation GTSoundsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Timer End", nil);

    [self setupDataSource];

    self.dataSource.items = [GTPreferences sharedInstance].timerSounds;
    [self.tableView reloadData];
}

- (void)setupDataSource {
    self.dataSource =
    [[SingleSectionArrayDataSource alloc] initWithItems:[GTPreferences sharedInstance].timerSounds
                                         cellIdentifier:kSoundCellIdentifier
                                     configureCellBlock:^(UITableViewCell *cell, GTTimerSound *timerSound, NSIndexPath *indexPath) {
                                              [cell configureForTimerSound:timerSound indexPath:indexPath];
                                          }
                                     sectionHeaderTitle:NSLocalizedString(@"Sounds", nil)];

    self.tableView.dataSource = self.dataSource;
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *indexPathToDeselect = [NSIndexPath indexPathForRow:[GTPreferences sharedInstance].timerSound inSection:0];
    UITableViewCell *cellToDeselect = [self.tableView cellForRowAtIndexPath:indexPathToDeselect];
    cellToDeselect.accessoryType = UITableViewCellAccessoryNone;
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [GTPreferences sharedInstance].timerSound = indexPath.row;
    
    GTTimerSound *timerSound =[GTPreferences sharedInstance].timerSounds[indexPath.row];
    [[SKTAudio sharedInstance] playSoundEffect:timerSound.file
                                        volume:[GTPreferences sharedInstance].volume];
    
}


@end
