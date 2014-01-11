//
//  GTTimerCell.h
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTTimer;

@interface GTTimerCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;
@property (nonatomic, strong) IBOutlet UIView *progressView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *progressViewWidthConstraint;

@property (nonatomic, strong) GTTimer *timer;

- (void)start;
- (void)stop;
- (void)setActive;
- (void)setInactive;

@end
