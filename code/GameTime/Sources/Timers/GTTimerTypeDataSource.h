//
//  GTTimerTypeDataSource.h
//  GameTime
//
//  Created by Sean Dougherty on 1/17/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTTimerTypeDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
