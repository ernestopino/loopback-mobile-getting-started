//
//  FourthViewController.m
//  loopback-ios-multi-model
//
//  Created by Matt Schmulen on 7/24/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import "FourthViewController.h"
#import "AppDelegate.h"

@interface FourthViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelMethod1;
@property (weak, nonatomic) IBOutlet UILabel *labelMethod2;

@end

/*
[[[AppDelegate adapter] contract] addItem:[SLRESTContractItem itemWithPattern:@"/location/nearby" verb:@"GET"] forMethod:@"locations.getNearestFew"];
[LocationProto invokeStaticMethod:@"getNearestFew" parameters:@{
 @"here": @{
 @"lat": 37.587409,
 @"lng": -122.338225
 }
 } success:staticMethodSuccessBlock failure:staticMethodErrorBlock];
*/
@implementation FourthViewController


-( void) customMethod1 {
    
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
    
}//end CustomMethod1

-( void) customMethod2 {
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
    
}//end CustomMethod2

- (void)customMethod3 {
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)actionMethod1:(id)sender {
}
- (IBAction)actionMethod2:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[AppDelegate showGuideMessage: @"Tab 'Four' Step4"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
