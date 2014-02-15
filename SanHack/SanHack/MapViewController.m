//
//  MapViewController.m
//  SanHack
//
//  Created by Mani Batra on 30/11/12.
//  Copyright (c) 2012 Mani Batra. All rights reserved.
//

#import "MapViewController.h"
#import "DetailViewController.h"
#import <AddressBook/AddressBook.h>

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize map;

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
        UIImage *gradientImage32 = [[UIImage imageNamed:@"HomeTopNotificationBarWithout"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_nav1 setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsDefault];
    [_nav2 setBackgroundImage:[[UIImage imageNamed:@"BottomNotificationBar"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]  forBarMetrics:UIBarMetricsDefault ];
    changeColor=0;
    //[map setDelegate:self];
    ////[self fetchAll];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
   
    
}


-(void)centerMap:(PFGeoPoint*)geo forObject: (PFObject*)o{
    
    changeColor=0;
    MKCoordinateRegion mapRegion;

    mapRegion.center.latitude=18.59258;
    mapRegion.center.longitude=73.81836;
    mapRegion.span.latitudeDelta=0.6;
    mapRegion.span.longitudeDelta=0.6;
    
    
    if (zipAnnotation!=nil) {
        [map removeAnnotation: zipAnnotation];
    }
        
    [map setRegion:mapRegion animated:YES];
    
    
    //Uncomment to setup the "Complaints" database again
    
//    
//    PFQuery *queryA=[PFQuery queryWithClassName:@"Zones"];
//    queryA.cachePolicy=kPFCachePolicyCacheElseNetwork;
//    [queryA whereKeyExists:@"area"];
//    NSArray *objects=[queryA findObjects];
//        NSLog(@"making it zero");
//
//        for(PFObject *o in objects){
//            
//            
//            [o setObject:[NSNumber numberWithInt:0] forKey:@"count"];
//            [o saveInBackground];
//            
//            
//        }
    
   
    
    
    
   // MKMapPoint targetPoint = MKMapPointForCoordinate(targetCoordinate);
    //
    
    
    
    
//    PFQuery *query=[PFQuery queryWithClassName:@"Complaints"];
//    [query whereKey:@"completionFlag" equalTo:[NSNumber numberWithBool:false]];
//    NSArray *objects1= [query findObjects];
//        
//        for(PFObject *o in objects1){
//            PFGeoPoint *geo=[o objectForKey:@"coordinates"];
            CLLocationCoordinate2D locate=CLLocationCoordinate2DMake(geo.latitude, geo.longitude);
            MKMapPoint targetPoint = MKMapPointForCoordinate(locate);
            
            [self increaseCount:targetPoint withMapRegion:mapRegion forObject:o];
            
//            isInside= MKMapRectContainsPoint(mapRectD, targetPoint);
//            if(isInside==TRUE)
//                NSLog(@"true");
//            else
//                NSLog(@"false");

//            NSString *queryURL;
//            double latitude= locate.latitude;
//            double longitude= locate.longitude;
//            
//            queryURL = [[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false",latitude,longitude ];
//            NSURL *url = [[NSURL alloc] initWithString:queryURL];
//            NSData *data = [NSData dataWithContentsOfURL:url];
//            
//            NSError* error;
//            NSDictionary* json = [NSJSONSerialization
//                                  JSONObjectWithData:data
//                                  options:kNilOptions
//                                  error:&error];
//            
//            NSArray* addComp = [json objectForKey:@"results"];
//            
//            NSDictionary* comps = [addComp objectAtIndex:0];
//            NSString* address1=[comps objectForKey:@"formatted_address"];
//            NSLog(@"add %@", address1);
//            NSArray* addressArray = [address1 componentsSeparatedByString:@", "];
//            NSLog(@"%@", [addressArray objectAtIndex:0]);
//            
//            NSDictionary *address = @{
//            (NSString *)kABPersonAddressStreetKey: [addressArray objectAtIndex:0],
//            (NSString *)kABPersonAddressCityKey:[addressArray objectAtIndex:3],
//            (NSString *)kABPersonAddressStateKey:@"PUN",
//            (NSString *)kABPersonAddressZIPKey: @"0000",
//            (NSString *)kABPersonAddressCountryCodeKey: @"IN"
            
//            };

            zipAnnotation = [[MKPlacemark alloc] initWithCoordinate:locate addressDictionary:nil];
            [map addAnnotation:zipAnnotation];
            
            
        }
        
        
    
    
    

    
    




-(void) viewWillAppear:(BOOL)animated{
    
    [self fetchAll];
        
}

-(void) increaseCount:(MKMapPoint) targetPoint withMapRegion:(MKCoordinateRegion) mapRegion forObject: (PFObject*)o{
    
    
    CLLocationCoordinate2D topLeftCorner = mapRegion.center, corner;
    MKMapPoint topLeftPoint = MKMapPointForCoordinate(topLeftCorner);
    MKMapPoint cornerPoint;
    corner.latitude=mapRegion.center.latitude-.20000;
    corner.longitude=mapRegion.center.longitude+.20000;
    //CLLocationCoordinate2D targetCoordinate = mapRegion2.center;
    
    cornerPoint = MKMapPointForCoordinate(corner);
    MKMapRect mapRectD = MKMapRectMake(topLeftPoint.x, topLeftPoint.y, cornerPoint.x - topLeftPoint.x, cornerPoint.y - topLeftPoint.y);
    
    topLeftCorner.latitude+=.2;
    topLeftPoint=MKMapPointForCoordinate(topLeftCorner);
    corner.latitude = mapRegion.center.latitude;
    cornerPoint=MKMapPointForCoordinate(corner);
    MKMapRect mapRectA = MKMapRectMake(topLeftPoint.x, topLeftPoint.y, abs(cornerPoint.x - topLeftPoint.x), abs(cornerPoint.y - topLeftPoint.y));
    
    topLeftCorner.latitude=mapRegion.center.latitude+.2;
    topLeftCorner.longitude=mapRegion.center.longitude-.2;
    topLeftPoint=MKMapPointForCoordinate(topLeftCorner);
    corner.latitude = mapRegion.center.latitude;
    corner.longitude = mapRegion.center.longitude;
    cornerPoint=MKMapPointForCoordinate(corner);
    MKMapRect mapRectB = MKMapRectMake(topLeftPoint.x, topLeftPoint.y, abs(cornerPoint.x - topLeftPoint.x), abs(cornerPoint.y - topLeftPoint.y));
    
    topLeftCorner.latitude=mapRegion.center.latitude;
    topLeftPoint=MKMapPointForCoordinate(topLeftCorner);
    corner.latitude = mapRegion.center.latitude-.2;
    cornerPoint=MKMapPointForCoordinate(corner);
    MKMapRect mapRectC = MKMapRectMake(topLeftPoint.x, topLeftPoint.y, abs(cornerPoint.x - topLeftPoint.x), abs(cornerPoint.y - topLeftPoint.y));

    if(MKMapRectContainsPoint(mapRectA, targetPoint)){
        
        PFQuery *query=[PFQuery queryWithClassName:@"Zones"];
        PFObject *areaA=[query getObjectWithId:@"caiM80A688"];
        [areaA incrementKey:@"count" byAmount:[NSNumber numberWithInt:1]];
        [o setObject:@"A" forKey:@"region"];
        NSArray *saveThis=[NSArray arrayWithObjects:areaA,o, nil];
        [PFObject saveAllInBackground:saveThis];
        
    }
    else if(MKMapRectContainsPoint(mapRectB, targetPoint)){
        
        PFQuery *query=[PFQuery queryWithClassName:@"Zones"];
        PFObject *areaB=[query getObjectWithId:@"YEvJ9xAUR4"];
        [areaB incrementKey:@"count" byAmount:[NSNumber numberWithInt:1]];
        [o setObject:@"B" forKey:@"region"];
        NSArray *saveThis=[NSArray arrayWithObjects:areaB,o, nil];
        [PFObject saveAllInBackground:saveThis];
        
        
        
    }
    else if(MKMapRectContainsPoint(mapRectC, targetPoint)){
        
        PFQuery *query=[PFQuery queryWithClassName:@"Zones"];
        PFObject *areaC=[query getObjectWithId:@"IumfiCj2Os"];
        [areaC incrementKey:@"count" byAmount:[NSNumber numberWithInt:1]];
        [o setObject:@"C" forKey:@"region"];
        NSArray *saveThis=[NSArray arrayWithObjects:areaC,o, nil];
        [PFObject saveAllInBackground:saveThis];
        
        
    }
    else if (MKMapRectContainsPoint(mapRectD, targetPoint)){
        
        PFQuery *query=[PFQuery queryWithClassName:@"Zones"];
        PFObject *areaD=[query getObjectWithId:@"BkVYxo3eQR"];
        [areaD incrementKey:@"count" byAmount:[NSNumber numberWithInt:1]];
        [o setObject:@"D" forKey:@"region"];
        NSArray *saveThis=[NSArray arrayWithObjects:areaD,o, nil];
        [PFObject saveAllInBackground:saveThis];
        
        
    }
    else{
        
        PFQuery *query=[PFQuery queryWithClassName:@"Zones"];
        PFObject *areaOut=[query getObjectWithId:@"z7xooW423a"];
        [areaOut incrementKey:@"count" byAmount:[NSNumber numberWithInt:1]];
        [o setObject:@"Out" forKey:@"region"];
        NSArray *saveThis=[NSArray arrayWithObjects:areaOut,o, nil];
        [PFObject saveAllInBackground:saveThis];
        
        
    }

    
    
    
    
}

- (IBAction)addComplaint:(id)sender {
    
    [self performSegueWithIdentifier:@"complain" sender:self];
    
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    NSLog(@"%i", changeColor);
    MKPinAnnotationView *pinDrop=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"bhaarat"];
    pinDrop.canShowCallout=YES;
    //pinDrop.image=[UIImage imageNamed:@"AddComplaint.png"];
    
    if (changeColor==1) {
        
        pinDrop.pinColor=MKPinAnnotationColorRed;
        pinDrop.animatesDrop=NO;
        //changeColor=0;

    }else{
    
   pinDrop.pinColor=MKPinAnnotationColorPurple;
        pinDrop.animatesDrop=YES;

    
    }
    
    
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinDrop.rightCalloutAccessoryView=rightButton;
    
    CLLocationCoordinate2D geo=[annotation coordinate];
    
    PFGeoPoint *geoPoint=[PFGeoPoint geoPointWithLatitude:geo.latitude longitude:geo.longitude];
    NSString *co=[NSString stringWithFormat:@"%f, %f", geoPoint.latitude, geoPoint.longitude];
    rightButton.restorationIdentifier=co;
  

    
    
    
    

    [rightButton addTarget:self action:@selector(showDetails:)  forControlEvents:UIControlEventTouchUpInside];
    
    return pinDrop;
    
    
}


