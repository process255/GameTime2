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

@interface GTSoundsViewController ()

@property (nonatomic, weak) IBOutlet UILabel *sound1Label;
@property (nonatomic, weak) IBOutlet UILabel *sound2Label;
@property (nonatomic, weak) IBOutlet UILabel *sound3Label;
@property (nonatomic, weak) IBOutlet UILabel *sound4Label;
@property (nonatomic, weak) IBOutlet UILabel *sound5Label;
@property (nonatomic, weak) IBOutlet UILabel *sound6Label;

@end


@implementation GTSoundsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Timer End", nil);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupSelectedRow];
    [self setupObservers];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

 - (void)setupSelectedRow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[GTPreferences sharedInstance].timerSound inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
    self.sound1Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.sound2Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.sound3Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.sound4Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.sound5Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.sound6 Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView
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
    
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
