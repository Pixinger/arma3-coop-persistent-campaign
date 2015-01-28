private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK"; 	

private["_loadouts"];
_loadouts = [
	/*UK*/
	/*["UK Gruppenführer","UK_Teamleader.sqf"],
	["UK Gruppenführer (Funk)","UK_TeamleaderRadio.sqf"],
	["UK Grenadier","UK_Grenade.sqf"],
	["UK Automatikschütze","UK_Autorifleman.sqf"],
	["UK Automatikschütze(Gurt)","UK_Belt_Autorifleman.sqf"],
	["UK Ingenieur (Repair)","UK_EngineerRepair.sqf"],
	["UK Ingenieur (Mine)","UK_EngineerMine.sqf"],
	["UK Sanitäter","UK_Medic.sqf"],
	["UK Sanitäter (Funk)","UK_MedicRadio.sqf"],
	["UK PCML","UK_PCML.sqf"],
	["UK Scharfschütze","UK_Sniper.sqf"],
	["UK Beobachter","UK_Spotter.sqf"],
	["UK Unterstüzung","UK_Support.sqf"],
	["UK Titan AT","UK_Titan.sqf"],
	["UK Titan AA","UK_TitanAA.sqf"],
	["UK UAV","UK_UAV.sqf"],*/
	/*US*/
	["Gruppenführer","US_Teamleader.sqf"],
	["Gruppenführer (Funk)","US_TeamleaderRadio.sqf"],
	["Grenadier","US_Grenade.sqf"],
	["Automatikschütze","US_Autorifleman.sqf"],
	["Automatikschütze(Gurt)","US_Belt_Autorifleman.sqf"],
	["Ingenieur (Reparatur)","US_EngineerRepair.sqf"],
	["Ingenieur (Sprengstoff)","US_EngineerMine.sqf"],
	["Sanitäter (Kämpfer)","US_MedicCombat.sqf"],
	["Sanitäter (Aufklärer)","US_MedicRecon.sqf"],
	["Sanitäter (Funker)","US_MedicRadio.sqf"],
	["NLAW (AT)","US_NLAW.sqf"],
//	["Scharfschütze","US_Sniper.sqf"],
//	["Beobachter","US_Spotter.sqf"],
//	["Unterstüzung (AT)","US_SupportAT.sqf"],
//	["Unterstüzung (MG)","US_SupportMG.sqf"],
	["Titan (AT)","US_TitanAT.sqf"],
	["Titan (AA)","US_TitanAA.sqf"],
//	["UAV","US_UAV.sqf"],
//	["UAV (Raven)","US_UAVRaven.sqf"],
//	["Taucher", "Diver.sqf"],
	["Helipilot", "HeliPilot.sqf"],
	["Helipilot (Radio)", "HeliPilotRadio.sqf"],
//	["Pilot", "Pilot.sqf"],
//	["Crew", "Crew.sqf"],
//	["Kommandeur", "Commander.sqf"],
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