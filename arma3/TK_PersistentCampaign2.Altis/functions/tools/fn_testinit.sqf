/*

	Description:
	Export function descriptions to Community Wiki.
	Exported text will be copied to clipboard in XML format.
	Import it to wiki using https://community.bistudio.com/wiki?title=Special:Import
	If the page already exists, it will be replaced only when timestamp is newer.

	Parameter(s):
		0: ARRAY - functions filter in format [<tags>,<categories>,<functions>]
			tags: STRING or ARRAY of STRINGs - CfgFunctions tags (e.g., "BIS"). Use empty string for all of them.
			categories: STRING or ARRAY of STRINGs - categories (e.g., "Debug"). Use empty string for all of them.
			functions: STRING or ARRAY of STRINGs - specific function names (e.g., "BIS_fnc_log"). Use empty string for all of them.
		1 (Optional) STRING - timestamp in format "2013-09-12T16:00:00Z"

	Returns:
	STRING - exported text

	Example:
	Export all functions:		[] spawn bis_fnc_exportFunctionsToWiki;
	Export all Array functions:	["","Arrays"] spawn bis_fnc_exportFunctionsToWiki;
	Export specific functions:	["","",["BIS_fnc_log","BIS_fnc_param"]] spawn bis_fnc_exportFunctionsToWiki;
*/

diag_log "testinit.sqf ausgeführt";