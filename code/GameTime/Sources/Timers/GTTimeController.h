//
//  GTTimeController.h
//  GameTime
//
//  Created by Sean Dougherty on 3/31/12.
//  Copyright (c) 2012 process255, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kGGTimeTicNotification;
extern NSString* const kGGTimeSubTicNotification;

#define kSubTimeIncrement 0.0333

@interface GTTimeController : NSObject

-(void)start;

@end
