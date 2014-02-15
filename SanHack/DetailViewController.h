//
//  DetailViewController.h
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RateView.h"
#import "MapViewController.h"
#import <Social/Social.h>

@interface DetailViewController : UIViewController<RateViewDelegate,UIImagePickerControllerDelegate>


@property(strong, nonatomic) NSString *objectId;
@property(strong, nonatomic) NSString *sPhoneNo;
@property(strong, nonatomic) PFObject *myUser;
@property (weak, nonatomic) IBOutlet UIImageView *beforePic;
@property (weak, nonatomic) IBOutlet UIImageView *afterPic;
@property (weak, nonatomic) IBOutlet RateView *userRating;
- (IBAction)snapAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *snap;
- (IBAction)dismiss:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationBar *nav2;
@property (weak, nonatomic) IBOutlet UINavigationBar *nav1;

@property (weak, nonatomic) IBOutlet UITextView *note;
@property (weak, nonatomic) IBOutlet RateView *criticRating;
- (IBAction)shareAction:(id)sender;
- (IBAction)submitAction:(id)sender;

@end
