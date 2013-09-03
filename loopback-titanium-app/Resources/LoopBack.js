


(function (strongloop) {
	
	strongloop.dataCache = [{
        title: 'Loopers App',
        url: 'appDetail.js',
        url_scheme: 'nbcipad',
        hasChild: true,
        appID: '284910350',
        appName: 'Loopers App',
        appPublisher: 'StrongLoop.com',
        category: 'Corp',
        appiTunesURL: 'http://itunes.apple.com/us/app/nbc/id442839435?mt=8',
        appIcon: 'http://a4.mzstatic.com/us/r1000/093/Purple/42/1a/71/mzl.jeuiugjm.175x175-75.jpg',
        appDescription: ' StrongLoop Loopers Employee Directory, Favorite your often contaced co-workers - Contact Inforamation, Co-workers time zone.  Native Features for emailing, calling,  ',
    }
    ];
	
	var baseURL = 'http://127.0.0.1:3000';
	//var baseURL = 'http://50.56.187.151:3000';
	var defaultModelName = "nodeapps";
	
	strongloop.getBaseURL = function () {
		return baseURL;
	}//end getBaseURL
	
	// Public method for clearing the data cache
	strongloop.clearDataCache = function () {
		flightCollectionCache.clear();
		flightCollection = null;
	}
	
	strongloop.trackEngagement = function(durationInMs) {
		Ti.API.info( "trackEngagement ! " + durationInMs);
		
		var xhr = Ti.Network.createHTTPClient();
		xhr.timeout = 1000000;
		xhr.open("POST", "http://localhost:1080/1.0/event/put" );
		var currentDateTime = new Date();
		
		//process.env.TZ = 'UTC';
		var start = Date.now();
	    //stop = start + durationInMs;
		//start,

		var nMS = parseInt(durationInMs);
		if( isNaN(nMS))
		{
			nMS = 300;
		}  // Do something
		

		Ti.API.info( "currentDateTime -" + currentDateTime.toUTCString() );
		var postData = [
		  {
		    "type": "testAppc",
		    "time": start,//"2011-09-12T21:33:12Z", //start, 
		    "data": {
		      "host": "web14",
		      "path": "/search",
		      "query": {
		        "q": "flowers"
		      },
		      "duration_ms": nMS,// parseInt(durationInMs),//241,
		      "status": 200,
		      "user_agent": "Chrome/13.0.782.112"
		    }
		  }
		]; //end postData
		
		xhr.setRequestHeader("Content-Type","application/json");
		xhr.send(JSON.stringify(postData));
		
	}//end trackEngagement
	
	// Public method for updating the dataCache
    //   success: callback function to be notified when data has been retrieved
    //   error: callback function to be notified if an error occurs during retrieval
	strongloop.updateDataCache = function (success, error) {
		
		Ti.API.info( "updateDataCache ! ");
		// create table view data object
		var data = [];
		
		var xhr = Ti.Network.createHTTPClient();
		xhr.timeout = 1000000;
		xhr.open("GET",baseURL+"/json/"+ defaultModelName );
		
		xhr.onload = function()
		{
			Ti.API.info( "onload ! ");
			try
			{
				//Ti.API.info( "this.responseText " + this.responseText );
				var response = eval('('+this.responseText+')');
				Ti.API.info( response.toString() );
				
				for (var c=0; c<response.length; c++){
					var responseObject = response[c];
					//Ti.API.info( responseObject.appName.toString() );
				}//end for response
				
				success(response);
				
			}//end try
			catch(e){
				//alert(e);
				error(e);
			}//end catch
		};//end onload
		
		// Get the data
		xhr.send();
	};//end updateDataCache
	
	// Public method for updating the dataCache
    //   success: callback function to be notified when data has been retrieved
    //   error: callback function to be notified if an error occurs during retrieval
	strongloop.getData = function ( modelName , success, error) {
		// create table view data object
		var data = [];
		
		var xhr = Ti.Network.createHTTPClient();
		xhr.timeout = 1000000;
		xhr.open("GET", baseURL+"/" + modelName );
		//Ti.API.info( baseURL+"/" + modelName );
		
		xhr.onload = function()
		{
			Ti.API.info( "onload ! ");
			try
			{
				var response = eval('('+this.responseText+')');
				Ti.API.info( response.toString() );
				
				for (var c=0; c<response.length; c++){
					var responseObject = response[c];
					//Ti.API.info( responseObject["title"].toString() );
					//Ti.API.info( responseObject.appName.toString() );
				}//end for response
				success(response);
			}//end try
			catch(e){
				//alert(e);
				error(e);
			}//end catch
		};//end onload
		
		// Get the data
		xhr.send();
	};//end getData
	
	// Public method for updating the dataCache
    //   success: callback function to be notified when data has been retrieved
    //   error: callback function to be notified if an error occurs during retrieval
	strongloop.createRecord = function ( modelName , modelInstanceObject, success, error) {
		// create table view data object
		var data = [];
		
		var xhr = Ti.Network.createHTTPClient();
		xhr.timeout = 1000000;
		xhr.open("POST", baseURL+"/" + modelName );
		//Ti.API.info( baseURL+"/" + modelName );
		
		xhr.onload = function()
		{
			Ti.API.info( "onload createRecord ! ");
			try
			{
				var response = eval('('+this.responseText+')');
				Ti.API.info( response.toString() );
				
				success(response);
			}//end try
			catch(e){
				//alert(e);
				error(e);
			}//end catch
		};//end onload
		
		// Get the data
		xhr.send();
	};//end createRecord
	
	// Public method for updating the dataCache
    //   success: callback function to be notified when data has been retrieved
    //   error: callback function to be notified if an error occurs during retrieval
	strongloop.updateRecord = function ( modelName , modelInstanceData, success, error) {
		// create table view data object
		var data = [];
		
		var xhr = Ti.Network.createHTTPClient();
		xhr.timeout = 1000000;
		modelID = modelInstanceData.id;
		xhr.open("PUT", baseURL+"/" + modelName + "/" + modelID );
		xhr.setRequestHeader('X-HTTP-Method-Override',_method);
		
		xhr.onload = function()
		{
			Ti.API.info( "onload ! ");
			try
			{
				var response = eval('('+this.responseText+')');
				Ti.API.info( response.toString() );
				
				for (var c=0; c<response.length; c++){
					var responseObject = response[c];
					//Ti.API.info( responseObject["title"].toString() );
					//Ti.API.info( responseObject.appName.toString() );
				}//end for response
				success(response);
			}//end try
			catch(e){
				//alert(e);
				error(e);
			}//end catch
		};//end onload
		
		// Get the data
		xhr.send(modelInstanceData);
	};//end updateRecord
	
	// Public method for updating the dataCache
    //   success: callback function to be notified when data has been retrieved
    //   error: callback function to be notified if an error occurs during retrieval
	strongloop.deleteRecord = function ( modelName , modelInstanceObject, success, error) {
		
		var xhr = Ti.Network.createHTTPClient();
		xhr.timeout = 1000000;
		var objectID = modelInstanceObject.id;
		xhr.open("DELETE", baseURL+"/" + modelName +"/"+objectID);
		xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
		xhr.onload = function()
		{
			Ti.API.info( "onload ! ");
			try
			{
				var response = eval('('+this.responseText+')');
				Ti.API.info( response.toString() );
				success(response);
			}//end try
			catch(e){
				//alert(e);
				error(e);
			}//end catch
		};//end onload
		xhr.send();
	};//end deleteRecord
	
	
	
})(exports);




