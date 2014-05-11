//
//  ViewController.m
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "IntroViewController.h"
#import "IntroView.h"
#import "IntroPage.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image1 = [UIImage imageNamed:@"taohua.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"meiguihua.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"zhizihua.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"molihua.jpg"];
    UIImage *image5 = [UIImage imageNamed:@"meihua.jpg"];
    UIImage *image6 = [UIImage imageNamed:@"jinyinhua.jpg"];
    
    NSMutableArray *images = [NSMutableArray arrayWithObjects:image1, image2, image3, image4, image5,image6, nil];
    
    IntroPage * page1 = [[IntroPage alloc] initWithFrame:self.view.frame headTitle:@"Beautiful Flowers" bottomTitle:@"Love Flowers?" images:images];
    
    UIImage *image11 = [UIImage imageNamed:@"laoying.jpg"];
    UIImage *image12 = [UIImage imageNamed:@"yingwu.jpg"];
    UIImage *image13 = [UIImage imageNamed:@"xiaogou.jpg"];
    UIImage *image14 = [UIImage imageNamed:@"houzi.jpg"];
    UIImage *image15 = [UIImage imageNamed:@"yazi.jpg"];
    UIImage *image16 = [UIImage imageNamed:@"tuzi.jpg"];
    
    NSMutableArray *images2 = [NSMutableArray arrayWithObjects:image11, image12, image13, image14, image15,image16, nil];
    IntroPage * page2 = [[IntroPage alloc] initWithFrame:self.view.frame headTitle:@"Lovely Animals" bottomTitle:@"Love Animals?" images:images2];
    
    
    UIView *customView = [[UIView alloc] initWithFrame:self.view.frame];
    CustomView *v = [[CustomView alloc] initWithFrame:self.view.frame];
    [customView addSubview:v];
    
    IntroPage *page3 = [[IntroPage alloc] initWithCustomView:customView bTitle:@"Love Burning"];
    
    NSMutableArray * a = [NSMutableArray arrayWithObjects:page1, page2, page3,nil];
    IntroView * myView = [[IntroView alloc] initWithFrame:self.view.frame IntroPages:a];
    
    [self.view addSubview:myView];
    [myView.leftButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [myView.rightButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss
{
    //self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)present
{
    FirstViewController *first = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FirstViewController"];
    first.managedContext = self.managedContext;
    first.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:first animated:YES completion:nil];
}

@end