-(void) showDetails:(id)sender{
    
    UIButton *incoming=(UIButton*)sender;
    NSArray *array=[incoming.restorationIdentifier componentsSeparatedByString:@","];
    
    double x=[[array objectAtIndex:0] doubleValue];
    double y=[[array objectAtIndex:1] doubleValue];
    
    NSLog(@"%f, %f", x, y);

    PFGeoPoint *geoPoint=[PFGeoPoint geoPointWithLatitude:x longitude:y];

    PFQuery *query=[PFQuery queryWithClassName:@"Complaints"];
    query.cachePolicy=kPFCachePolicyIgnoreCache ;
      [query whereKey:@"coordinates" nearGeoPoint:geoPoint withinKilometers:0.08];
    [query addAscendingOrder:@"beforeRating"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSLog(@"%i", [objects count]);
        
        
    
               
               DetailViewController *dv=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        
       // NSLog(@"%@", [object objectForKey:@"objectId"]);
        
        dv.myUser=[objects objectAtIndex:0];
               
               UINavigationController *navigationController = [[UINavigationController alloc]
                                                               initWithRootViewController:dv];
               navigationController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
               
               [self presentViewController:navigationController animated:YES completion:nil];
               
           }];
            
    
            
            
    
    
    
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    for (aV in views) {
        CGRect endFrame = aV.frame;
        
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - 0.0, aV.frame.size.width, aV.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.45];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [aV setFrame:endFrame];
        [UIView commitAnimations];
        
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshAction:(id)sender {
    
    PFQuery *query= [PFQuery queryWithClassName:@"Zones"];
    [query whereKeyExists:@"count"];
    [query addAscendingOrder:@"count"];
    query.skip=4;
    
    PFQuery *run=[PFQuery queryWithClassName:@"Complaints"];
    [run whereKey:@"region" matchesKey:@"area" inQuery:query];
    [run findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self findCallback:objects error:error];
        
    }];
    
    
    
    
}

