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
@end

@implementation ThirdViewController

// Find and Filter
- (void) findProductGreatestInventory {
    
    //Find the Product with the Product With the Lowest Inventory
    
    // HTTP REST Call:
    // http://localhost:3000/products?filter[order]=inventory%20ASC&filter[limit]=1
    
    void (^staticMethodErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };//end selfFailblock
    
    // Define the load success block for the LBModelPrototype allWithSuccess message
    void (^staticMethodSuccessBlock)() = ^(id result) {
        NSLog(@"Success on Static Method result: %@", result);
        
        LBModel *model = (LBModel *)[result objectAtIndex:0];
        self.labelMethod1.text = [[NSString alloc] initWithFormat:@"%@, inventory: %@",
                                  [model objectForKeyedSubscript:@"name"] ,
                                  (int)[model objectForKeyedSubscript:@"inventory"] ];
        
    };//end staticMethodSuccessBlock
    
    LBModelPrototype *objectProto = [ [AppDelegate adapter] prototypeWithName:@"products"];
    
    [[ [AppDelegate adapter] contract] addItem:[SLRESTContractItem itemWithPattern:@"/products" verb:@"GET"] forMethod:@"products.filter"];
    
    //Product with lowest inventory
    // http://localhost:3000/products?filter[order]=inventory%20ASC&filter[limit]=1': The highest inventory products
    [objectProto invokeStaticMethod:@"filter" parameters:@{ @"filter[order]":@"inventory ASC",@"filter[limit]":@1} success:staticMethodSuccessBlock failure:staticMethodErrorBlock];
    
    // Docs reference:
    // http://docs.strongloop.com/loopback/#example-request-4
    
}//end findPoductLowestInventory

- (void) findProductLowestPrice {
    
    //Find the Product with the Product With the Lowest Inventory
    
    // HTTP REST Call:
    // http://localhost:3000/products?filter[order]=inventory%20ASC&filter[limit]=1
    
    void (^staticMethodErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };//end selfFailblock
    
    // Define the load success block for the LBModelPrototype allWithSuccess message
    void (^staticMethodSuccessBlock)() = ^(id result) {
        NSLog(@"Success on Static Method result: %@", result);
        
        LBModel *model = (LBModel *)[result objectAtIndex:0];
        self.labelMethod2.text = [[NSString alloc] initWithFormat:@"%@, $%@",
                                  [model objectForKeyedSubscript:@"name"],
                                  [model objectForKeyedSubscript:@"price"] ];
    };//end staticMethodSuccessBlock
    
    LBModelPrototype *objectProto = [ [AppDelegate adapter] prototypeWithName:@"products"];
    
    [[ [AppDelegate adapter] contract] addItem:[SLRESTContractItem itemWithPattern:@"/products" verb:@"GET"] forMethod:@"products.filter"];
    
    //Product with lowest inventory
    // http://localhost:3000/products?filter[order]=inventory%20ASC&filter[limit]=1': The highest inventory products
    [objectProto invokeStaticMethod:@"filter" parameters:@{ @"filter[order]":@"price ASC",@"filter[limit]":@1} success:staticMethodSuccessBlock failure:staticMethodErrorBlock];
    
    // Docs reference:
    // http://docs.strongloop.com/loopback/#example-request-4
    
}//end findProductHighest

- (IBAction)actionMethod1:(id)sender {
    [self findProductGreatestInventory];
}

- (IBAction)actionMethod2:(id)sender {
    [self findProductLowestPrice];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
