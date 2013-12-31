//
//  SecondViewController.m
//  loopback-ios-multi-model
//
//  Created by Matt Schmulen on 7/24/13.
//  Copyright (c) 2013 StrongLoop All rights reserved.
//

/*
 Tab 2, Step 2
 
 This Tab shows you how to Create Update and Delete Model types with an inheritance paradigm instead of functional blocks with Value Pairs
 
 Uncomment the code sections below to enable
 - Referesh
 - Create
 - Update
 - Delete
 
 You will need to have your Loopback Node server running
 
 You can start your Loopback Node server from the command line terminal with $slnode run app.js from within the loopback-nodejs-server/ folder
 */


#import "SecondViewController.h"
#import "AppDelegate.h"


//Define a Local Objective C representation of the our LoopBack mobile model type
@interface Car : LBModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSNumber *milage;
@end

@implementation Car
@end

@interface CarPrototype : LBModelRepository
+ (instancetype)prototype;
@end

@implementation CarPrototype
+ (instancetype)prototype { return [self repositoryWithClassName:@"cars"]; }
@end


@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) CarPrototype *prototypeObjectReference;
@property (strong, nonatomic) NSArray *tableData;

@property (strong, nonatomic) Car *myCarModelInstance;
@end

@implementation SecondViewController


- (CarPrototype *) prototypeObjectReference
{
    if (!_prototypeObjectReference)
        _prototypeObjectReference = (CarPrototype *)[ [AppDelegate adapter]  repositoryWithClass:[CarPrototype class]];
    return _prototypeObjectReference;
}

- (Car *) myCarModelInstance
{
    if (_myCarModelInstance)
        _myCarModelInstance = [[Car alloc]init];
    return _myCarModelInstance;
}

- (NSArray *) tableData
{
    if ( !_tableData) _tableData = [[NSArray alloc] init];
    return _tableData;
};

- ( void ) getModels
{
    // ++++++++++++++++++++++++++++++++++++
    // The block below gets all the 'car' models from the server
    // ++++++++++++++++++++++++++++++++++++
    
    void (^loadFailBlock)(NSError *) = ^(NSError *error) {
        [AppDelegate showGuideMessage: @"No Server Found"];
    };//end selfFailblock
    
    LBModelRepository *objectB = [ [AppDelegate adapter] repositoryWithModelName:@"car"];
    
    // Invoke the allWithSuccess message for the 'ammo' LBModelPrototype
    // Equivalent http JSON endpoint request : http://localhost:3000/car
    [ self.prototypeObjectReference allWithSuccess:^(NSArray *models) {
        NSLog( @"Success %d", [models count]);
        
        self.tableData = models;
        [self.myTableView reloadData];
    } failure:loadFailBlock];
    return;
    
    [AppDelegate showGuideMessage: @"Step2 uncomment getModels"];
    
};//end getModels


- ( void ) createNewModel
{
    // ++++++++++++++++++++++++++++++++++++
    // The block below to creates a new 'car' model on the server
    // ++++++++++++++++++++++++++++++++++++
    
    NSLog( @"CreateNew Model and push to the server");
    
    void (^saveNewFailBlock)(NSError *) = ^(NSError *error) {
        [AppDelegate showGuideMessage: @"No Server Found"];
    };
    
    LBModelRepository *prototype = [ [AppDelegate adapter]  repositoryWithModelName:@"car"];
    
    Car *modelInstance = (Car*)[self.prototypeObjectReference modelWithDictionary:@{}];
    modelInstance.name = @"Telsa Model S";
    modelInstance.milage = @9;
    NSLog( @"Created local Object %@", [modelInstance toDictionary]);
    
    [modelInstance saveWithSuccess:^{
        NSLog( @"Save Success %@", modelInstance.name );
        //lastId = model._id;
        
        // call a 'local' refresh to update the tableView
        [self getModels];
    } failure:saveNewFailBlock];
    
    //[ modelInstance invokeMethod:@"custommethod" parameters:<#(NSDictionary *)#> success:<#^(id value)success#> failure:<#^(NSError *error)failure#>]
    return;
    
    [AppDelegate showGuideMessage: @"Step2 uncomment createNewModel"];
}//end createNewModuleAndPushToServer

- ( void ) updateExistingModel
{
    // ++++++++++++++++++++++++++++++++++++
    //  The block below first finds the model with id = 2 and then updates the 'milage' parameter on the server
    // ++++++++++++++++++++++++++++++++++++
    
    // Define the find error functional block
    void (^findErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error No model found with ID %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };
    
    // Define your success functional block
    void (^findSuccessBlock)(LBModel *) = ^(LBModel *model) {
        //dynamically add an 'inventory' variable to this model type before saving it to the server
        model[@"milage"] = @"7777";
        
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
    
    //Get a local representation of the 'cars' model type
    LBModelRepository *prototype = [ [AppDelegate adapter]  repositoryWithModelName:@"cars"];
    
    //Get the instance of the model with ID = 2
    // Equivalent http JSON endpoint request : http://localhost:3000/cars/2
    [prototype findById:@2 success:findSuccessBlock failure:findErrorBlock ];
    return;
    
    [AppDelegate showGuideMessage: @"Step2 uncomment updateExistingModel"];
    
}//end updateExistingModelAndPushToServer

- ( void ) deleteExistingModel
{
    // ++++++++++++++++++++++++++++++++++++
    //  The block below first finds the model with id = 2 and then deletes the model from the server
    // ++++++++++++++++++++++++++++++++++++
    
    // Define the find error functional block
    void (^findErrorBlock)(NSError *) = ^(NSError *error) {
        NSLog( @"Error No model found with ID %@", error.description);
        [AppDelegate showGuideMessage: @"No Server Found"];
    };
    
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
    
    //Get a local representation of the 'car' model type
    LBModelRepository *prototype = [ [AppDelegate adapter]  repositoryWithModelName:@"cars"];
    
    //Get the instance of the model with ID = 2
    // Equivalent http JSON endpoint request : http://localhost:3000/cars/2
    [prototype findById:@2 success:findSuccessBlock failure:findErrorBlock ];
    return;
    
    [AppDelegate showGuideMessage: @"Step2 uncomment deleteExistingModel"];
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
        //cell.textLabel.text = model[@"name"]; //[model objectForKeyedSubscript:@"name"];
        //cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ - %@", modelInstance.name, [ modelInstance.milage stringValue] ];
        
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ - %@", [model objectForKeyedSubscript:@"name"], (int)[model objectForKeyedSubscript:@"milage"] ];
        
    }
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AppDelegate initializeStoresData];
    [AppDelegate showGuideMessage: @"Tab 'Two' Step2"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
