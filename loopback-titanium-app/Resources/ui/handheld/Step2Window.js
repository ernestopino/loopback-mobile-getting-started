
function ApplicationWindow(title) {
	
	var defaultColorBlue = '#035385';
	var defaultColorRed = '#9a0707';
	var rowColor = '#EBEBEB';
	var selectedRowColor = '#4B4B4B';
	var backgroundColor = '#4B4B4B';
	var defaultColor = defaultColorRed;
	
	var fontColor = "#0F451F";
	
	var self = Ti.UI.createWindow({
		title:title,
		backgroundColor:'white'
	});
	
	//create object instance, a parasitic subclass of Observable
	var parentView = Ti.UI.createView();
	
	/*
	//label using localization-ready strings from <app dir>/i18n/en/strings.xml
	var label = Ti.UI.createLabel({
		color:'#000000',
		text:'Hello, Node!',
		top: 5,
		height:'auto',
		width:'auto'
	});
	parentView.add(label);
	
	
	//Add behavior for UI
	label.addEventListener('click', function(e) {
		alert(e.source.text);
	});
	*/
	
	var imageView = Titanium.UI.createImageView({
		image:'icon_57x57.png',
		width:57,
		height:57,
		right:20,
		bottom:20
	});
	
	parentView.add( imageView );
	
	var tv = Ti.UI.createTableView({
		top: 30,
		width:280,
		height:217
	});
	tv.addEventListener('click', function(e) { });
	parentView.add( tv );
	
	parentView.refreshData = function() {
		Ti.API.info(" self.refreshData ");
		var LoopBack = require('LoopBack');
		LoopBack.getData("locations", function(data) {
			//Ti.API.info ( "success data[0] " + data[0].title );
			parentView.updateTableView(data);
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
		font: { fontSize: 15, fontWeight: 'bold' },		width:194,
		height:32,
		top:295,
		left:20,
		title:"Create New Record"
	});
	parentView.add( buttonNewRecord );
	
	var buttonUpdateRecord = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },		width:194,
		height:32,
		top:335,
		left:20,
		title:"Update Existing Record"
	});
	parentView.add( buttonUpdateRecord );
	
	var buttonDeleteRecord = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },		width:194,
		height:32,
		top:375,
		left:20,
		title:"Delete Existing Record"
	});
	parentView.add( buttonDeleteRecord );
	
	
	/*
	//add Listeners
	Titanium.App.addEventListener('WindowAppListingRefreshData', function(e) {
		parentView.refreshData();
	});
	parentView.addEventListener('open', function() {
		//self.refreshData();
	});
	*/
	
	/*
	var button = Ti.UI.createButton({
		height:44,
		width:200,
		title:L('openWindow'),
		top:20
	});
	self.add(button);
	
	button.addEventListener('click', function() {
		//containingTab attribute must be set by parent tab group on
		//the window for this work
		self.containingTab.open(Ti.UI.createWindow({
			title: L('newWindow'),
			backgroundColor: 'white'
		}));
	});
	*/
	
	self.add ( parentView );
	return self;
};

module.exports = ApplicationWindow;


