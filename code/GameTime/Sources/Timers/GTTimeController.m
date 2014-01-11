//
//  GTTimeController.m
//  GameTime
//
//  Created by Sean Dougherty on 3/31/12.
//  Copyright (c) 2012 process255, LLC. All rights reserved.
//

#import "GTTimeController.h"

NSString* const kGGTimeTicNotification = @"kGGTimeTicNotification";
NSString* const kGGTimeSubTicNotification = @"kGGTimeSubTicNotification";


@interface GTTimeController ()

@property(nonatomic, retain) NSTimer * timer;
@property(nonatomic, retain) NSTimer * subTimer;
@property(nonatomic, assign) NSInteger numberOfSeconds;

@end

@implementation GTTimeController

- (id)init
{
    self = [super init];
    if (self)
    {
       self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(timerTic:)
                                                   userInfo:nil
                                                    repeats:YES];
        
        self.subTimer = [NSTimer scheduledTimerWithTimeInterval:kSubTimeIncrement
                                                         target:self
                                                       selector:@selector(subTimerTic:)
                                                       userInfo:nil
                                                        repeats:YES];
    }
    
    return self;
}

- (void)timerTic:(NSTimer*)timer
{
    self.numberOfSeconds ++;
    [[NSNotificationCenter defaultCenter] postNotificationName:kGGTimeTicNotification object:self];
}

- (void)subTimerTic:(NSTimer*)timer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGGTimeSubTicNotification object:self.subTimer];
}

- (void)start
{
    
}

#pragma mark - Getters/Setters



@end
