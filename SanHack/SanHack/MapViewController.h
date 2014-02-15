#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"
#import "ComplaintViewController.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>
{
    IBOutlet MKMapView *map;
    MKPlacemark *zipAnnotation;
    int changeColor;
    

}

@property (nonatomic, retain) MKMapView *map;

- (IBAction)refreshAction:(id)sender;
-(void) increaseCount:(MKMapPoint) targetPoint withMapRegion:(MKCoordinateRegion) mapRegion forObject: (PFObject*)o;
- (IBAction)addComplaint:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationBar *nav1;
@property (weak, nonatomic) IBOutlet UINavigationBar *nav2;

- (IBAction)homeButtonAction:(id)sender;
- (IBAction)refreshButtonAction:(id)sender;
-(void)centerMap:(PFGeoPoint*)geo forObject: (PFObject*)o;


-(void) incCount;

@end