//
//  DetailViewController.m
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end


@implementation DetailViewController
@synthesize objectId, myUser,beforePic, afterPic, userRating, criticRating, note, snap, sPhoneNo, nav1, nav2;

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
    // Do any additional setup after loading the view from its nib.
    
    self.sPhoneNo=@"8600042610";
    self.navigationController.navigationBarHidden=TRUE;
    self.userRating.notSelectedImage=[UIImage imageNamed:@"kermit_empty.png"];
    self.userRating.halfSelectedImage=[UIImage imageNamed:@"kermit_half.png"];
    self.userRating.fullSelectedImage=[UIImage imageNamed:@"kermit_full.png"];
    self.userRating.editable=NO;
    self.userRating.rating=0;
    self.userRating.maxRating=5;
    self.userRating.delegate=self;
    
    self.criticRating.notSelectedImage=[UIImage imageNamed:@"kermit_empty.png"];
    self.criticRating.halfSelectedImage=[UIImage imageNamed:@"kermit_half.png"];
    self.criticRating.fullSelectedImage=[UIImage imageNamed:@"kermit_full.png"];
    self.criticRating.editable=YES;
    self.criticRating.rating=0;
    self.criticRating.maxRating=5;
    self.criticRating.delegate=self;
    
    PFGeoPoint *geoPoint=[myUser objectForKey:@"coordinates"];
    
    NSLog(@"%f", geoPoint.latitude);
    
    
    
    PFQuery *query=[PFQuery queryWithClassName:@"Complaints"];
    [query whereKey:@"coordinates" nearGeoPoint:geoPoint withinKilometers:5];
    [query addAscendingOrder:@"beforeRating"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        
        PFObject *object=[objects objectAtIndex:0];
        NSNumber *rating=[object objectForKey:@"beforeRating"];
        self.userRating.rating=[rating floatValue];
        //self.userRating.editable=NO;
        NSLog(@"%f", self.userRating.rating);
        self.note.editable=FALSE;
        self.note.text=[object objectForKey:@"note"];
        PFFile *imageFile=[object objectForKey:@"beforePic"];
        self.objectId=object.objectId;
        NSLog(@"%@", objectId);
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            
            NSData *imageData=data;
            self.beforePic.image=[UIImage imageWithData:imageData];
            
        }];
        
    }];
    
    
    UIImage *gradientImage32 = [[UIImage imageNamed:@"HomeTopNotificationBarWithout"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [nav1 setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsDefault];
    [nav2 setBackgroundImage:[[UIImage imageNamed:@"BottomNotificationBar"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forBarMetrics:UIBarMetricsDefault ];

    
    
}

-(void) rateView:(RateView *)rateView ratingDidChange:(float)rating{

    self.criticRating.rating=rating;

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareAction:(id)sender {
    
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
        if (![facebookSheet addImage:self.afterPic.image]) {
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
        if (![tweetSheet addImage:self.afterPic.image]) {
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

- (IBAction)submitAction:(id)sender {
    
    MapViewController *mvc=[[MapViewController alloc] init];
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [self.afterPic.image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    PFFile *imageFile=[PFFile fileWithName:@"image.jpg" data:imageData];
    [imageFile saveInBackground];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Complaints"];
    [query whereKey:@"objectId" equalTo:self.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
        PFObject *resolve=[objects objectAtIndex:0];
        [resolve setObject:[NSNumber numberWithBool:true] forKey:@"completionFlag"];
        [resolve setObject:imageFile forKey:@"afterPic"];
        [resolve setObject:[NSNumber numberWithFloat:self.criticRating.rating] forKey:@"afterRating"];
    [resolve saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
        
            [self dismissViewControllerAnimated:YES completion:nil];
            [mvc incCount];
        }
        
        
    }
     ];
    }];
    
    

    
    
    
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

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [snap setHidden:TRUE];
        [snap setEnabled:FALSE];
    }];
    self.afterPic.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    
}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
