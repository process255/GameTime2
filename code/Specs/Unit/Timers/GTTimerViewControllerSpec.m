#define EXP_SHORTHAND
#import "Expecta.h"
#import <OCMock/OCMock.h>

#import "GTTimerViewController.h"

@interface GTTimerViewController (spec)

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

 @end


SPEC_BEGIN(GTTimerViewControllerSpec)


describe(@"GTTimerViewController", ^{

    __block GTTimerViewController *controller;
    
    beforeEach(^{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Timers_iPhone" bundle:nil];
        UINavigationController *navController = [storyBoard instantiateInitialViewController];
        controller = (GTTimerViewController *)navController.topViewController;
        [controller loadView];
    });
    
    it(@"should have a controller", ^{
        
        expect(controller).toNot.beNil();
        
    });
    
    it(@"should have a collection view", ^{
        
        expect(controller.collectionView).toNot.beNil();
        
    });
    
});

SPEC_END

