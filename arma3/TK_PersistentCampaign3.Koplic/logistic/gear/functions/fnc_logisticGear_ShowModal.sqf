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
ctrlSetText [LOGISTICGEAR_IDC_DIALOG_Title, format["Ausrüstung (Füllstand: %1%2)", floor ((100 / 10000) * _contentCount), "%"]];



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
	
	if (_contentCount > 0) then
	{
		// Masse der Ausrüstung errechnen
		private _massPlayerBefore = [player] call fnc_logisticGear_GetCfgMassPlayer;
		// LoadOut zuweisen 
		private _result = [player, _scriptFilename] call fnc_logisticGear_ApplyLoadOut;
		// Masse der Ausrüstung errechnen
		private _massPlayerAfter = [player] call fnc_logisticGear_GetCfgMassPlayer;

		//-----------------------------------------------------------------	
		// Füllstand der Kiste zurückschreiben
		_contentCount = _contentCount + _massPlayerBefore - _massPlayerAfter;
		if (_contentCount <= 0) then 
		{
			_dbVar set [0, 0];
			_cursorTarget setVariable["dbVar", _dbVar, true];
			///deleteVehicle _cursorTarget;
		}
		else
		{
			_dbVar set [0, _contentCount];
			_cursorTarget setVariable["dbVar", _dbVar, true];
		};	
	}
	else
	{
		hint "Die Kiste ist leer!";
	};
};

//-----------------------------------------------------------------	
// Global-Variablenwieder freigeben
logisticGearDialog_Selection = nil;
logisticGearDialog_ButtonResult = nil;