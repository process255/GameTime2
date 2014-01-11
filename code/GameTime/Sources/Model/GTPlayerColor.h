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
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *textFieldBgColor;


+ (GTPlayerColor*)bgColor:(UIColor*)bgColor
        inactiveNameColor:(UIColor*)inactiveNameColor
          activeNameColor:(UIColor*)activeNameColor
         activeTimerColor:(UIColor*)activeTimerColor
       inactiveTimerColor:(UIColor*)inactiveTimerColor
            progressColor:(UIColor*)progressColor
         textFieldBgColor:(UIColor*)textFieldBgColor;

@end