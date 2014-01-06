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

@interface GTTimerCollectionDataSource ()

@property (strong, nonatomic) NSMutableArray *timers;

@end


@implementation GTTimerCollectionDataSource

#pragma mark - LXReorderableCollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.timers.count;
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

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTTimer *timer = [self.timers objectAtIndex:indexPath.item];
    GTTimerCell *timerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimerCell" forIndexPath:indexPath];
//    playingCardCell.playingCard = playingCard;
    timerCell.nameLabel.text = timer.name;
    return timerCell;
}

#pragma mark - Getters/Setters

- (NSMutableArray*)timers
{
    if (_timers == nil)
    {
        GTTimer *timer1 = [[GTTimer alloc] init];
        timer1.name = @"test1";
        
        GTTimer *timer2 = [[GTTimer alloc] init];
        timer2.name = @"test2";
        _timers = [NSMutableArray arrayWithArray:@[timer1, timer2]];
    }
    return _timers;
}
@end
