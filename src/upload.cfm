<!-- ah, fooey -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
        "http://www.w3.org/TR/1998/REC-html40-19980424/loose.dtd"> 
<HTML>
<HEAD>
<script src="js/scriptaculous/scriptaculous.cfm" type="text/javascript" charset="ISO-8859-1"></script>
</head>

<body>
<cffile action="upload" destination="#expandPath('./')#" nameConflict="Overwrite" fileField="file" result="upload">
<cffile action="delete" file="#expandPath('./#upload.serverfile#')#">

<cfoutput>
<script type="text/javascript">
<cfoutput>
self.parent.displayTimer(#upload.filesize#)
self.parent.stop();
self.parent.$('serverFile').innerHTML = '#upload.serverfile#';
setTimeout("self.parent.$('stat').innerHTML = 'Upload Complete. Server file copy deleted.';", 1100);
</cfoutput>
</script>
</cfoutput>

</body>
</html>