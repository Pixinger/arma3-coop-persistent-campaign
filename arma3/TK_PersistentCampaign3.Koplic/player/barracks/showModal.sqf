private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK";

private["_loadouts"];
_loadouts = [
	["Freizeit (Unbewaffnet)", "Default.sqf"]	,
	["Soldat","Soldier.sqf"],
	["Grenadier","Grenade.sqf"],
	["Sanitäter (Kämpfer)","MedicCombat.sqf"],
	["Sanitäter (Funk)","MedicRadio.sqf"],
	["Truppführer","Teamleader.sqf"],
	["Truppführer (Funk)","TeamleaderRadio.sqf"],
	["Automatikschütze (Mk200)","Belt_AutoriflemanMk200.sqf"],
	["Automatikschütze (Navid 9.3mm) DLC","Belt_AutoriflemanNavid.sqf"],
	["Gruppenscharfschütze","GroupSniperMk18.sqf"],
	["Gruppenscharfschütze (MK14) DLC","GroupSniperMk14.sqf"],
	["Gruppenscharfschütze (Mk-1) DLC","GroupSniperMk1.sqf"],
	["NLAW (AT)","NLAW.sqf"],
	["Titan (AT)","TitanAT.sqf"],
	["Titan (AA)","TitanAA.sqf"],
	["Sprengstoffexperte","EngineerMine.sqf"],
	["Reparaturexperte","EngineerRepair.sqf"],
	["Aufklärungsexperte","EngineerScout.sqf"],
	["Crew","Crew.sqf"],
	["Helipilot", "HeliPilot.sqf"],
	["Heli Crewchief (Radio)", "HeliCrewchief.sqf"],
	["Jetpilot", "JetPilot.sqf"],
	["Operator HALO", "OperatorHalo.sqf"],
	["Operator HALO (TF) ", "OperatorTfHalo.sqf"],
	["Operator HALO (AT)", "OperatorHaloAT.sqf"],
	["Operator UAV","OperatorUAV.sqf"],
	["Operator Aufklärer","OperatorScout.sqf"],
	["Operator MG (SPMG .338) DLC","OperatorSPMG.sqf"],
	["Operator GS (MAR10 .338) DLC","OperatorMAR10.sqf"],
	["Scharfschütze (M320 LLR)","SniperGM6.sqf"],
	["Scharfschütze (Spotter)","Spotter.sqf"],
	["Scharfschütze (Cyrus) DLC","SniperCyrus.sqf"],
	["Scharfschütze (Spotter) DLC","SpotterDLC.sqf"],
	["Aufklärer (Unbewaffnet)", "UnarmedScout.sqf"],
	["Aufklärer (ohne Hilfsmittel)", "noGpsScout.sqf"]
	//["Automatikschütze","US_Autorifleman.sqf"],
	//["Sanitäter (Aufklärer)","US_MedicRecon.sqf"],
	//["Sanitäter (Funker)","US_MedicRadio.sqf"],
//	["Scharfschütze","US_Sniper.sqf"],
//	["Beobachter","US_Spotter.sqf"],
//	["Unterstüzung (AT)","US_SupportAT.sqf"],
//	["Unterstüzung (MG)","US_SupportMG.sqf"],
//	["UAV","US_UAV.sqf"],
//	["UAV (Raven)","US_UAVRaven.sqf"],
//	["Taucher", "Diver.sqf"],
//	["Pilot", "Pilot.sqf"],
//	["Crew", "Crew.sqf"],
//	["Kommandeur", "Commander.sqf"],
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
if ((pixLogisticDialogBarrack_ButtonOK == 1) && (adminBarracks)) then
{
	private["_scriptFilename"];
	_scriptFilename = (_loadouts select pixLogisticDialogBarrack_Selection) select 1;

	/* LoadOut zuweisen */
	private["_result"];
	_result = [player, _scriptFilename] call compile preprocessFileLineNumbers "player\barracks\applyLoadOut.sqf";
};
pixLogisticDialogBarrack_Selection = nil;