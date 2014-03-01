//
//  GTPickerCell.m
//  GameTime
//
//  Created by Sean Dougherty on 1/20/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTPickerCell.h"
#import "LabeledPickerView.h"
#import "GTPreferences.h"
#import "GTTimeHelper.h"



@interface GTPickerCell() <UIPickerViewDelegate, UIPickerViewDataSource>

@end


@implementation GTPickerCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)setupTime
{
    DDLogVerbose(@"picker = %@", self.picker);
//    [self.picker addLabel:NSLocalizedString(@"hour", @"hour, singular")
//             forComponent:0
//         forLongestString:[NSString stringWithFormat:@"%@ ", NSLocalizedString(@"hours", @"hours, plural")]];
//
//    [self.picker addLabel:NSLocalizedString(@"min", @"minute, singular, short abbreviation")
//             forComponent:1
//         forLongestString:[NSString stringWithFormat:@"%@ ", NSLocalizedString(@"mins", @"minutes, plural, short abbreviation")]];
//
//    [self.picker addLabel:NSLocalizedString(@"secs", @"seconds, plural, short abbreviation")
//             forComponent:2
//         forLongestString:NSLocalizedString(@"secs", @"seconds, plural, short abbreviation")];

    self.picker.showsSelectionIndicator = NO;
    self.picker.dataSource = self;
    self.picker.delegate = self;
//    [self.picker setup];
    [self resetPickerToSavedValues];
}

- (void)resetPickerToSavedValues
{
    NSUInteger countDownTime = [GTPreferences sharedInstance].countDownTime;
    NSUInteger hours = [GTTimeHelper hoursFromTimeInSeconds:countDownTime];
    NSUInteger mins = [GTTimeHelper minutesFromTimeInSeconds:countDownTime];
    NSUInteger secs = [GTTimeHelper secondsFromTimeInSeconds:countDownTime];

    [self.picker selectRow:hours inComponent:0 animated:NO];
    [self.picker selectRow:mins + 1800 inComponent:1 animated:NO];
    [self.picker selectRow:secs + 1800 inComponent:2 animated:NO];
    [self.picker reloadAllComponents];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return 10;
            break;
        case 1:
        case 2:
            return 3600;
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSInteger rowFormatted = row;

    if (component == 1 || component == 2)
    {
        rowFormatted = row % 60;
    }

    return [NSString stringWithFormat:@"%ld", (long)rowFormatted];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            return 80.0;
            break;
        }
        case 1:
        {
            return 80.0;
            break;
        }
        case 2:
        {
            return 80.0;
            break;
        }
    }
    return 100.0;
}


- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.hoursLabel.text = (row == 1) ? NSLocalizedString(@"hour", @"hour, singular") : NSLocalizedString(@"hours", @"hours, plural");
            break;
        }
        case 1:
        {
            self.minsLabel.text = (row % 60 == 1) ? NSLocalizedString(@"min", @"minute, singular, short abbreviation") : NSLocalizedString(@"mins", @"minutes, plural, short abbreviation");
            break;
        }
        case 2:
        {
            self.secsLabel.text = (row % 60 == 1) ? NSLocalizedString(@"sec", @"second, singular, short abbreviation") : NSLocalizedString(@"secs", @"seconds, plural, short abbreviation");
            break;
        }
    }

    NSUInteger hours = [self.picker selectedRowInComponent:0];
    NSUInteger mins = [self.picker selectedRowInComponent:1] % 60;
    NSUInteger secs = [self.picker selectedRowInComponent:2] % 60;
    NSUInteger time = hours * 3600 + mins * 60 + secs;
    [GTPreferences sharedInstance].countDownTime = time;
}

@end
