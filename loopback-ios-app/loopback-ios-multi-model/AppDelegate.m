//
//  AppDelegate.m
//  loopback-ios-multi-model
//
//  Created by Matt Schmulen on 7/24/13.
//  Copyright (c) 2013 Matt Schmulen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

static LBRESTAdapter * _adapter = nil;

+ (LBRESTAdapter *) adapter
{
    if( !_adapter)
        _adapter = [LBRESTAdapter adapterWithURL:[NSURL URLWithString:@"http://localhost:3000"]];
    return _adapter;
}

// initializeServerWithDataIfNeeded
+ (void) initializeServerWithData
{
    [self initializeProductsData];
}

+ (void) initializeProductsData
{
    LBModelPrototype *ObjectPrototype = [ [AppDelegate adapter]  prototypeWithName:@"products"];
    
    //try and read from the endpoint if it comes back with empty set the push some default data to it.
    
    // Define the load error functional block
    void (^loadErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"initializeServerWithData : Error %@", error.description);
    };//end selfFailblock
    
    // Define the load success block for the LBModelPrototype allWithSuccess message
    void (^loadSuccessBlock)(NSArray *) = ^(NSArray *models) {
        
        if ( models.count <= 0 )
        {
            void (^saveNewErrorBlock)(NSError *) = ^(NSError *error) {
                NSLog( @"initializeServerWithData: Error on Save %@", error.description);
            };
            void (^saveNewSuccessBlock)() = ^() { };
            
            //Persist the newly created Model to the LoopBack node server
            [ [ObjectPrototype modelWithDictionary:@{ @"name": @"Product A", @"inventory" : @11, @"price" :@66.34 , @"units-sold" : @11 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
            [ [ObjectPrototype modelWithDictionary:@{ @"name": @"Product B", @"inventory" : @22, @"price" :@22.34 , @"units-sold" : @22 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
            [ [ObjectPrototype modelWithDictionary:@{ @"name": @"Product C", @"inventory" : @33, @"price" :@11.54 , @"units-sold" : @44 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
        }//end if models.cout <= 0
    };//end selfSuccessBlock
    
    [ObjectPrototype allWithSuccess: loadSuccessBlock failure: loadErrorBlock];
}

+ (void) initializeStoresData
{
    // Define the load error functional block
    void (^saveNewErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error on Save %@", error.description);
    };
    
    // Define the load success block for saveNewSuccessBlock message
    void (^saveNewSuccessBlock)() = ^() {
    };
    
    LBModelPrototype *prototype = [ [AppDelegate adapter]  prototypeWithName:@"cars"];
    //Persist the newly created Model to the LoopBack node server
    [ [prototype modelWithDictionary:@{ @"name": @"Toyota FJ", @"milage" : @200 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
    [ [prototype modelWithDictionary:@{ @"name": @"VW Bug", @"milage" : @300 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
    [ [prototype modelWithDictionary:@{ @"name": @"Hoda Accord", @"milage" : @400 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



+ (void) showGuideMessage : ( NSString *) message
{
    NSMutableDictionary *_guide = [[NSMutableDictionary alloc] init];

    [_guide setObject:@"Welcome to the StrongLoop ! node.js for Mobile Developers 'hello Node' App" forKey:@"Welcome"];
    
    //Tab1
    [_guide setObject:@"Get Started by removing the comment blocks in 'FirstViewController.m' to Create Update and Delete models from the node server" forKey:@"Tab 'One' Step1"];
    
    // Step 1: uncomment reminders
    [_guide setObject:@"No Models found, did you uncomment the commented code in '- ( void ) getModels' in 'FirstViewController.m' ?" forKey:@"Step1 uncomment getModels"];
    [_guide setObject:@"Dont forget to remove the //* comment blocks in '- ( void ) createNewModel' in 'FirstViewController.m' " forKey:@"Step1 uncomment createNewModel"];
    [_guide setObject:@"Dont forget to remove the //* comment blocks in '- ( void ) updateExistingModel' in 'FirstViewController.m' " forKey:@"Step1 uncomment updateExistingModel"];
    [_guide setObject:@"Dont forget to remove the //* comment blocks in '- ( void ) deleteExistingModel' in 'FirstViewController.m' " forKey:@"Step1 uncomment deleteExistingModel"];
    
    //Success Messages
    [_guide setObject:@"You created a model instance on the server, press 'Refresh' to update the local Table View " forKey:@"Tab 'One' CreateSuccess"];
    [_guide setObject:@"You updated a model instance on the server, press 'Refresh' to update the local Table View " forKey:@"Tab 'One' UpdateSuccess"];
    [_guide setObject:@"You deleted a model instance on the server, press 'Refresh' to update the local Table View " forKey:@"Tab 'One' DeleteSuccess"];
    
    
    //Tab2
    [_guide setObject:@"For this step uncomment the first comment block in app.js to publish a new set of models" forKey:@"Tab 'Two' Step2"];
    
    //Step 2 : uncomment reminders
    [_guide setObject:@"No Models found, did you uncomment the commented code in '- ( void ) getModels' in 'SecondViewController.m' ?" forKey:@"Step2 uncomment getModels"];
    [_guide setObject:@"Dont forget to remove the //* comment blocks in '- ( void ) createNewModel' in 'SecondViewController.m' " forKey:@"Step2 uncomment createNewModel"];
    [_guide setObject:@"Dont forget to remove the //* comment blocks in '- ( void ) updateExistingModel' in 'SecondViewController.m' " forKey:@"Step2 uncomment updateExistingModel"];
    [_guide setObject:@"Dont forget to remove the //* comment blocks in '- ( void ) deleteExistingModel' in 'SecondViewController.m' " forKey:@"Step2 uncomment deleteExistingModel"];
    
    //Tab3
    [_guide setObject:@"For this step verify the filter and find methods in ThirdViewController.m give you the product with lowest price and the lowest inventory http://localhost:8080/explore " forKey:@"Tab 'Three' Step3"];
    
    //Step 3 : uncomment reminders
    
    //Tab4
    [_guide setObject:@"For this step uncomment the third comment block code in app.js to publish a new set of models" forKey:@"Tab 'Four' Step4"];
    
    
    
    [_guide setObject:@"Press The Create Button to add a new record named 'I Just Added This' " forKey:@"Tab 'One' Create"];
    [_guide setObject:@"Press The Update Button to modify a record parameter on the server " forKey:@"Tab 'One' Update"];
    
    [_guide setObject:@"Press The Delete Button to delete a record on the server " forKey:@"Tab 'One' Delete"];
    [_guide setObject:@"Looking Good! Go to Tab2 'Second' and lets create a custom Model" forKey:@"Finished Tab1"];
    
    
    [_guide setObject:@"Does'nt look like your server is running. From the node-server folder start the server with \n'slc run app.js'\n and try again " forKey:@"No Server Found"];
    
    
    NSLog(@"Message: %@", [   _guide objectForKey:message]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:@"%@",message ]
                                                    message:[ _guide objectForKey:message]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
     
}//end showHelperMessage





@end
