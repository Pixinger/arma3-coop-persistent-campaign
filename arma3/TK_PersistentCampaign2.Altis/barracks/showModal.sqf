private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK"; 	

private["_loadouts"];
_loadouts = [
	["Freizeit", "AAF_Default.sqf"]	,
	["Soldat","AAF_Soldier.sqf"],
	["Grenadier","AAF_Grenade.sqf"],
	["Automatikschütze (Mk200)","AAF_Belt_AutoriflemanMk200.sqf"],
	["Automatikschütze (Navid 9.3mm) DLC","AAF_Belt_AutoriflemanNavid.sqf"],
	["Automatikschütze (SPMG .338) DLC","AAF_Belt_AutoriflemanSPMG.sqf"],
	["Gruppenscharfschütze (Rahim)","AAF_GroupSniperRahim.sqf"],
	["Gruppenscharfschütze (Mk-1) DLC","AAF_GroupSniperMk1.sqf"],
	["NLAW (AT)","AAF_NLAW.sqf"],
	["Titan (AT)","AAF_TitanAT.sqf"],
	["Titan (AA)","AAF_TitanAA.sqf"],
	["Sanitäter (Kämpfer)","AAF_MedicCombat.sqf"],
	["Sanitäter (Funk)","AAF_MedicRadio.sqf"],
	["Sprengstoffexperte","AAF_EngineerMine.sqf"],
	["Reparaturexperte","AAF_EngineerRepair.sqf"],
	["UAV","AAF_UAV.sqf"],
	["Aufklärer","AAF_Scout.sqf"],
	["Scharfschütze (GM6-Lynx)","AAF_SniperGM6.sqf"],
	["Scharfschütze (MAR-10) DLC","AAF_SniperMAR10.sqf"],
	["Gruppenführer","AAF_Teamleader.sqf"],
	["Gruppenführer (Funk)","AAF_TeamleaderRadio.sqf"],
	["Crew","AAF_Crew.sqf"],
	["Helipilot", "AAF_HeliPilot.sqf"],
	["Helipilot (Radio)", "AAF_HeliPilotRadio.sqf"]
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
if (pixLogisticDialogBarrack_ButtonOK == 1) then
{		
	private["_scriptFilename"];
	_scriptFilename = (_loadouts select pixLogisticDialogBarrack_Selection) select 1;

	/* LoadOut zuweisen */
	private["_result"];
	_result = [player, _scriptFilename] call compile preprocessFileLineNumbers "barracks\applyLoadOut.sqf";
};
pixLogisticDialogBarrack_Selection = nil;