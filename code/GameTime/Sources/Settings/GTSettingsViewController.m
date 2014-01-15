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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings", nil);
    [self setupNumberOfTimers];
    [self setupVolume];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
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


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
