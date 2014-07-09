private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK"; 	

private["_loadouts"];
_loadouts = [
	/*UK*/
	["UK Gruppenführer","TeamleaderUK.sqf"],
	["US Gruppenführer","TeamleaderUS.sqf"],
	["UK Gruppenführer (Funk)","RadioTeamleaderUK.sqf"],
	["US Gruppenführer (Funk)","RadioTeamleaderUS.sqf"],
	["UK Automatikschütze","AutoriflemanUK.sqf"],
	["US Automatikschütze","AutoriflemanUS.sqf"],
	["UK Automatikschütze(Gurt)","BeltAutoriflemanUK.sqf"],
	["US Automatikschütze(Gurt)","BeltAutoriflemanUS.sqf"],
	["UK Sanitäter","MedicUK.sqf"],
	["US Sanitäter","MedicUS.sqf"],
	["UK Sanitäter (Funk)","RadioMedicUK.sqf"],
	["US Sanitäter (Funk)","RadioMedicUS.sqf"],
	["UK Grenadier","GrenadeUK.sqf"],
	["US Grenadier","GrenadeUS.sqf"],
	["UK NLAW","PCMLUK.sqf"],
	["US NLAW","PCMLUS.sqf"],
	["UK Titan AT","TitanUK.sqf"],
	["US Titan AT","TitanUS.sqf"],
	["UK Titan AA","AATitanUK.sqf"],
	["US Titan AA","AATitanUS.sqf"],
	["UK UAV","UAVUK.sqf"],
	["US UAV","UAVUS.sqf"],
	["Scharfschütze","Sniper.sqf"],
	["Beobachter","Spotter.sqf"],
	["Taucher", "Diver.sqf"],
	["Pilot", "Pilot.sqf"],
	["Helipilot", "HeliPilot.sqf"],
	["Kommandeur", "Commander.sqf"],
	// ["Crew", "Crew.sqf"],
	// ["UK Ingenieur (Repair)","UK_EngineerRepair.sqf"],
	// ["UK Ingenieur (Mine)","UK_EngineerMine.sqf"],
	["Freizeit", "Default.sqf"]	
];

/*-----------------------------------------------------------------		*/
/* Listbox füllen*/
{
	lbAdd [PIXLOGISTIC_IDC_DIALOG_BARRACK_List, (_x select 0)];
} foreach _loadouts;
lbSetCurSel [PIXLOGISTIC_IDC_DIALOG_BARRACK_List, 0];

/*-----------------------------------------------------------------	*/
/* Dialog anzeigen*/
pixLogisticDialogBarrack_ButtonOK = 0;
pixLogisticDialogBarrack_Selection = -1;
waitUntil { !dialog };

/*-----------------------------------------------------------------	*/
/* Wenn OK geklickt wurde, die Eingaben verarbeiten*/
if (pixLogisticDialogBarrack_ButtonOK == 1) then
{		
	private["_scriptFilename"];
	_scriptFilename = (_loadouts select pixLogisticDialogBarrack_Selection) select 1;

	/* LoadOut zuweisen */
	private["_result"];
	_result = [player, _scriptFilename] call compile preprocessFileLineNumbers "barracks\applyLoadOut.sqf";
};
pixLogisticDialogBarrack_Selection = nil;