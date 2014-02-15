//
//  ViewController.m
//  SanHack
//
//  Created by Mani Batra on 29/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize toolbar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_nav1 setBackgroundImage:[[UIImage imageNamed:@"HomeTopNotificationBarWithout"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forBarMetrics:UIBarMetricsDefault ];
                     

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lookButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"map" sender:self];
    
}

- (IBAction)infoButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"info" sender:self];
}
@end
