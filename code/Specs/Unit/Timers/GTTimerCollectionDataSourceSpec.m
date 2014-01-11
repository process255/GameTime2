#define EXP_SHORTHAND
#import "Expecta.h"
#import <OCMock/OCMock.h>

#import "GTTimerCollectionDataSource.h"
#import <LXReorderableCollectionViewFlowLayout/LXReorderableCollectionViewFlowLayout.h>


SPEC_BEGIN(GTTimerCollectionDataSourceSpec)

describe(@"GTTimerCollectionDataSource", ^{
    __block GTTimerCollectionDataSource *dataSource;

    beforeEach(^{
        
        dataSource = [[GTTimerCollectionDataSource alloc] init];

    });
    
    it(@"should implement LXReorderableCollectionViewDataSource", ^{
       
        expect([dataSource conformsToProtocol:@protocol(LXReorderableCollectionViewDataSource)]).to.beTruthy();
    });
    
    it(@"should implement UICollectionViewDelegate", ^{
        
        expect([dataSource conformsToProtocol:@protocol(UICollectionViewDelegate)]).to.beTruthy();
        
    });
    
    it(@"should implement LXReorderableCollectionViewDelegateFlowLayout", ^{
        
        expect([dataSource conformsToProtocol:@protocol(LXReorderableCollectionViewDelegateFlowLayout)]).to.beTruthy();
        
    });
    
});

SPEC_END
