//
//  GTTimerCell.h
//  GameTime
//
//  Created by Sean Dougherty on 1/5/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const RevealCellDidOpenNotification;

@class GTTimer;
@class GTProgressView;

@protocol GTTimerCellDelegate <NSObject>

- (void)colorTapped:(GTTimer *)timer;
- (void)editTapped:(GTTimer *)timer;

@end

@interface GTTimerCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timerLabel;
@property (nonatomic, weak) IBOutlet GTProgressView *progressView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *progressViewWidthConstraint;
@property (nonatomic, unsafe_unretained) id<GTTimerCellDelegate> delegate;

@property (nonatomic, strong) GTTimer *timer;

- (void)start;
- (void)stop;
- (void)setActive;
- (void)setInactive;

@end
