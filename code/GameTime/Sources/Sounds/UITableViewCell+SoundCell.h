//
//  UITableViewCell+SoundCell.h
//  GameTime
//
//  Created by Sean Dougherty on 1/18/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTTimerSound;

@interface UITableViewCell (SoundCell)

- (void)configureForTimerSound:(GTTimerSound *)timerSound
                     indexPath:(NSIndexPath *)indexPath;

@end
