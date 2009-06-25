<HTML>
<HEAD>
	<TITLE>CFup: Upload Progress Prototype - build 090624</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="window-target" content="_top /">
	<meta http-equiv="imagetoolbar" content="no" />
	<link rel="icon" href="/favicon.ico" />
	<link rel="shortcut icon" href="/favicon.ico" />
	<meta name="copyright" content="Gravinese Enterprises Inc." />
	<meta name="author" content="Jules Gravinese" />
	<meta name="generator" content="Jules Gravinese" />
	<meta name="host" content="http://www.WebVeteran.com" />
	<link rel="prefetch" href="http://www.webveteran.com/">
	<meta name="description" content="CFup: Upload Progress Prototype. Coldfusion only file upload progress indicator.">
	<meta name="keywords" content="ColdFusion, Upload Progress">
	<script src="js/scriptaculous/scriptaculous.cfm" type="text/javascript" charset="ISO-8859-1"></script>
	<script src="js/common.js" type="text/javascript" charset="ISO-8859-1"></script>
	<link rel="stylesheet" rev="stylesheet" href="common.css" type="text/css" media="all" charset="utf-8" />
</head>
<body id="body">

<h1>CFup: Upload Progress Prototype - build 090624</h1>
This demonstration shows how to give users an upload progress indicator<br>
in ColdFusion - without Flash, Java, or anything else funky.<br>
It makes use of:

<ul><b>Fancy Upload</b>
	<li> Replaces the ugly 'browse' button with something nicer</li>
	<li> Shows a file icon and file name for confirmation before uploading</li>
</ul>

<ul><b>Scriptaculous</b>
	<li> AJAX and DOM utilities</li>
</ul>

<ul><b>ColdFusion</b>
	<li> Uploads the file</li>
	<li> Reads the temp directory to track the uploading [temp] file</li>
	<li> Deletes the uploaded copy</li>
</ul>

<ol><b>Usage</b>
	<li> Browse to a file (something that will take +10s to upload)</li>
	<li> Click upload</li>
	<li> Repeat!</li>
</ol>

<table border="1" cellspacing="0" cellpadding="10" width="400"><Tr><td><cfform action="upload.cfm" target="uploadframe" method="post" enctype="multipart/form-data" onsubmit="start();">
	
	<cfset variables.FUrequired = "1">
	<cfset variables.FUmessage = "Please select a JPG">
	<cfset variables.FUtype = "">
	<cfset variables.FUloadbase = "1">
	<cfset variables.FUlabelposition = "right">
	<cfset variables.FUwidth = "300px">
	<cfset variables.FUheight = "20px">
	<cfset variables.FUinputname = "file">
	<cfinclude template="js/fancy_upload/fancyupload.cfm">
	
	<br><br>
	<input type="submit" id="submit" value="Upload"> 
</cfform>
<iframe name="uploadframe" id="uploadframe" width="1" height="1" frameborder="0"></iframe>
<br><br>

<table>
	<tr>
		<td>Temp File:</td>
		<td id="tempFile">-</td>
	</tr>
	<tr>
		<td>Uploaded:</td>
		<td><span id="fileSize">-</span> kb</td>
	</tr>
	<tr>
		<td>Time:</td>
		<td><span id="currentTime">-</span> s</td>
	</tr>
	<tr>
		<td>Speed:</td>
		<td><span id="kbs">-</span> kb/s</td>
	</tr>
	<tr>
		<td>Server File:</td>
		<td id="serverFile">-</td>
	</tr>
	<tr>
		<td>Status:</td>
		<td id="stat">-</td>
	</tr>
</table>
</td></TR></table>

<body>

</html>