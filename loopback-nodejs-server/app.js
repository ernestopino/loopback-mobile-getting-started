//Welcome to Loopback  Node.js Mobile API Server
var loopback = require('loopback')
, fs = require('fs')
, path = require('path')
, request = require('request')
, TaskEmitter = require('sl-task-emitter');
var importer = module.exports = new TaskEmitter();

//Create the LoopBack 'Mobile API' Object
var app = loopback();

//Create a Loopback in Memory Data Store
var DataStoreOne = loopback.createDataSource({ connector: loopback.Memory });

// ++++++++++++++++++++++++++++++++++++
 // Tab 1 ! 
// ++++++++++++++++++++++++++++++++++++
// This code is used for Tab One, of the Mobile App

// Define your Product 'Model' Type
var Tab1MobileModel = loopback.createModel('product', {
  name: { type: "String", required: true },
  inventory: { type: "Number", required: false }
});
//Attach your new ModelObject to the Memory DataStore
Tab1MobileModel.attachTo(DataStoreOne);
//Add the ProductWidget 'Model' to the LoopBack 'Mobile API' App
app.model(Tab1MobileModel);

//Lets Create Some default data for our Tab1MobileModel

var newProductA = {"name":"product A", inventory:7 };
var newProductB = {"name":"product B", inventory:7 };
var newProductC = {"name":"product C", inventory:7 };
importer.task(Tab1MobileModel, 'create', newProductA);
importer.task(Tab1MobileModel, 'create', newProductB);
importer.task(Tab1MobileModel, 'create', newProductC);
// ++++++++++++++++++++++++++++++++++++





// ++++++++++++++++++++++++++++++++++++
 // Tab 2 ! 
// ++++++++++++++++++++++++++++++++++++
// This code is used for Tab Two, of the Mobile App
// Define your Car 'Model' Type
// Uncomment the code below to provide data to Tab 2


// Set the if conditional to true the DataStoreTwo connect to an existing Oracle DB that we are hosting 
// else you can connect to another 'in-memory' data store, 
// 
var DataStoreTWO;
var Tab2MobileModel;
	
	// use an in-memory data store	
	Tab2MobileModel = loopback.createModel('car', {
	  name: { type: "String", required: true },
	  milage: { type: "Number", required: false }
	});
	
	//Create and Attach your new ModelObject to the Memory DataStore
	DataStoreTWO = loopback.createDataSource({ connector: loopback.Memory });
 	Tab2MobileModel.attachTo(DataStoreTWO);
	
	//Add the Tab2MobileModel 'Model' to the LoopBack 'Mobile API' App
	app.model(Tab2MobileModel);
	
	//Lets Create Some default data for our CarMobileModel
	var newCarA = {"name":"Mustang", milage:22 };
	var newCarB = {"name":"VW", milage:33 };
	var newCarC = {"name":"FJ", milage:44 };
	importer.task(Tab2MobileModel, 'create', newCarA);
	importer.task(Tab2MobileModel, 'create', newCarB);
	importer.task(Tab2MobileModel, 'create', newCarC);


// ++++++++++++++++++++++++++++++++++++
// Tab 3 ! Add a custom remote method call to our Mobile Model
// ++++++++++++++++++++++++++++++++++++
// This code is used for Tab Three, of the Mobile App
// Uncomment the code below to provide data to Tab 3

// CUSTOM METHOD 1
//  Expose a remote method, http://localhost:3000/cars/custommethod1
Tab2MobileModel.custommethod1 = function(fn )
{
	console.log("custommethod1 called");
	Tab2MobileModel.find({},fn);
};//end CarMobileModel.custommethod1

//  add the method to loopback as a remotable 'remote method call' under teh CarMobileModel
loopback.remoteMethod(
	Tab2MobileModel.custommethod1,
  	{
    	accepts: [ ],
    	returns: {arg: 'metric', root: true}
  	}
);//end added a remoteMethod 'myCustomRemoteMethod1'

// CUSTOM METHOD 2 
Tab2MobileModel.custommethod2 = function( arg1, arg2,fn )
{
	console.log("custommethod2 :" + arg1 + ","+  arg2);
	Tab2MobileModel.find({},fn);
};//end CarMobileModel.custommethod

//  Expose a remote method, http://localhost:3000/cars/custommethod2?arg1=yack&arg2=123
//  add the mehtod to loopback as a remotable 'remote method call' under teh CarMobileModel
loopback.remoteMethod(
	Tab2MobileModel.custommethod2,
  	{
    	accepts: [
      		{arg: 'arg1', type: 'String', required: true},
      		{arg: 'arg2', type: 'Number', description: 'some cool number'}
    	],
    	returns: {arg: 'metric', root: true}
  	}
);//end added a remoteMethod 'myCustomRemoteMethod2'

// CUSTOM METHOD 3
Tab2MobileModel.custommethod3 = function( arg1, arg2,fn )
{
	console.log("custommethod3 :" + arg1 + ","+  arg2);
	
	//use the existing CarMobileModel.find
	Tab2MobileModel.find({},fn);
	
	//Calculate the total milage across the entire fleet
	var totalFleetMilage = 0;
	//foreach car on the CarMobileModel 
	//{
	//  totalFleetMilage += 100;
	//}
};//end CarMobileModel.custommethod
loopback.remoteMethod(
	Tab2MobileModel.custommethod3,
  	{
    	accepts: [
      		{arg: 'arg1', type: 'String', required: true},
      		{arg: 'arg2', type: 'Number', description: 'some cool number'}
    	],
    	returns: {arg: 'metric', root: true}
  	}
);//end added a remoteMethod 'myCustomRemoteMethod3'








// ++++++++++++++++++++++++++++++++++++
// Tab 4 ! Lets Leverage the backend Server to Improve our mobile experience
// ++++++++++++++++++++++++++++++++++++
/*
 ... fib, security, something you must get access to the back end to do 
*/

/*
loopback.remoteMethod(
	new  function( arg1, arg2,fn ) {
		
	},
  	{
    	accepts: [
      		{arg: 'arg1', type: 'String', required: true},
      		{arg: 'arg2', type: 'Number', description: 'some cool number'}
    	],
    	returns: {arg: 'metric', root: true}
  	}
);//end added a remoteMethod 'myCustomRemoteMethod'

loopback.remoteMethod(
	new  function( arg1, arg2,fn ) {
		
	},
  	{
    	accepts: [
      		{arg: 'arg1', type: 'String', required: true},
      		{arg: 'arg2', type: 'Number', description: 'some cool number'}
    	],
    	returns: {arg: 'metric', root: true}
  	}
);//end added a remoteMethod 'myCustomRemoteMethod'
*/

//add the REST API for our loopback 'Mobile Models'
app.use(loopback.rest());

// Add static files
app.use(loopback.static(path.join(__dirname, 'public')));

//Start the server, listening to port 3000
app.listen(3000);
