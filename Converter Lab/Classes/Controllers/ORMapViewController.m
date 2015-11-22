//
//  ORMapViewController.m
//  Converter Lab
//
//  Created by RomanOsadchuk on 19.11.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORMapViewController.h"
#import <MapKit/MapKit.h>

@interface ORMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ORMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *fullAddress= [NSString stringWithFormat:@"UA , %@, %@,  %@" ,
                           self.bankSelected.city, self.bankSelected.region, self.bankSelected.address];
    
    [self setAnnotationWithAddress:fullAddress];
    
}

-(void)setAnnotationWithAddress:(NSString *)address{
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *topResult = [placemarks firstObject];
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.coordinate, 1000, 1000);
            
//            MKCoordinateRegion region = self.mapView.region;
//            region.center = [(CLCircularRegion *)placemark.region center];
//            region.span.longitudeDelta /= 8.0;
//            region.span.latitudeDelta /= 8.0;
            
            [self.mapView setRegion:region animated:YES];
            [self.mapView addAnnotation:placemark];
        }else{
            [self showAlertWithTitle:@"Извините" message:@"Местоположение данного банка не найдено"];
        }
    }];
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    
    static NSString *identifier=@"Identifier";
    
    MKPinAnnotationView *pin= (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.pinColor=MKPinAnnotationColorPurple;
        pin.animatesDrop=YES;
        pin.canShowCallout=YES;
        
        
    }else{
        pin.annotation=annotation;
    }
    return pin;
}

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message{
    [[[UIAlertView alloc]
      initWithTitle:title
      message:message
      delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil]show];
}

@end
