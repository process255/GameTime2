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
    GTTimer *timerToMove = [self.timers objectAtIndex:fromIndexPath.item];
    [self.timers removeObject:timerToMove];
    [self.timers insertObject:timerToMove
                      atIndex:toIndexPath.item];
    
    for (GTTimer *timer in self.timers)
    {
        timer.position = [self.timers indexOfObject:timer];
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

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTTimer *timer = [self.timers objectAtIndex:indexPath.item];
    GTTimerCell *timerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimerCell"
                                                                       forIndexPath:indexPath];
    timerCell.nameLabel.text = timer.name;
    timerCell.backgroundColor = timer.playerColor.rowBackgroundColor;
    return timerCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen screenWidth], self.collectionView.frame.size.height / self.timers.count);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - Getters/Setters

- (NSMutableArray*)timers
{
    if (_timers == nil)
    {
        GTTimer *timer1 = [[GTTimer alloc] init];
        timer1.name = @"test1";
        timer1.position = 0;
        
        GTPlayerColor *playerColor1 = [[GTPlayerColor alloc] init];
        playerColor1.rowBackgroundColor = [UIColor redColor];
        timer1.playerColor = playerColor1;
        
        GTTimer *timer2 = [[GTTimer alloc] init];
        timer2.name = @"test2";
        timer2.position = 1;
        
        GTPlayerColor *playerColor2 = [[GTPlayerColor alloc] init];
        playerColor2.rowBackgroundColor = [UIColor purpleColor];
        timer2.playerColor = playerColor2;
        
        GTTimer *timer3 = [[GTTimer alloc] init];
        timer3.name = @"test3";
        timer3.position = 2;
        
        GTPlayerColor *playerColor3 = [[GTPlayerColor alloc] init];
        playerColor3.rowBackgroundColor = [UIColor greenColor];
        timer3.playerColor = playerColor3;
        
        _timers = [NSMutableArray arrayWithArray:@[timer1, timer2, timer3]];
    }
    return _timers;
}

#pragma mark - Private Methods


@end
