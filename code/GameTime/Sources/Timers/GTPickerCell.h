//
//  GTPickerCell.h
//  GameTime
//
//  Created by Sean Dougherty on 1/20/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LabeledPickerView;

@interface GTPickerCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIPickerView *picker;
@property (nonatomic, weak) IBOutlet UILabel *hoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *minsLabel;
@property (nonatomic, weak) IBOutlet UILabel *secsLabel;

- (void)setupTime;

@end