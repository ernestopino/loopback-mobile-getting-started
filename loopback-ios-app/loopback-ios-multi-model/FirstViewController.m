//
//  FirstViewController.m
//  loopback-ios-multi-model
//
//  Created by Matt Schmulen on 7/24/13.
//  Copyright (c) 2013 StrongLoop All rights reserved.
//


/*
 Tab 1, Step 1
 
 This Tab shows you how to Create Read Update and Delete Model (CRUD) types and persist to the LoopBack server,
 
 You need to uncomment the code sections in the methods below to enable the Create Update & Delete Operations
 - ( void ) getModels
 - ( void ) createNewModel
 - ( void ) updateExistingModel
 - ( void ) deleteExistingModel
 
 You will need to have your Loopback Node server running
 
 You can start your Loopback Node server from the command line terminal with $slnode run app.js from within the loopback-nodejs-server/ folder
 
 You can find developer doc's for LoopBack here:
 http://docs.strongloop.com/loopback
 
 */

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *tableData;
@end

@implementation FirstViewController

- (NSArray *) tableData
{
    if ( !_tableData) _tableData = [[NSArray alloc] init];
    return _tableData;
};

- ( void ) getModels
{
    // ++++++++++++++++++++++++++++++++++++
    // Uncomment the comment block below to call a custom method on the server
    // ++++++++++++++++++++++++++++++++++++
    
    // Define the load success block for the LBModelPrototype allWithSuccess message
    void (^loadSuccessBlock)(NSArray *) = ^(NSArray *models) {
        NSLog( @"selfSuccessBlock %d", models.count);
        self.tableData  = models;
        [self.myTableView reloadData];
        // [self showGuideMessage:@"Great! you just pulled code from node"];
    };//end selfSuccessBlock
    
    // Define the load error functional block
    void (^loadErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };//end selfFailblock
    
    //Get a local representation of the 'products' model type
    LBModelPrototype *prototype = [ [AppDelegate adapter]  prototypeWithName:@"products"];
    
    // Invoke the allWithSuccess message for the 'products' LBModelPrototype
    // Equivalent http JSON endpoint request : http://localhost:3000/products
    
    [prototype allWithSuccess: loadSuccessBlock failure: loadErrorBlock];
    return;
    
    [AppDelegate showGuideMessage: @"Step1 uncomment getModels"];
};


