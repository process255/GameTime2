//
//  GTPlayerColor.h
//  GameTime
//
//  Created by Sean Dougherty on 5/5/12.
//  Copyright (c) 2012 process255, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTPlayerColor : NSObject <NSCoding>

@property (nonatomic, strong) UIColor *rowBackgroundColor;
@property (nonatomic, strong) UIColor *activeNameColor;
@property (nonatomic, strong) UIColor *inactiveNameColor;
@property (nonatomic, strong) UIColor *activeTimerColor;
@property (nonatomic, strong) UIColor *inactiveTimerColor;
@property (nonatomic, strong) UIColor *disclosureColor;
@property (nonatomic, strong) UIColor *textFieldBgColor;

@end