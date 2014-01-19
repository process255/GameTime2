//
//  UITableViewCell+SoundCell.m
//  GameTime
//
//  Created by Sean Dougherty on 1/18/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "UITableViewCell+SoundCell.h"
#import "GTTimerSound.h"
#import "GTPreferences.h"


@implementation UITableViewCell (SoundCell)

- (void)configureForTimerSound:(GTTimerSound *)timerSound
                     indexPath:(NSIndexPath *)indexPath
{
    self.textLabel.text = timerSound.name;
    self.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = [GTPreferences sharedInstance].timerSound == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
