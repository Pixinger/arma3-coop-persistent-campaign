/*
Diese Funktion wird regelmäßig aufgerufen, um den aktuellen Zustand einer Stadt 
für die Öffentlichkeit zwischen zu speichern.
 
Parameter:
	_townName = _this select 0;
	_townCivCount = _this select 1;
	_townRedCount = _this select 2;
	_townInjuredCount = _this select 3;
	_townMood = _this select 4;
	_townStockFood = _this select 5;
	_townStockWater = _this select 6;
	_townMaxPopulation = _this select 7;

Return: 
	nix
*/

private["_townName"];
_townName = _this select 0;

private["_varname"];
_varname = format["T1_%1", _townName];
missionNamespace setVariable [_varname, _this];
//diag_log format["fn_TownHome_StatusUpdate: _this:%1, _varname:%2", _this, _varname];

true;