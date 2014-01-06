#import "GTTimerCollectionDataSource.h"
#import <LXReorderableCollectionViewFlowLayout/LXReorderableCollectionViewFlowLayout.h>

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(GTTimerCollectionDataSourceSpec)

describe(@"GTTimerCollectionDataSource", ^{
    __block GTTimerCollectionDataSource *dataSource;

    beforeEach(^{
        
        dataSource = [[GTTimerCollectionDataSource alloc] init];

    });
    
    it(@"should implement LXReorderableCollectionViewDataSource", ^{
        
        [dataSource conformsToProtocol:@protocol(LXReorderableCollectionViewDataSource)] should be_truthy;
        
    });
    
    it(@"should implement UICollectionViewDelegate", ^{
        
        [dataSource conformsToProtocol:@protocol(UICollectionViewDelegate)] should be_truthy;
        
    });
    
    it(@"should implement LXReorderableCollectionViewDelegateFlowLayout", ^{
        
        [dataSource conformsToProtocol:@protocol(LXReorderableCollectionViewDelegateFlowLayout)] should be_truthy;
        
    });
    
    
});

SPEC_END
