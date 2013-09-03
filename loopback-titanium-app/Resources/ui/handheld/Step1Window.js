
function ApplicationWindow(title) {
	
	var defaultColorBlue = '#035385';
	var defaultColorRed = '#9a0707';
	var rowColor = '#EBEBEB';
	var selectedRowColor = '#4B4B4B';
	var backgroundColor = '#4B4B4B';
	var defaultColor = defaultColorRed;
	var fontColor = "#0F451F";
	
	var self = Ti.UI.createWindow({ title:title, backgroundColor:'white'});
	
	//create object instance, a parasitic subclass of Observable
	var parentView = Ti.UI.createView();
	
	var imageView = Titanium.UI.createImageView({
		image:'icon_57x57.png',
		width:57,
		height:57,
		right:20,
		bottom:20
	});	
	parentView.add( imageView );
	
	var tv = Ti.UI.createTableView({
		top: 47,
		width:280,
		height:200
	});
	tv.addEventListener('click', function(e) { });
	parentView.add( tv );
	
	parentView.refreshData = function() {
		Ti.API.info(" self.refreshData ");
		var LoopBack = require('LoopBack');
		LoopBack.getData("weapons", function(data) {
			//Ti.API.info ( "success data[0] " + data[0].title );
			parentView.updateTableView(data);
		}, function() {
			Ti.API.info(" error");
		});
	};
	
	parentView.createNewRecord = function() {
		Ti.API.info(" self.createNewRecord ");
		var LoopBack = require('LoopBack');
		LoopBack.createRecord("weapons", {"name":"myNewObject" }, function(data) {
			//parentView.updateTableView(data);
			parentView.refreshData();
		}, function() {
			Ti.API.info(" error");
		});
	};
	
	parentView.updateExistingRecord = function() {
		Ti.API.info(" self.updateExistingRecord ");
		var LoopBack = require('LoopBack');
		LoopBack.updateRecord("weapons",{}, function(data) {
			//parentView.updateTableView(data);
			parentView.refreshData();
		}, function() {
			Ti.API.info(" error");
		});
	};
	
	parentView.deleteExistingRecord = function() {
		Ti.API.info(" self.deleteExistingRecord ");
		var LoopBack = require('LoopBack');
		LoopBack.deleteRecord("weapons", {"id":2},function(data) {
			//parentView.updateTableView(data);
			parentView.refreshData();
		}, function() {
			Ti.API.info(" error");
		});
	};
	
	parentView.updateTableView = function(newData) { 
		var data = [];
		var rows = [];
		for (var i = 0; i < newData.length; i++) {
			var rowObject = newData[i];
			Ti.API.info(" Add " + rowObject.name);
			var row = Ti.UI.createTableViewRow({});
			row.title = rowObject.name;
			data.push(row);
		}//end for
		tv.setData(data);
	};//end updateTableView
	
	var buttonRefreshAll = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },
		width:194,
		height:32,
		top:255,
		left:20,
		title:"Refresh All"
	});
	buttonRefreshAll.addEventListener('click', function(e) { parentView.refreshData(); });
	parentView.add( buttonRefreshAll );
	
	var buttonNewRecord = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },
		width:194,
		height:32,
		top:295,
		left:20,
		title:"Create New Record"
	});
	buttonNewRecord.addEventListener('click', function(e) { parentView.createNewRecord(); });
	parentView.add( buttonNewRecord );
	
	var buttonUpdateRecord = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },
		width:194,
		height:32,
		top:335,
		left:20,
		title:"Update Existing Record"
	});
	buttonUpdateRecord.addEventListener('click', function(e) { parentView.updateExistingRecord(); });
	parentView.add( buttonUpdateRecord );
	
	var buttonDeleteRecord = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },
		width:194,
		height:32,
		top:375,
		left:20,
		title:"Delete Existing Record"
	});
	buttonDeleteRecord.addEventListener('click', function(e) { parentView.deleteExistingRecord(); });
	parentView.add( buttonDeleteRecord );
	
	self.add ( parentView );
	return self;
};

module.exports = ApplicationWindow;
