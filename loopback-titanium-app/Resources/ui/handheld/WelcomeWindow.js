function ApplicationWindow(title) {

	var defaultColorBlue = '#035385';
	var defaultColorRed = '#9a0707';
	var rowColor = '#EBEBEB';
	var selectedRowColor = '#4B4B4B';
	var backgroundColor = '#4B4B4B';
	var defaultColor = defaultColorRed;
	
	var fontColor = "#0F451F";
	
	var self = Ti.UI.createWindow({
		title : title,
		backgroundColor : 'white'
	});

	//create object instance, a parasitic subclass of Observable
	var parentView = Ti.UI.createView();

	//label using localization-ready strings from <app dir>/i18n/en/strings.xml
	var labelWelcome = Ti.UI.createLabel({
		color:fontColor,
		text:'Welcome',
		font: { fontSize: 30, fontWeight: 'bold' },
		top: 6,
		height:'auto',
		width:'auto'
	});
	self.add(labelWelcome);
	
	var labelTopBody = Ti.UI.createLabel({
		color:fontColor,
		text:'Each tab in this app will guide you through what you need to get started using the LoopBack Node for your Mobile App.',
		font: { fontSize: 15 },
		top: 50,
		height:'auto',
		width:'auto'
	});
	self.add(labelTopBody);
	
	var labelTopBody2 = Ti.UI.createLabel({
		color:fontColor,
		text:'Just follow the tips and uncomment the code for each feature',
		font: { fontSize: 15 },
		top: 130,
		height:'auto',
		width:'auto'
	});
	self.add(labelTopBody2);
	
	var labelNum1 = Ti.UI.createLabel({
		color:fontColor, text:'❶', font: { fontSize: 19, fontWeight: 'bold' }, height:'auto', width:'auto',
		top: 192,
		left: 6
	});
	self.add(labelNum1);
	
	var labelStep1 = Ti.UI.createLabel({
		color:fontColor,
		text:'Getting your CrUD together',
		font: { fontSize: 15 },
		top: 192,
		left: 34,
		height:'auto',
		width:'auto'
	});
	self.add(labelStep1);

	var labelNum2 = Ti.UI.createLabel({
		color:fontColor, text:'❷', font: { fontSize: 19, fontWeight: 'bold' }, height:'auto', width:'auto',
		top: 225,
		left: 6
	});
	self.add(labelNum2);
	
	var labelStep2 = Ti.UI.createLabel({
		color:fontColor,
		text:'Become a model citizen',
		font: { fontSize: 15 },
		top: 225,
		left: 34,
		height:'auto',
		width:'auto'
	});
	self.add(labelStep2);
	
	
	var labelNum3 = Ti.UI.createLabel({
		color:fontColor, text:'❸', font: { fontSize: 19, fontWeight: 'bold' }, height:'auto', width:'auto',
		top: 260,
		left: 6
	});
	self.add(labelNum3);
	
	var labelStep3 = Ti.UI.createLabel({
		color:fontColor,
		text:'NPM is NoPrblM',
		font: { fontSize: 15 },
		top: 260,
		left: 34,
		height:'auto',
		width:'auto'
	});
	self.add(labelStep3);
	
	var labelNum4 = Ti.UI.createLabel({
		color:fontColor, text:'❹', font: { fontSize: 19, fontWeight: 'bold' }, height:'auto', width:'auto',
		top: 291,
		left: 6
	});
	self.add(labelNum4);
	
	var labelStep4 = Ti.UI.createLabel({
		color:fontColor,
		text:'Crush Server Latency with Node',
		font: { fontSize: 15 },
		top: 291,
		left: 34,
		height:'auto',
		width:'auto'
	});
	self.add(labelStep4);
	
	var imageView = Titanium.UI.createImageView({
		image : 'icon_57x57.png',
		width : 57,
		height : 57,
		right : 20,
		bottom : 20
	});
	parentView.add(imageView);

	var buttonOpenTab = Titanium.UI.createButton({
		color:fontColor,
		font: { fontSize: 15, fontWeight: 'bold' },
		width : 190,
		height : 60,
		top : 335,
		left: 20,
		title : "Start with the next Tab"
	});
	buttonOpenTab.addEventListener('click', function(e) { Ti.API.info( "click setActiveTabIndex" ); Ti.App.fireEvent('setActiveTabIndex',{tabIndex:1}); });
	parentView.add(buttonOpenTab);
	
	self.add(parentView);
	return self;
};

module.exports = ApplicationWindow;

