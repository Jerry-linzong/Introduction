//
//  FirstViewController.m
//  Exercise
//
//  Created by JerryLin on 14-5-2.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "FirstViewController.h"
#import "MyNavController.h"
#import "ShouyeTableViewController.h"
#import "TransitionManager.h"
#import "ModelViewController.h"

@interface FirstViewController ()

@property (nonatomic) TransitionManager *manager;

@property (weak, nonatomic) IBOutlet UIButton *button1;

@property (weak, nonatomic) IBOutlet UIButton *button2;

@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (nonatomic, retain) UIViewController *currentVC;


@property (nonatomic, assign) BOOL open;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.detailView.backgroundColor = [UIColor blueColor];
    self.scrollView.delegate = self;
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.scrollView.backgroundColor = [UIColor blackColor];
    
    //[self performSelector:@selector(b1pressed:)];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.scrollView addGestureRecognizer:swipe];
    
    //[self logout];
    
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    //self.view.frame = [[UIScreen mainScreen] bounds];
    self.scrollView.frame = self.view.bounds;
    NSLog(@"%f,%f,%f,%f",self.scrollView.frame.origin.x,self.scrollView.frame.origin.y,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width+200, self.view.frame.size.height);
    
    NSLog(@"%f,%f",self.scrollView.contentSize.width,self.scrollView.contentSize.height);
    self.detailView.frame = CGRectMake(200, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    NSLog(@"%f,%f",self.detailView.frame.origin.x,self.detailView.frame.origin.y);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:YES];
}

- (void)presentViewController:(UIViewController *)newVC
{
    
    /*
    [self.currentVC willMoveToParentViewController:nil];
    [self.currentVC.view removeFromSuperview];
    [self.currentVC removeFromParentViewController];
    
    [self addChildViewController:newVC];
    [self.detailView addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    self.currentVC = newVC;
    
    */
    
    
    //A. Container hierarchy management ------------------------------
    
    //1. The current controller is going to be removed
    [self.currentVC willMoveToParentViewController:nil];
    
    //2. The new controller is a new child of the container
    [self addChildViewController:newVC];
    
    //3. Setup the new controller's frame depending on the animation you want to obtain
    newVC.view.frame = CGRectMake(0, 0, self.detailView.frame.size.width, self.detailView.frame.size.height);
    
    //3b. Tell the controller that it's going to be showed
    [newVC beginAppearanceTransition:YES animated:YES];
    
    
    
    //B. Generate images and setting up views (Screenshots) ------------------------
    
    
    //4. Create a screenshot of the CURRENT view and setup its layer
    UIImageView *currentView = [self takeScreenshot:self.view.layer];
    //4b. Build a view with black bg and attach here the just taken screenshot
    UIView *blackView = [self blackView];
    [blackView addSubview:currentView];
    
    CGRect oldFrame = [currentView.layer frame];
    currentView.layer.anchorPoint = CGPointMake(0,0.5);
    currentView.layer.frame = oldFrame;
    
    //5. Hide the CURRENT view (we've taken the screenshot)
    [self.currentVC.view setHidden:YES];
    
    //6. Add the new view to the detail view
    [self.detailView addSubview:newVC.view];
    
    //7. Create a screenshot of the NEXT view and setup its layer
    UIImageView *nextView = [self takeScreenshot:self.detailView.layer];
    oldFrame = [nextView.layer frame];
    nextView.layer.anchorPoint = CGPointMake(0,0.5);
    nextView.layer.frame = oldFrame;
    nextView.frame = CGRectMake(-self.view.frame.size.width, 0, nextView.frame.size.width, nextView.frame.size.height);
    //7.b Attach the screen shot to the black background view
    [blackView addSubview:nextView];
    [self.detailView addSubview:blackView];
    
    
    
    
    //C. THE ANIMATION!!!! ------------------------------------------
    
    //8. Setup the NEXT view layer
    CATransform3D tp = CATransform3DIdentity;
    tp.m34 = 1.0/ -500;
    tp = CATransform3DTranslate(tp, -300.0f, -10.0f, 300.0f);
    tp = CATransform3DRotate(tp, radianFromDegree(20), 0.0f,1.0f, 0.8f);
    nextView.layer.transform = tp;
    nextView.layer.opacity = 0.0f;
    
    //9. Finally, perform the animation from PREVIOUS to NEXT view
    [UIView animateWithDuration:1.0
     
     //9b. Animate the views to create a transition effect
                     animations:^{
                         
                         //9c. Create transition for the CURRENT view.
                         CATransform3D t = CATransform3DIdentity;
                         t.m34 = 1.0/ -500;
                         t = CATransform3DRotate(t, radianFromDegree(5.0f), 0.0f,0.0f, 1.0f);
                         t = CATransform3DTranslate(t, newVC.view.frame.size.width * 2, 0.0f, -400.0);
                         t = CATransform3DRotate(t, radianFromDegree(-45), 0.0f,1.0f, 0.0f);
                         t = CATransform3DRotate(t, radianFromDegree(50), 1.0f,0.0f, 0.0f);
                         currentView.layer.transform = t;
                         currentView.layer.opacity = 0.0;
                         
                         //9d. Create transition for the NEXT view.
                         CATransform3D t2 = CATransform3DIdentity;
                         t2.m34 = 1.0/ -500;
                         t2 = CATransform3DTranslate(t2, newVC.view.frame.size.width, 0.0f, 0.0);
                         nextView.layer.transform = t2;
                         nextView.layer.opacity = 1.0;
                         
                     }
     
     
     //D. Container hierarchy management ------------------------------
     //10. At the end of the animations we remove the previous view and update the Controller hierarchy.
                     completion:^(BOOL finished) {
                         
                         //Tell the controller that it's going to be removed
                         [self.currentVC beginAppearanceTransition:NO animated:YES];
                         
                         //Remove the old Detail Controller view from superview
                         [self.currentVC.view removeFromSuperview];
                         
                         //Remove the old Detail controller from the hierarchy
                         [self.currentVC removeFromParentViewController];
                         //Added by myself
                         [self.currentVC endAppearanceTransition];
                         
                         //Set the new view controller as current
                         self.currentVC = newVC;
                         [self.currentVC didMoveToParentViewController:self];
                         
                         //Added by myself
                         [self.currentVC endAppearanceTransition];
                         
                         //The Black backogrund view is no more needed
                         [blackView removeFromSuperview];
                         
                     }];

    
    
}

