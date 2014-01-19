//
//  GTTimerCollectionDataSource.m
//  GameTime
//
//  Created by Sean Dougherty on 1/4/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimerCollectionDataSource.h"
#import "GTTimer.h"
#import "GTTimerCell.h"
#import "GTPlayerColor.h"
#import "GTTimeHelper.h"
#import "GTPreferences.h"

#import "GTTimerSettingsViewController.h"

@interface GTTimerCollectionDataSource ()

@end


@implementation GTTimerCollectionDataSource

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - Public Methods

- (void)openTimerPreferencesAtIndexPath:(NSIndexPath *)indexPath
{
    GTTimer *timer = [self.timers objectAtIndex:indexPath.item];
    [self openTimerPreferences:timer];
}

#pragma mark - LXReorderableCollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [GTPreferences sharedInstance].numberOfPlayers;
}

- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)fromIndexPath
   willMoveToIndexPath:(NSIndexPath *)toIndexPath
{

}

- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)fromIndexPath
    didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    GTTimer* timerToMove = [self.timers objectAtIndex:fromIndexPath.item];
    [self.timers removeObject:timerToMove];
    [self.timers insertObject:timerToMove
                      atIndex:toIndexPath.item];
    
    for (GTTimer *timer in self.timers)
    {
        timer.position = [self.timers indexOfObject:timer];
        [[GTPreferences sharedInstance] saveTimer:timer];
    }
}



- (BOOL)collectionView:(UICollectionView *)collectionView
canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)fromIndexPath
    canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTTimer *timer = [self.timers objectAtIndex:indexPath.item];
    
    GTTimerCell *timerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimerCell"
                                                                       forIndexPath:indexPath];

    timerCell.timer = timer;
    [timerCell start];
    return timerCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        return CGSizeMake(self.collectionView.frame.size.width / 2, self.collectionView.frame.size.height / ceil(([GTPreferences sharedInstance].numberOfPlayers / 2.0)));        
    }
    else
    {
        return CGSizeMake([UIScreen screenWidth], self.collectionView.frame.size.height / [GTPreferences sharedInstance].numberOfPlayers);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTTimer *timer = [self.timers objectAtIndex:indexPath.item];
    GTTimerCell *timerCell = (GTTimerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    switch (timer.state)
    {
        case GTTimerStatePaused:
        case GTTimerStateStopped:
//            [self openTimerPreferences:timer];
            [timerCell setActive];
            break;
        case GTTimerStateStarted:
            [timerCell setInactive];
            break;
            
    }
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTTimerCell *timerCell = (GTTimerCell *)cell;
    [timerCell stop];
}

#pragma mark - Private Methods

- (void)openTimerPreferences:(GTTimer*)timer
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Timers_iPhone" bundle:nil];
    GTTimerSettingsViewController *controller = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([GTTimerSettingsViewController class])];
    controller.timer = timer;
    [self.controller.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Getters/Setters

- (NSMutableArray*)timers
{
    if (_timers == nil)
    {
        _timers = [NSMutableArray arrayWithCapacity:[GTPreferences sharedInstance].numberOfPlayers];
        for ( NSUInteger i = 0 ; i < [GTPreferences sharedInstance].numberOfPlayers ; i++)
        {
            GTTimer* timer = [GTTimer timerWith:i];
            timer.type = GTTimerTypeCountDown;
            timer.state = GTTimerStatePaused;
            [[GTPreferences sharedInstance] saveTimer:timer];
            [_timers addObject:timer];
        }
    }
    return _timers;
}


@end
