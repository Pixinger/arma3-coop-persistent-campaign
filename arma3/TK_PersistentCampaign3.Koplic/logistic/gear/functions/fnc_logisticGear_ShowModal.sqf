private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

//-----------------------------------------------------------------	
/* Dialog erstellen*/
#include "..\defines.hpp";
createDialog "LOGISTICGEAR_DIALOG";

private["_loadouts"];
_loadouts = [] call compile preprocessFileLineNumbers format["logistic\gear\%1\_getArray.sqf", cfgLogisticGear_LoadoutFolder];

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