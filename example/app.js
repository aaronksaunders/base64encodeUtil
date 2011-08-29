// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
window.add(label);
window.open();

// TODO: write your module tests here
var utils = require('com.clearlyinnovative.utils');
Ti.API.info("module is => " + utils);

var f = Ti.Filesystem.getFile("allgood.png");
Ti.API.info(utils.base64encode( f.read() ));
var encoded_string = utils.base64encode( f.read() );


var newDir = Titanium.Filesystem.getFile(Titanium.Filesystem.applicationDataDirectory,'mydir');
Ti.API.info("Created mydir: " + newDir.createDirectory());
Ti.API.info('newdir ' + newDir.nativePath);
var newFile = Titanium.Filesystem.getFile(newDir.nativePath,'newfile.png');
newFile.write(Ti.Utils.base64decode(encoded_string));