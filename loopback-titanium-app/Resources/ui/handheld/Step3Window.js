
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
	
	var imageView = Titanium.UI.createImageView({
		image:'icon_57x57.png',
		width:57,
		height:57,
		right:20,
		bottom:20
	});
	parentView.add( imageView );

	
	var buttonRefreshAll = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },		width:194,
		height:32,
		top:255,
		left:20,
		title:"Custom Method 1"
	});
	buttonRefreshAll.addEventListener('click', function(e) { parentView.refreshData(); });
	parentView.add( buttonRefreshAll );
	
	var buttonNewRecord = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },		width:194,
		height:32,
		top:295,
		left:20,
		title:"Custom Method 2"
	});
	parentView.add( buttonNewRecord );
	
	var buttonUpdateRecord = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },		width:194,
		height:32,
		top:335,
		left:20,
		title:"Custom Method 3"
	});
	parentView.add( buttonUpdateRecord );
	
	self.add ( parentView );
	return self;
};

module.exports = ApplicationWindow;


