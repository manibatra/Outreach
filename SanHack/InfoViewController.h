//
//  InfoViewController.h
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface InfoViewController : UIViewController
@property(strong, nonatomic) NSString *sPhoneNo;

@property (weak, nonatomic) IBOutlet UILabel *count;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UINavigationBar *nav1;

@end
