<cfsetting enableCFoutputOnly="Yes">
<cfdirectory action="list" directory="#GetTempDirectory()#" name="list" listinfo="name,size" filter="#form.file#">
<cfoutput>#list.size#</cfoutput>