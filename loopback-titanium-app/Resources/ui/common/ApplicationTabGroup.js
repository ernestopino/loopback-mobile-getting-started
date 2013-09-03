function ApplicationTabGroup(Window) {
	//create module instance
	var self = Ti.UI.createTabGroup();
	
	var WelcomeWindow = require('ui/handheld/WelcomeWindow');
	var Step1Window = require('ui/handheld/Step1Window');
	var Step2Window = require('ui/handheld/Step2Window');
	var Step3Window = require('ui/handheld/Step3Window');
	var Step4Window = require('ui/handheld/Step4Window');
	
	//create app tabs
	var win1 = new Window(L('home')),
		win2 = new Step1Window(L('settings')),
		win3 = new Step2Window(L('settings')),
		win4 = new Step3Window(L('settings')),
		win5 = new Step4Window(L('settings'));
	
	win1.hideNavBar();
	win2.hideNavBar();
	win3.hideNavBar();
	win4.hideNavBar();
	win5.hideNavBar();
	
	var tab1 = Ti.UI.createTab({
		title: L('Welcome'),
		icon: '/images/first.png',
		window: win1
	});
	win1.containingTab = tab1;
	
	var tab2 = Ti.UI.createTab({
		title: L('Step 1'),
		icon: '/images/num-one.png',
		window: win2
	});
	win2.containingTab = tab2;
	
	var tab3 = Ti.UI.createTab({
		title: L('Step 2'),
		icon: '/images/num-two.png',
		window: win3
	});
	win3.containingTab = tab3;
	
	var tab4 = Ti.UI.createTab({
		title: L('Step 3'),
		icon: '/images/num-three.png',
		window: win4
	});
	win4.containingTab = tab4;
	
	var tab5 = Ti.UI.createTab({
		title: L('Step 4'),
		icon: '/images/num-four.png',
		window: win5
	});
	win5.containingTab = tab5;
	
	self.addTab(tab1);
	self.addTab(tab2);
	self.addTab(tab3);
	self.addTab(tab4);
	self.addTab(tab5);
	
	Ti.App.addEventListener('setActiveTabIndex',function(e)
	{
	  	self.setActiveTab(e.tabIndex);
	});
	
	return self;
};

module.exports = ApplicationTabGroup;
