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
 
 Custom node.js methods loopback-mobile-getting-started/loopback-nodejs-server/modules/product/index.js
 
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
        
        self.labelMethod1.text = [[NSString alloc] initWithFormat:@"fed %@ - state %@",
                                  [[result objectForKey:@"currentTax"] objectForKey:@"federal"],
                                  [[result objectForKey:@"currentTax"] objectForKey:@"state"]
                                  ];
        
    };//end staticMethodSuccessBlock
    
    //Get a local representation of the model type
    LBModelPrototype *objectB = [ [AppDelegate adapter] prototypeWithName:@"products"];
    [[ [AppDelegate adapter]  contract] addItem:[SLRESTContractItem itemWithPattern:@"/products/taxInfo" verb:@"GET"] forMethod:@"products.taxInfo"];
    
    // Invoke the invokeStaticMethod message
    // Equivalent http JSON endpoint request : http://localhost:3000/products/taxInfo
    [objectB invokeStaticMethod:@"taxInfo" parameters:@{} success:staticMethodSuccessBlock failure:staticMethodErrorBlock ];
    
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
        
        self.labelMethod2.text = [[NSString alloc] initWithFormat:@" %@ ",
                                  [[result objectForKey:@"totalInventoryValuation"] objectForKey:@"inventoryValuation"]
                                  ];
    };//end staticMethodSuccessBlock
    
    //Get a local representation of the model type
    LBModelPrototype *objectB = [ [AppDelegate adapter] prototypeWithName:@"products"];
    [[ [AppDelegate adapter]  contract] addItem:[SLRESTContractItem itemWithPattern:@"/products/totalValuation" verb:@"GET"] forMethod:@"products.totalValuation"];
    
    // Invoke the invokeStaticMethod message for the 'products' LBModelPrototype
    // Equivalent http JSON endpoint request : http://localhost:3000/products/totalValuation
    [objectB invokeStaticMethod:@"totalValuation" parameters:@{} success:staticMethodSuccessBlock failure:staticMethodErrorBlock ];
    
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
    [self customMethod1];
}

- (IBAction)actionMethod2:(id)sender {
    [self customMethod2];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[AppDelegate showGuideMessage: @"Tab 'Four' Step4"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.screenName = @"FourthViewController";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
 
 
 //Add the following code to loopback-nodejs-server/modules/product/index.js before model.exports.product; and after the applications.forEach block.
 
 var tax = { federal:0.1, state: 0.22 };
 
 //http://localhost:3000/products/taxInfo
 product.currentTax = function(fn) {
 fn( null, tax );
 }
 
 loopback.remoteMethod(
 product.currentTax,
 {
 returns: {arg: 'currentTax', type: 'object'},
 http: {path: '/taxInfo', verb: 'get'}
 }
 );
 
 
 // http://localhost:3000/products/totalValuation
 product.totalInventoryValuation = function(fn) {
 product.find(function(err, products) {
 
 var totalValuation = { inventoryValuation : 0 };
 for (var i = 0; i < products.length; i++) {
 if(typeof products[i].price != 'undefined' && typeof products[i].inventory != 'undefined' )
 totalValuation.inventoryValuation += products[i].price * products[i].inventory;
 }//end for
 
 fn(null, totalValuation);
 });
 }//end addTax
 
 loopback.remoteMethod(
 product.totalInventoryValuation,
 {
 returns: {arg: 'totalInventoryValuation', type: 'object'},
 http: {path: '/totalValuation', verb: 'get'}
 }
 );
 

 
 [[[AppDelegate adapter] contract] addItem:[SLRESTContractItem itemWithPattern:@"/location/nearby" verb:@"GET"] forMethod:@"locations.getNearestFew"];
 [LocationProto invokeStaticMethod:@"getNearestFew" parameters:@{
 @"here": @{
 @"lat": 37.587409,
 @"lng": -122.338225
 }
 } success:staticMethodSuccessBlock failure:staticMethodErrorBlock];
 
 
 
 */


@end
