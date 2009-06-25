<cfif cgi.HTTP_ACCEPT_ENCODING contains "gzip">
	<cfheader name="Content-Encoding" value="gzip" >
	<cfheader name="Content-Disposition" value="inline; filename=""protoaculous182min.jgz""">
	<cfheader name="Content-Type" value="application/x-javascript; charset=ISO-8859-1">
	<cfif cgi.HTTP_USER_AGENT contains 'MSIE 6.0; Windows'>
		<cfheader name="Pragma" value="">
		<cfheader name="Cache-control" value="">
	</cfif>
	<cfcontent deletefile="no" file="#expandpath('./protoaculous182min.jgz')#" type="application/x-javascript; charset=ISO-8859-1">
<cfelse>
	<cfheader name="Content-Disposition" value="inline; filename=""protoaculous182min.js""">
	<cfheader name="Content-Type" value="application/x-javascript; charset=ISO-8859-1">
	<cfinclude template="protoaculous182min.js">
</cfif>