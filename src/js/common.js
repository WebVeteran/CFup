var timer;
var timeSoFar = 0;
var initList = '';
var tempFile = '';
var tempSize = '';
	
function resetAll() {
	stop();
	timeSoFar = 0;
	initList = '';
	tempFile = '';
	tempSize = '';
	$('tempFile').innerHTML = '-';
	$('fileSize').innerHTML = '-';
	$('currentTime').innerHTML = '-';
	$('kbs').innerHTML = '-';
	$('stat').innerHTML = '-';
	$('serverFile').innerHTML = '-';
}

// get the inital list
function start() {
	resetAll();
	
	// I don't like dotted lines or halos
	$('submit').blur();

	$('stat').innerHTML = 'Getting initial temp dir list';
	new Ajax.Request('readTempDir.cfm', {method:'post', postBody:'', onSuccess:loadInitList, onFailure:errFunc});
	displayTimer();
}
var loadInitList = function(t) {
	$('stat').innerHTML = 'Loaded initial temp dir list';
	initList = t.responseText;
	$('tempFile').innerHTML = initList;
	
	$('submit').disabled=true;
	$('browseLabel').disabled=false;
	$('file').disabled=true;
	getNewList();
}

// get the new list as often as possible (up to to 5x/s)
// if there is a change, that is our temp file
function getNewList() {
	$('stat').innerHTML = 'Asking CF for list difference since last call';
	new Ajax.Request('readTempDir.cfm', {method:'post', postBody:'files='+escape(initList), onSuccess:loadDiff, onFailure:errFunc});
	displayTimer();
}
var loadDiff = function(t) {
	displayTimer();
	if (t.responseText!='') {
		// We have our temp file
		tempFile = t.responseText;
		$('stat').innerHTML = 'Temp file found: ' + tempFile;
		$('tempFile').innerHTML = tempFile;
		// start keeping track of the time
		timer = setInterval ( "timeSoFar=timeSoFar+1", 1000 );
		trackFileSize();
		$('fileSize').innerHTML = 0;
	} else {
		// We don't know our temp file yet
		$('stat').innerHTML = 'No change yet';
		setTimeout("getNewList()", 10 );
	}
}

// track it's size
function trackFileSize() {
	$('stat').innerHTML = 'Reading file size';
	new Ajax.Request('readTempFileSize.cfm', {method:'post', postBody:'file='+tempFile, onSuccess:loadSize, onFailure:errFunc});
}
var loadSize = function(t) {
	tempSize = t.responseText;
	displayTimer(tempSize);
	$('stat').innerHTML = 'Idle';
	// If not done uploading, get the size again. Chop chop, but leave time for the animation (.2s)
	if (t.responseText!='') { 
		setTimeout("trackFileSize();", 200);
	 }
}

function displayTimer(calc) {
	$('currentTime').innerHTML = timeSoFar;
	if (calc) {
		fileSize = Math.round(calc/1024);
		new Effect.CashRegister('fileSize', fileSize, {duration:0.2});
		$('kbs').innerHTML = Math.round(fileSize/timeSoFar);
	}
}

function stop() {
	// Stop keeping track of the time. Everyting else stops automatically.
	clearInterval(timer);
	$('submit').disabled=false;
	$('browseLabel').disabled=false;
	$('file').disabled=false;
}

var errFunc = function(t) {
	$('body').innerHTML = 'Error.<br>Status Code: ' + t.status + '.<br>Status Text: ' + t.statusText+'.<br><br>'+t.responseText;
}


Effect.CashRegister = Class.create();
Object.extend(Object.extend(Effect.CashRegister.prototype, Effect.Base.prototype), {
initialize: function(element, price) {
  var options = arguments[2] || {};
  this.element = $(element);
  this.startPrice = parseFloat(this.element.innerHTML);
  this.finishPrice = price;
  this.delta = (this.finishPrice-this.startPrice);
  this.start(options);
},
update: function(position) {
  var value = (this.startPrice + (this.delta*position)).toString().split('.');
  var cent  = value.length==1 ? '00' : (
    value[1].length == 1 ? value[1]+"0" : value[1].substring(0,2));
  Element.update(this.element, value[0]);
}
});
