//
//  MainViewController.m
//  Paper
//
//  Created by diannas on 7/4/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *newsScrollView;
@property (weak, nonatomic) IBOutlet UIView *headlinesView;



- (void)onPanGlobal:(UIPanGestureRecognizer *)panGestureRecongnizer;

@end

@implementation MainViewController

CGPoint touchBeginPoint;
CGPoint initialPoint;
CGPoint viewBeginPoint;

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
    
    self.newsScrollView.contentSize = CGSizeMake(1444, 253);
    initialPoint = self.headlinesView.center;
    UIPanGestureRecognizer *globalGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGlobal:)];
    
    [self.view addGestureRecognizer:(UIGestureRecognizer *)globalGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)onPanGlobal:(UIPanGestureRecognizer *)panGestureRecognizer
{
    
    
    CGPoint touchCurrentPoint = [panGestureRecognizer locationInView:self.view];
    CGPoint moveToPoint = initialPoint;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        touchBeginPoint = [panGestureRecognizer locationInView:self.view];
        viewBeginPoint = self.headlinesView.center;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat newY = viewBeginPoint.y + (touchCurrentPoint.y - touchBeginPoint.y);
        moveToPoint = CGPointMake(initialPoint.x, newY);
        self.headlinesView.center = moveToPoint;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat delta = touchCurrentPoint.y - touchBeginPoint.y;
        
        if (delta<0) {
            moveToPoint = initialPoint;
        }
        else {
            moveToPoint = CGPointMake(initialPoint.x,800);
        }
        
        [UIView
         animateWithDuration:.6
         delay:0
         usingSpringWithDamping:.8
         initialSpringVelocity:1
         options:0
         animations:^{
             self.headlinesView.center = moveToPoint;
         }
         completion:nil
         ];
        
    }

}

@end
