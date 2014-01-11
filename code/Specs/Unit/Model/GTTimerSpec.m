#define EXP_SHORTHAND
#import "Expecta.h"
#import <OCMock/OCMock.h>

#import "GTTimer.h"


SPEC_BEGIN(GTTimerSpec)

describe(@"GTTimer", ^{
    __block GTTimer *timer;

    beforeEach(^{
        
        timer = [[GTTimer alloc] init];
        
    });
    
});

SPEC_END
