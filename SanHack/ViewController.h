//
//  ViewController.h
//  SanHack
//
//  Created by Mani Batra on 29/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController
- (IBAction)lookButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *nav1;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)infoButtonAction:(id)sender;
@end
