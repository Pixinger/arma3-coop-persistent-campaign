private ["_cursorTarget"];
_cursorTarget = _this select 0;
if !(isNull _cursorTarget) then
{
	/* -----------------------------------------------------------------	*/
	/* Dialog erstellen*/
	createDialog "PIXLOGISTIC_DIALOG_FOLDEDBUILDING"; 			
			
	#include "defines.hpp";
	ctrlSetText [PIXLOGISTIC_IDC_DIALOG_FOLDEDBUILDING_Text, str(gettext (configFile >> "CfgVehicles" >> ((_cursorTarget getVariable "pixLogisticContent") select 0) >> "displayName"))];
	
	/*-----------------------------------------------------------------	*/
	/* Dialog anzeigen*/
	waitUntil { !dialog };
};