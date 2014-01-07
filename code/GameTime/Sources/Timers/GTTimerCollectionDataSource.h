//
//  GTTimerCollectionDataSource.h
//  GameTime
//
//  Created by Sean Dougherty on 1/4/14.
//  Copyright (c) 2014 Simple Tomato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LXReorderableCollectionViewFlowLayout/LXReorderableCollectionViewFlowLayout.h>

@interface GTTimerCollectionDataSource : NSObject
<LXReorderableCollectionViewDataSource,
UICollectionViewDelegate,
LXReorderableCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
