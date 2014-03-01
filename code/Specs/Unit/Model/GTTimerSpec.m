#define EXP_SHORTHAND
#import "Expecta.h"
#import <OCMock/OCMock.h>

#import "GTTimer.h"


SPEC_BEGIN(GTTimerSpec)

describe(@"GTTimer", ^{
    __block GTTimer *timer;

    beforeEach(^{
        timer = [GTTimer timerWith:3];
    });

    it(@"is initialized to a paused state", ^{
        expect(timer.state).to.equal(GTTimerStatePaused);
    });

    it(@"conforms to NSCoding", ^{
        expect(timer).to.conformTo(@protocol(NSCoding));
    });

    it(@"has 3 timer types", ^{
        expect([GTTimer timerTypes].count).to.equal(3);
    });
    
});

SPEC_END
