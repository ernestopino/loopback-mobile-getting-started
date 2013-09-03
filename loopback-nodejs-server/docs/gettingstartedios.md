Getting Started with the iOS "Getting Started App""

  1. Download the Getting Started App from [github](http://github.com/strongloop-community/loopback-guide-app)
  2. Start your StrongLoop Node Server in the /loopback-nodejs-server
  3. Open the XCode project in /loopback-ios-app and Run the iOS app in the iPhone Simulator
  4. Follow the Guide App instructions in the Simulator


yack yack yack 

> Node Inspector works only in Chrome browser at the moment. If you
are using a different browser, you will have to reopen Node
Inspector page in Chrome.

Here is a screenshot of a Node Inspector page in Chrome:

<img src="assets/node-inspector-initial.png" width="745px" alt="Initial screenshot"></img>

#### Working with Node Inspector

Now it's the time to set a breakpoint and inspect what's going on
under the hood of our blog application.

Click on the "Show navigator" icon in the upper-left corner to see a
tree-list of all blog source files. Expand "routes" folder and double
-click on "index.js". Click on line number 29 to set a breakpoint at
the beginning of `postComment` function.

