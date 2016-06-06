private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

//-----------------------------------------------------------------	
/* Dialog erstellen*/
#include "..\defines.hpp";
createDialog "LOGISTICGEAR_DIALOG";

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

//-----------------------------------------------------------------	
/* Listbox füllen*/
{
	lbAdd [LOGISTICGEAR_IDC_DIALOG_List, (_x select 0)];
} foreach _loadouts;
lbSetCurSel [LOGISTICGEAR_IDC_DIALOG_List, 0];

//-----------------------------------------------------------------	
// Füllstand der Kiste anzeigen
private _dbVar = _cursorTarget getVariable["dbVar", []];
private _contentCount = if (count _dbVar > 0) then { _dbVar select 0; } else { 10000 };
hint format ["Füllstand der Kiste\n%1%2", floor ((100 / 10000) * _contentCount),"%"];

//-----------------------------------------------------------------	
/* Dialog anzeigen*/
logisticGearDialog_ButtonResult = 0;
logisticGearDialog_Selection = -1;
waitUntil { !dialog };

//-----------------------------------------------------------------	
// Wenn OK geklickt wurde, die Eingaben verarbeiten
if (logisticGearDialog_ButtonResult == 1)  then
{
	private["_scriptFilename"];
	_scriptFilename = (_loadouts select logisticGearDialog_Selection) select 1;

	//-----------------------------------------------------------------	
	// Füllstand der Kiste aktualisieren
	_dbVar = _cursorTarget getVariable["dbVar", []];
	_contentCount = if (count _dbVar > 0) then { _dbVar select 0; } else { 10000 };

	// Masse der Ausrüstung errechnen
	private _mass = [_scriptFilename] call fnc_logisticGear_CalculateLoadOut;
	// LoadOut zuweisen 
	private _result = [player, _scriptFilename] call fnc_logisticGear_ApplyLoadOut;

	//-----------------------------------------------------------------	
	// Füllstand der Kiste zurückschreiben
	_contentCount = _contentCount - _mass;
	if (_contentCount <= 0) then 
	{
		deleteVehicle _cursorTarget;
	}
	else
	{
		_dbVar set [0, _contentCount];
		_cursorTarget setVariable["dbVar", _dbVar, true];
	};	
};

//-----------------------------------------------------------------	
// Global-Variablenwieder freigeben
logisticGearDialog_Selection = nil;
logisticGearDialog_ButtonResult = nil;