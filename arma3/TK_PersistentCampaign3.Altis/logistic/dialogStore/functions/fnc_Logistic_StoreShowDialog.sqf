//logisticStores = [
//	[[8304.81,10055.3,0.00144196], "MyStore", []],
//	[[100,100,0], "Name", ["Land_PaperBox_closed_F","Land_CratesWooden_F"]]
//];

// Den nächsten Store suchen => "_store"
private["_store"];
_store = logisticStores select 0;
{
	if (_x select 0 distance position player < _store select 0 distance position player) then { _store = _x; };
} foreach logisticStores;


private["_wareList"];
_wareList = logisticStoreObjects; // _wareList = [["Land_CratesWooden_F", 40],["Land_PaperBox_closed_F", 40]];

/* -----------------------------------------------------------------	*/
/* Dialog erstellen*/
#include "..\defines.hpp";
createDialog "LOGISTIC_DIALOG_STORE"; 	
ctrlSetText [LOGISTIC_IDC_DIALOG_STORE_Title, "Store"];
ctrlSetText [LOGISTIC_IDC_DIALOG_STORE_SubTitle, _store select 1];

/*-----------------------------------------------------------------		*/
/* Listbox füllen*/
{
	private["_ware"];
	_ware = _wareList select _foreachIndex;
	lbAdd [LOGISTIC_IDC_DIALOG_STORE_List, format["%1m³: %2", _ware select 1, gettext (configFile >> "CfgVehicles" >> _ware select 0 >> "displayName")]];
	//lbSetPicture [LOGISTIC_IDC_DIALOG_STORE_List, _foreachIndex, gettext (configFile >> "CfgVehicles" >> "Land_Bricks_V1_F" >> "icon")];
} foreach _wareList;

lbSetCurSel [LOGISTIC_IDC_DIALOG_STORE_List, 0];

/*-----------------------------------------------------------------	*/
/* Dialog anzeigen*/
logisticDialogStore_ButtonOK = 0;
logisticDialogStore_Selection = -1;
waitUntil { !dialog };

/*-----------------------------------------------------------------	*/
/* Wenn OK geklickt wurde, die Eingaben verarbeiten*/
if (logisticDialogStore_ButtonOK == 1) then
{		
	private["_ware"];
	_ware = _wareList select logisticDialogStore_Selection;	
	private["_classname"];
	_classname = _ware select 0;
	private["_size"];
	_size = _ware select 1;	
		
	/* Fahrzeug erstellen */
	private["_object"];
	_object = _classname createVehicle (getPos Player);
	waitUntil {!isNil "_object"};
	_object allowDamage false;
};