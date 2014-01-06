#import "GTTimerViewController.h"

@interface GTTimerViewController (spec)

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end


SPEC_BEGIN(GTTimerViewControllerSpec)

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


describe(@"GTTimerViewController", ^{

    __block GTTimerViewController *controller;
    
    beforeEach(^{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Timers_iPhone" bundle:nil];
        UINavigationController *navController = [storyBoard instantiateInitialViewController];
        controller = (GTTimerViewController *)navController.topViewController;
        [controller loadView];
    });
    
    it(@"should have a controller", ^{
        
        controller should_not be_nil;
        
    });
    
    it(@"should have a collection view", ^{
        
        controller.collectionView should_not be_nil;
        
    });
    
});

SPEC_END

