<cfsetting enableCFoutputOnly="Yes">
<cfdirectory action="list" directory="#GetTempDirectory()#" name="list" listinfo="name" filter="*.tmp">
<cfset files = valueList(list.name, chr(9))>

<cfif not isdefined("form.files")>
	<cfoutput>#files#</cfoutput>
<cfelse>
	<cfset newList = valueList(list.name, chr(9))>
	<cfscript>
	/**
	* Compares two lists and returns the elements that do not appear in both lists.
	Returns a list that contains the elementsrest between list1 and list2
	*
	* @param list1      First list to compare (Required)
	* @param list2      Second list to compare (Required)
	* @param delimiters      Delimiter for all lists. Default is tab. (Optional)
	* @return Returns a string.
	* @author Ivan Rodriguez (wantez015@hotmail.com)
	* @version 1, June 26, 2002
	*/
	function ListDiff(list1,list2)    {
	var delimiters    = chr(9);
	var listReturn = "";
	var position = 1;
	
	// default list delimiter to a comma unless otherwise specified    
	if (arrayLen(arguments) gte 3){
	delimiters    = arguments[3];
	}
	        
	//checking list1
	for(position = 1; position LTE ListLen(list1,delimiters); position = position + 1) {
	value = ListGetAt(list1, position , delimiters );
	if (ListFindNoCase(list2, value , delimiters ) EQ 0)
	listReturn = ListAppend(listReturn, value , delimiters );
	}
	        
	//checking list2
	for(position = 1; position LTE ListLen(list2,delimiters); position = position + 1)    {
	value = ListGetAt(list2, position , delimiters );
	if (ListFindNoCase(list1, value , delimiters ) EQ 0)
	listReturn = ListAppend(listReturn, value , delimiters );
	}
	return listReturn;
	}
	</cfscript>
	<cfoutput>#ListDiff(newlist, form.files, chr(9))#</cfoutput>
</cfif>