- (void)findCallback:(NSArray *)results error:(NSError *)error {
    
    NSLog(@"in callback");
    
    NSArray *ann=[map annotations];
    //[map removeAnnotations:ann];
    for(PFObject *o in results){
        
        PFGeoPoint *geo=[o objectForKey:@"coordinates"];
        CLLocationCoordinate2D locate=CLLocationCoordinate2DMake(geo.latitude, geo.longitude);
        
        for(id<MKAnnotation> a in ann){
            
            CLLocationCoordinate2D aLoc=[a coordinate];
            if ((aLoc.latitude==locate.latitude)&&(aLoc.longitude==locate.longitude)) {
                [map removeAnnotation:a];
                changeColor=1;
                [map addAnnotation:a];
                break;
            }
            
                        
        }
        
    }
    

}

- (IBAction)homeButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];


}

- (IBAction)refreshButtonAction:(id)sender {
    
    [self fetchAll];
    
}

-(void) fetchAll{
    
    changeColor=0;
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude=18.59258;
    mapRegion.center.longitude=73.81836;
    mapRegion.span.latitudeDelta=0.6;
    mapRegion.span.longitudeDelta=0.6;
    
    [map setRegion:mapRegion animated:YES];
    [map removeAnnotations:[map annotations]];
    
    PFQuery *query=[PFQuery queryWithClassName:@"Complaints"];
    
    [query whereKey:@"completionFlag" equalTo:[NSNumber numberWithBool:false]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for(PFObject *o in objects){
            
            PFGeoPoint *geo=[o objectForKey:@"coordinates"];
            zipAnnotation=[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(geo.latitude, geo.longitude) addressDictionary:nil];
            [map addAnnotation:zipAnnotation];
        }
    }];

    
}

-(void) incCount{
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Surveyor"];
    PFObject *object=[query2 getObjectWithId:@"qnF6yn8Ryr"];
    [object incrementKey:@"resolvedCases" byAmount:[NSNumber numberWithInt:1]];
    [object saveInBackground];

   
    
}
@end
