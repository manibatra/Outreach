//
//  InfoViewController.m
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//

#import "InfoViewController.h"


@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize sPhoneNo;

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
    PFQuery *query=[PFQuery queryWithClassName:@"Surveyor"];
    PFObject *please=[query getObjectWithId:@"qnF6yn8Ryr"];
   
    NSNumber *damn=[please objectForKey:@"resolvedCases"] ;
    UIImage *gradientImage32 = [[UIImage imageNamed:@"HomeTopNotificationBarWithout"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_nav1 setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsDefault];
    self.count.text=[damn stringValue];
    
    NSLog(@"%@", self.count.text);
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    
    [self performSegueWithIdentifier:@"back" sender:self];
}
@end
