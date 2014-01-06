#import "GTTimer.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(GTTimerSpec)

describe(@"GTTimer", ^{
    __block GTTimer *timer;

    beforeEach(^{
        
        timer = [[GTTimer alloc] init];
        
    });
    
});

SPEC_END
