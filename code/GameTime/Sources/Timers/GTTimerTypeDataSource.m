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


@interface GTTimerTypeDataSource()

@end


@implementation GTTimerTypeDataSource


#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimerTypeCell" forIndexPath:indexPath];

    NSString *cellText = @"";
    if ([self isATimerType:indexPath.section])
    {
        cellText = [self textForTimerTypeAtIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cellText = [self textForOptionAtIndexPath:indexPath];
    }

    cell.accessoryType = [GTPreferences sharedInstance].timerType == indexPath.section ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    cell.textLabel.text = cellText;
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

    return cell;
}

- (NSString *)textForTimerTypeAtIndexPath:(NSIndexPath *)indexPath
{
   return [GTTimer timerTypes][indexPath.section][@"name"];
}

- (NSString *)textForOptionAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Reset", nil);
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

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

#pragma mark - Private Methods

- (BOOL)isATimerType:(NSUInteger)section
{
    return section < [GTTimer timerTypes].count;
}

@end
