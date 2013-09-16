//
//  ThirdViewController.m
//  loopback-ios-multi-model
//
//  Created by Matt Schmulen on 7/24/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelMethod1;
@property (weak, nonatomic) IBOutlet UILabel *labelMethod2;
@property (nonatomic) CLLocation *location;
@end

@implementation ThirdViewController

- (IBAction)actionMethod1:(id)sender {
        
    // Define the load error functional block
    void (^staticMethodErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };//end selfFailblock
    
    // Define the load success block for the LBModelPrototype allWithSuccess message
    void (^staticMethodSuccessBlock)() = ^(id result) {
        NSLog(@"Success on Static Method result: %@", result);
        
        self.labelMethod1.text = @"Response 1";
        
    };//end staticMethodSuccessBlock
    
    //Get a local representation of the 'cars' model type
    LBModelPrototype *objectB = [ [AppDelegate adapter] prototypeWithName:@"cars"];
    [[ [AppDelegate adapter]  contract] addItem:[SLRESTContractItem itemWithPattern:@"/cars/custommethod1" verb:@"GET"] forMethod:@"cars.custommethod1"];
    
    // Invoke the invokeStaticMethod message for the 'cars' LBModelPrototype
    // Equivalent http JSON endpoint request : http://localhost:3000/cars/custommethod1
    [objectB invokeStaticMethod:@"custommethod1" parameters:@{} success:staticMethodSuccessBlock failure:staticMethodErrorBlock ];
}

- (IBAction)actionMethod2:(id)sender {

    // Define the load error functional block
    void (^staticMethodErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };//end selfFailblock
    
    // Define the load success block for the LBModelPrototype allWithSuccess message
    void (^staticMethodSuccessBlock)() = ^(id result) {
        NSLog(@"Success on Static Method result: %@", result);
        
        self.labelMethod2.text = @"Response 2";

    };//end staticMethodSuccessBlock
    
    //Get a local representation of the 'cars' model type
    LBModelPrototype *objectB = [ [AppDelegate adapter] prototypeWithName:@"cars"];
    [[ [AppDelegate adapter]  contract] addItem:[SLRESTContractItem itemWithPattern:@"/cars/custommethod2" verb:@"GET"] forMethod:@"cars.custommethod2"];
    
    // Invoke the invokeStaticMethod message for the 'cars' LBModelPrototype
    // Equivalent http JSON endpoint request : http://localhost:3000/cars/custommethod2?arg1=yack&arg2=123
    [objectB invokeStaticMethod:@"custommethod2" parameters:@{@"arg1":@"yack" , @"arg2":@123} success:staticMethodSuccessBlock failure:staticMethodErrorBlock ];
    
}
- (IBAction)actionMethod3:(id)sender {
    
    // ++++++++++++++++++++++++++++++++++++
    // Uncomment the comment block below to call a custom method on the server
    // ++++++++++++++++++++++++++++++++++++
    
    // Define the load error functional block
    void (^staticMethodErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };//end selfFailblock
    
    // Define the load success block for the LBModelPrototype allWithSuccess message
    void (^staticMethodSuccessBlock)() = ^(id result) {
        NSLog(@"Success on Static Method result: %@", result);
    };//end staticMethodSuccessBlock
    
    //Get a local representation of the 'cars' model type
    LBModelPrototype *objectB = [ [AppDelegate adapter] prototypeWithName:@"cars"];
    [[ [AppDelegate adapter]  contract] addItem:[SLRESTContractItem itemWithPattern:@"/cars/custommethod3" verb:@"GET"] forMethod:@"cars.custommethod3"];
    
    // Invoke the invokeStaticMethod message for the 'cars' LBModelPrototype
    // Equivalent http JSON endpoint request : http://localhost:3000/cars/custommethod3?arg1=yack&arg2=123
    [objectB invokeStaticMethod:@"custommethod3" parameters:@{@"arg1":@"yack" , @"arg2":@123} success:staticMethodSuccessBlock failure:staticMethodErrorBlock ];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Updated location.");
    self.location = (CLLocation *)[locations lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error in updating location: %@", error);
}

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
    [AppDelegate showGuideMessage: @"Tab 'Three' Step3"];

    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    manager.delegate = self;
    [manager startUpdatingLocation];
    
    // In the event the location services are disabled, start with a default location:
    self.location = [[CLLocation alloc] initWithLatitude:37.587409 longitude:-122.338225];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
