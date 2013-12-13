private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK"; 	

private["_loadouts"];
_loadouts = [
	/*UK*/
	["UK Gruppenführer","UK_Teamleader.sqf"],
	["UK Grenadier","UK_Grenade.sqf"],
	["UK Automatikschütze","UK_Autorifleman.sqf"],
	["UK Automatikschütze(Gurt)","UK_Belt_Autorifleman.sqf"],
	["UK Ingenieur","UK_Engineer.sqf"],
	["UK Sanitäter","UK_Medic.sqf"],
	["UK PCML","UK_PCML.sqf"],
	["UK Scharfschütze","UK_Sniper.sqf"],
	["UK Beobachter","UK_Spotter.sqf"],
	["UK Unterstüzung","UK_Support.sqf"],
	["UK Titan AT","UK_Titan.sqf"],
	["UK Titan AA","UK_TitanAA.sqf"],
	/*US*/
	["US Gruppenführer","US_Teamleader.sqf"],
	["US Grenadier","US_Grenade.sqf"],
	["US Automatikschütze","US_Autorifleman.sqf"],
	["US Automatikschütze(Gurt)","US_Belt_Autorifleman.sqf"],
	["US Ingenieur","US_Engineer.sqf"],
	["US Sanitäter","US_Medic.sqf"],
	["US PCML","US_PCML.sqf"],
	["US Scharfschütze","US_Sniper.sqf"],
	["US Beobachter","US_Spotter.sqf"],
	["US Unterstüzung","US_Support.sqf"],
	["US Titan AT","US_Titan.sqf"],
	["US Titan AA","US_TitanAA.sqf"],
	["Taucher", "Diver.sqf"],
	["Helipilot", "HeliPilot.sqf"],
	["Pilot", "Pilot.sqf"],
	["Kommandeur", "Commander.sqf"],
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
	_result = [player, _scriptFilename] call compile preprocessFileLineNumbers "pixLogistic\dialogBarracks\applyLoadOut.sqf";
};
pixLogisticDialogBarrack_Selection = nil;