//
//  ComplaintViewController.h
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Social/Social.h>
#import "RateView.h"
#import "IconActionSheet.h"
#import "MapViewController.h"

//extern int count;
//extern NSString *phone;
@interface ComplaintViewController : UIViewController<RateViewDelegate, UIImagePickerControllerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *snap;
@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beforePic;
@property (weak, nonatomic) IBOutlet UITextField *phoneNo;
@property (weak, nonatomic) IBOutlet UITextView *note;
@property (weak, nonatomic) IBOutlet UINavigationBar *nav1;
@property (weak, nonatomic) IBOutlet UINavigationBar *nav2;
-(IBAction)hideKeyBoard:(id)sender;

- (IBAction)backAction:(id)sender;
@property(nonatomic, assign) int ratingBefore;
- (IBAction)snapAction:(id)sender;
- (IBAction)submitAction:(id)sender;
- (IBAction)share:(id)sender;
-(void)goHome;


@end
