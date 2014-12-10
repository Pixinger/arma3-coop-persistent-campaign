/*
Diese Funktion belegt die Positionen in einem Home-Array mit den entsprechenden Bewohnern.
 
Parameter:
	_homes: Das zu belegende Home-Array.
	_totalRed: Die gesamt Anzahl der Enemies.
	_totalCiv: Die gesamt Anzahl der Zivilisten.

Return: 
	[_setteledRed, _setteledCiv, _maxPopulation]	
*/

diag_log "Settling residents";
private["_homes"];
_homes = _this select 0;
private["_totalRed"];
_totalRed = _this select 1;
private["_totalCiv"];
_totalCiv = _this select 2;

private["_maxPopulation"];
_maxPopulation = [_homes] call PC_fnc_TownHome_MaxPopulation;

private["_setteledRed"];
_setteledRed = 0;
for "_x" from 1 to _totalRed do
{
	private["_room"];
	_room = [_homes] call PC_fnc_TownHome_GetUnoccupiedRoom;
	if (count _room == 0) exitWith {};
	
	_setteledRed = _setteledRed + 1;
	_room set [1, [pixTown_ConfigRedClassnames] call PC_fnc_RandomElement];
	diag_log format["room-red: %1", _room];
};

private["_setteledCiv"];
_setteledCiv = 0;
for "_x" from 1 to _totalCiv do
{
	private["_room"];
	_room = [_homes] call PC_fnc_TownHome_GetUnoccupiedRoom;
	if (count _room == 0) exitWith {};
	_setteledCiv = _setteledCiv + 1;
	_room set [1, [pixTown_ConfigCivClassnames] call PC_fnc_RandomElement];
	diag_log format["room-civ: %1", _room];
};

diag_log "Settled residents";

[_setteledRed, _setteledCiv, _maxPopulation];