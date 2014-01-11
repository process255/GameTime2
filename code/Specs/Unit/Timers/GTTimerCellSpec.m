#define EXP_SHORTHAND
#import "Expecta.h"
#import <OCMock/OCMock.h>

#import "GTTimerCell.h"


SPEC_BEGIN(GTTimerCellSpec)

describe(@"GTTimerCell", ^{
    
    __block GTTimerCell *cell;

    beforeEach(^{
        
        cell = [[GTTimerCell alloc] initWithCoder:nil];
        
    });
});

SPEC_END
