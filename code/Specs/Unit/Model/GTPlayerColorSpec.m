#define EXP_SHORTHAND
#import "Expecta.h"
#import <OCMock/OCMock.h>
#import "GTPlayerColor.h"

SPEC_BEGIN(GTPlayerColorSpec)

describe(@"GTPlayerColor", ^{
    __block GTPlayerColor *playerColor;

    beforeEach(^{
        playerColor = [[GTPlayerColor alloc] init];
    });

});

SPEC_END