- ( void ) createNewModel
{
    // ++++++++++++++++++++++++++++++++++++
    // Uncomment the comment block below to call a custom method on the server
    // ++++++++++++++++++++++++++++++++++++
    
    //Get a local representation of the 'products' model type
    LBModelPrototype *prototype = [ [AppDelegate adapter] prototypeWithName:@"products"];
    
    //create new LBModel of type
    LBModel *model = [prototype modelWithDictionary:@{ @"name": @"New Product", @"inventory" : @99, @"price" :@13.34 , @"units-sold" : @44 }];
    
    // Define the load success block for saveNewSuccessBlock message
    void (^saveNewSuccessBlock)() = ^() {
        [AppDelegate showGuideMessage: @"Tab 'One' CreateSuccess"];
        
        // call a 'local' refresh to update the tableView
        [self getModels];
    };
    
    // Define the load error functional block
    void (^saveNewErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error on Save %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };
    
    //Persist the newly created Model to the LoopBack node server
    [model saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
    return;
    
    [AppDelegate showGuideMessage: @"Step1 uncomment createNewModel"];
};

- ( void ) updateExistingModel
{
    // ++++++++++++++++++++++++++++++++++++
    // Uncomment the comment block below to call a custom method on the server
    // ++++++++++++++++++++++++++++++++++++
    
    // Define your success functional block
    void (^findSuccessBlock)(LBModel *) = ^(LBModel *model) {
        //dynamically add an 'inventory' variable to this model type before saving it to the server
        model[@"inventory"] = @"66";
        
        //Define the save error block
        void (^saveErrorBlock)(NSError *) = ^(NSError *error) {
            NSLog( @"Error on Save %@", error.description);
        };
        
        void (^saveSuccessBlock)() = ^() {
            [AppDelegate showGuideMessage: @"Tab 'One' UpdateSuccess"];
            
            // call a 'local' refresh to update the tableView
            [self getModels];
        };
        [model saveWithSuccess:saveSuccessBlock failure:saveErrorBlock];
    };
    
    // Define the find error functional block
    void (^findErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error No model found with ID %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };

    //Get a local representation of the 'products' model type
    LBModelPrototype *prototype = [ [AppDelegate adapter] prototypeWithName:@"products"];
    
    //Get the instance of the model with ID = 2
    // Equivalent http JSON endpoint request : http://localhost:3000/products/2
    [prototype findWithId:@2 success:findSuccessBlock failure:findErrorBlock ];
    return;
    
    
    [AppDelegate showGuideMessage: @"Step1 uncomment updateExistingModel"];
}//end updateExistingModelAndPushToServer

- ( void ) deleteExistingModel
{
    // ++++++++++++++++++++++++++++++++++++
    // Uncomment the comment block below to call a custom method on the server
    // ++++++++++++++++++++++++++++++++++++
    
    // Define your success functional block
    void (^findSuccessBlock)(LBModel *) = ^(LBModel *model) {
        
        //Define the save error block
        void (^removeErrorBlock)(NSError *) = ^(NSError *error) {
            NSLog( @"Error on Save %@", error.description);
        };
        void (^removeSuccessBlock)() = ^() {
            [AppDelegate showGuideMessage: @"Tab 'One' DeleteSuccess"];
            
            // call a 'local' refresh to update the tableView
            [self getModels];
        };
        
        //Destroy this model instance on the LoopBack node server
        [ model destroyWithSuccess:removeSuccessBlock failure:removeErrorBlock ];
    };
    
    // Define the find error functional block
    void (^findErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error No model found with ID %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };
    
    //Get a local representation of the 'products' model type
    LBModelPrototype *prototype = [ [AppDelegate adapter] prototypeWithName:@"products"];
    
    //Get the instance of the model with ID = 2
    // Equivalent http JSON endpoint request : http://localhost:3000/products/2
    [prototype findWithId:@2 success:findSuccessBlock failure:findErrorBlock ];
    return;
    
    [AppDelegate showGuideMessage: @"Step1 uncomment deleteExistingModel"];
}//end deleteExistingModel

- (IBAction)actionRefresh:(id)sender {
    [self getModels];
}

- (IBAction)actionCreate:(id)sender {
    [self createNewModel];
}

- (IBAction)actionUpdate:(id)sender {
    [self updateExistingModel];
}

- (IBAction)actionDelete:(id)sender {
    [self deleteExistingModel];
}

// UITableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if ( [[ [self.tableData objectAtIndex:indexPath.row] class] isSubclassOfClass:[LBModel class]])
    {
        LBModel *model = (LBModel *)[self.tableData objectAtIndex:indexPath.row];
        //cell.textLabel.text = model[@"name"]; // [model objectForKeyedSubscript:@"name"];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ - %@",
                               [model objectForKeyedSubscript:@"name"] ,
                               (int)[model objectForKeyedSubscript:@"inventory"] ];
    }
    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [AppDelegate initializeServerWithData];
    [AppDelegate showGuideMessage: @"Tab 'One' Step1"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.screenName = @"FirstViewController";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (void) initializeServerWithData
{
    // Define the load error functional block
    void (^saveNewErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error on Save %@", error.description);
    };
    
    // Define the load success block for saveNewSuccessBlock message
    void (^saveNewSuccessBlock)() = ^() {
    };
    
    LBModelPrototype *prototype = [  [AppDelegate adapter]  prototypeWithName:@"products"];
    //Persist the newly created Model to the LoopBack node server
    [ [prototype modelWithDictionary:@{ @"name": @"Product A", @"inventory" : @11 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
    [ [prototype modelWithDictionary:@{ @"name": @"Product B", @"inventory" : @22 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
    [ [prototype modelWithDictionary:@{ @"name": @"Product C", @"inventory" : @33 }]  saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];
    
}
*/

@end
