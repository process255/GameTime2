//
//  GTTimerTypeDataSource.m
//  GameTime
//
//  Created by Sean Dougherty on 1/17/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import "GTTimerTypeDataSource.h"
#import "GTTimer.h"
#import "GTPreferences.h"
#import "GTTimeHelper.h"
#import "GTPickerCell.h"


static NSString * const TimePickerCellIdentifier = @"TimePickerCell";
static NSString * const TimerTypeCellIdentifier = @"TimerTypeCell";


@interface GTTimerTypeDataSource()

@end


@implementation GTTimerTypeDataSource


#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell;
    NSString *identifier = TimerTypeCellIdentifier;

    NSString *cellText = @"";
    if ([self isATimerType:indexPath.section])
    {

        cellText = [self textForTimerTypeAtIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        identifier = indexPath.row == 0 ? TimerTypeCellIdentifier : TimePickerCellIdentifier;
        cellText = [self textForOptionAtIndexPath:indexPath];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    if ([identifier isEqualToString:TimerTypeCellIdentifier])
    {
        cell.accessoryType = [GTPreferences sharedInstance].timerType == indexPath.section ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        cell.textLabel.text = cellText;
        cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    else if ([identifier isEqualToString:TimePickerCellIdentifier])
    {
        GTPickerCell *pickerCell = (GTPickerCell *)cell;
        [pickerCell setupTime];
    }

    return cell;
}

- (NSString *)textForTimerTypeAtIndexPath:(NSIndexPath *)indexPath
{
   return [GTTimer timerTypes][indexPath.section][@"name"];
}

- (NSString *)textForOptionAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return NSLocalizedString(@"Reset", nil);
            break;
        case 1:
        {
            NSUInteger time = [GTPreferences sharedInstance].countDownTime;
            return [NSString stringWithFormat:@"Time - %@", [GTTimeHelper timeAsHoursMinutesSeconds:time forceHours:YES]];

//            return NSLocalizedString(@"Time", nil);
            break;
        }
        default:
            break;
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if ([self isATimerType:indexPath.section])
    {
        NSIndexPath *indexPathToDeselect = [NSIndexPath indexPathForRow:0 inSection:[GTPreferences sharedInstance].timerType];
        UITableViewCell *cellToDeselect = [tableView cellForRowAtIndexPath:indexPathToDeselect];

        cellToDeselect.accessoryType = UITableViewCellAccessoryNone;


        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [GTPreferences sharedInstance].timerType = indexPath.section;

        [tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
    }
    [cell setSelected:NO];
//    else
//    {
//        [cell setSelected:NO];
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [GTTimer timerTypes].count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSUInteger timerType = [GTPreferences sharedInstance].timerType;

    if ([self isATimerType:section])
    {
        return 1;
    }
    else if (timerType == 0 || timerType == 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if (![self isATimerType:section])
    {
        return NSLocalizedString(@"Options", nil);
    }
    else
    {
        return nil;
    }

}

- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section
{
    if ([self isATimerType:section])
    {
        return [GTTimer timerTypes][section][@"description"];
    }
    else
    {
        return @"";
    }
}

- (BOOL)isAPickerRow:(NSIndexPath*)indexPath
{
    return ![self isATimerType:indexPath.section] && indexPath.row == 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isAPickerRow:indexPath])
    {
        return 163.0;
    }
    return 55.0;
}

#pragma mark - Private Methods

- (BOOL)isATimerType:(NSUInteger)section
{
    return section < [GTTimer timerTypes].count;
}

@end
