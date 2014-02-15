//
//  ComplaintViewController.m
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//

#import "ComplaintViewController.h"
#import "MapViewController.h"

@interface ComplaintViewController ()

@end

@implementation ComplaintViewController
@synthesize snap, beforePic, statusLabel, note, phoneNo ;

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
	// Do any additional setup after loading the view, typically from a nib.
    self.rateView.notSelectedImage=[UIImage imageNamed:@"DisabledStarButton.png"];
    self.rateView.halfSelectedImage=[UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage=[UIImage imageNamed:@"EnabledStarButton.png"];
    self.rateView.rating=0;
    self.ratingBefore=0;
    self.rateView.editable=YES;
    self.rateView.maxRating=5;
    self.rateView.delegate=self;
    
    UIImage *gradientImage32 = [[UIImage imageNamed:@"HomeTopNotificationBarWithout"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_nav1 setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsDefault];
    [_nav2 setBackgroundImage:[[UIImage imageNamed:@"BottomNotificationBar"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forBarMetrics:UIBarMetricsDefault ];

    
}



-(void) rateView:(RateView *)rateView ratingDidChange:(float)rating{
    
    self.statusLabel.text=[NSString stringWithFormat:@"Rating : %f", rating];
    self.ratingBefore=rating;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)snapAction:(id)sender {
    
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.editing=NO;
    
    imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
    imagePicker.delegate=self;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self presentViewController:imagePicker animated:YES completion:^{
        
        
        
    }];
    
    
    
}

- (IBAction)submitAction:(id)sender {
    
    
    NSString* description=self.note.text;
    
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [self.beforePic.image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    PFFile *imageFile=[PFFile fileWithName:@"image.jpg" data:imageData];
    
    [imageFile saveInBackground];
    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        PFObject *addComplaint=[PFObject objectWithClassName:@"Complaints"];
        [addComplaint setObject:imageFile forKey:@"beforePic"];
        [addComplaint setObject:description forKey:@"note"];
        [addComplaint setObject:@"8600042610" forKey:@"phoneNo"];
        [addComplaint setObject:[NSNumber numberWithFloat:self.ratingBefore] forKey:@"beforeRating"];
        [addComplaint setObject:geoPoint forKey:@"coordinates"];
        [addComplaint setObject:[NSNumber numberWithBool:NO] forKey:@"completionFlag"];
        [addComplaint saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            MapViewController *mvc=[[MapViewController alloc] init];
            [mvc centerMap:geoPoint forObject:addComplaint];
            [self.phoneNo setHidden:TRUE];
            [self dismissViewControllerAnimated:YES
                                     completion:nil];

//        MKMapPoint targetPoint=MKMapPointMake(geoPoint.latitude, geoPoint.longitude);
//        CLLocationCoordinate2D locate=CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
//        
//        MKCoordinateRegion mapRegion;
//        
//        mapRegion.center.latitude=18.59258;
//        mapRegion.center.longitude=73.81836;
//        mapRegion.span.latitudeDelta=0.6;
//        mapRegion.span.longitudeDelta=0.6;
//        MKPlacemark *zipAnnotation=[[MKPlacemark alloc] initWithCoordinate:locate addressDictionary:nil];
//        [addComplaint saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            MapViewController *map=[[MapViewController alloc] init];
//            [map increaseCount:targetPoint withMapRegion:mapRegion forObject:addComplaint];
            //[map.map addAnnotation:zipAnnotation];
            
            
            
                    
            
            //[self performSegueWithIdentifier:@"plot" sender:self];
            
        }];
        
        
    }];
    
    
        
}


- (IBAction)share:(id)sender {
    
    __weak IconActionSheet *sheet = [IconActionSheet sheetWithTitle:@""];
    
    [sheet addIconWithTitle:@"FaceBook" image:[UIImage imageNamed:@"Facebook.png"] block:^{
        SLComposeViewController *facebookSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:
                                               SLServiceTypeFacebook];
        facebookSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    [sheet dismissView];
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    [sheet dismissView];
                    break;
            }
            
                   };
        
        //  Set the initial body of the Tweet
        [facebookSheet setInitialText:self.note.text];
        
        //  Adds an image to the Tweet.  For demo purposes, assume we have an
        //  image named 'larry.png' that we wish to attach
        if (![facebookSheet addImage:self.beforePic.image]) {
            NSLog(@"Unable to add the image!");
        }
        
        //  Add an URL to the Tweet.  You can add multiple URLs.
        if (![facebookSheet addURL:[NSURL URLWithString:@"http://sanitationhackathon.org/"]]){
            NSLog(@"Unable to add the URL!");
        }
        
        //  Presents the Tweet Sheet to the user
        [self presentViewController:facebookSheet animated:NO completion:^{
            NSLog(@"Tweet sheet has been presented.");
        }];
    
    
    
    
    
    
    
    } atIndex:0];
    
    
    [sheet addIconWithTitle:@"Twitter" image:[UIImage imageNamed:@"twitter-icon.png"] block:^{
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                                  composeViewControllerForServiceType:
                                                  SLServiceTypeTwitter];
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    [sheet dismissView];
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    [sheet dismissView];
                    break;
            }
            
                    };
        
        //  Set the initial body of the Tweet
        [tweetSheet setInitialText:self.note.text];
        
        //  Adds an image to the Tweet.  For demo purposes, assume we have an
        //  image named 'larry.png' that we wish to attach
        if (![tweetSheet addImage:self.beforePic.image]) {
            NSLog(@"Unable to add the image!");
        }
        
        //  Add an URL to the Tweet.  You can add multiple URLs.
        if (![tweetSheet addURL:[NSURL URLWithString:@"http://sanitationhackathon.org/"]]){
            NSLog(@"Unable to add the URL!");
        }
        
        //  Presents the Tweet Sheet to the user
        [self presentViewController:tweetSheet animated:NO completion:^{
            NSLog(@"Tweet sheet has been presented.");
        }];
        
        
        
        
        
        
        
    } atIndex:-1];

    
    
    
    [sheet showInView:self.view];
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"did");
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"will");
    
}

- (IBAction)tweet:(id)sender {
}

-(void)goHome{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [snap setHidden:TRUE];
        [snap setEnabled:FALSE];
    }];
    self.beforePic.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    
}
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)hideKeyBoard:(id)sender{
    
    [self.note resignFirstResponder];
    
}

@end