- (void)swipe:(UIGestureRecognizer *)gesture
{
    //ModelViewController *model = [[ModelViewController alloc] init];
    ModelViewController *model = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"model"];
    model.transitioningDelegate = self;
    
    model.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:model animated:YES completion:^{}];
}

- (IBAction)b1pressed:(UIButton *)sender {
    
    /*
    ShouyeTableViewController *t = [[ShouyeTableViewController alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:t];
    
    [self presentViewController:n];
    */
    
    [self.scrollView setContentOffset:self.detailView.frame.origin animated:YES];
    UINavigationController *t = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShouyeNav"];
    ShouyeTableViewController *s = (ShouyeTableViewController *)t.childViewControllers[0];
    s.managedContext = self.managedContext;
    
    [self presentViewController:t];
    
}

- (IBAction)b2pressed:(UIButton *)sender {
    [self.scrollView setContentOffset:self.detailView.frame.origin animated:YES];
    UIViewController *t = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShowViewController"];
    [self presentViewController:t];
    
    
}


- (IBAction)b3pressed:(UIButton *)sender {
    [self logout];
}


- (void)logout
{
    /*
    IntroViewController *t = [[IntroViewController alloc] init];
    t.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:t animated:YES completion:^{}];
    */
    [self dismissViewControllerAnimated:YES completion:nil];
     
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - uiscrollview delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint offset = scrollView.contentOffset;
    if (200 - offset.x < 80) {
        [scrollView setContentOffset:CGPointMake(200, 0) animated:YES];
    } else {
        
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (200 - offset.x < 80) {
        [scrollView setContentOffset:CGPointMake(200, 0) animated:YES];
    } else {
        
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        
    }
}


#pragma mark - helper

- (void)toLeft
{
    self.open = NO;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)toRight
{
    self.open = YES;
    [self.scrollView setContentOffset:CGPointMake(200, 0) animated:YES];
}

- (void)switch
{
    if(self.open){
        [self toLeft];
    } else {
        [self toRight];
    }
}

//Create a UIImageView from the given layer
- (UIImageView*)takeScreenshot:(CALayer*)layer{
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, [[UIScreen mainScreen] scale]);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *screnshot = [[UIImageView alloc] initWithImage:image];
    
    return screnshot;
}

//Create a view with a black background
- (UIView*)blackView{
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    return bgView;
}

#pragma mark - Convert Degrees to Radian
double radianFromDegree(float degrees) {
    return (degrees / 180) * M_PI;
}


#pragma mark - tansition delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    TransitionManager *manager = [[TransitionManager alloc] init];
    manager.transitionTo = MODAL;
    return manager;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    TransitionManager *manager = [[TransitionManager alloc] init];
    manager.transitionTo = INITIAL;
    return manager;
}

@end
