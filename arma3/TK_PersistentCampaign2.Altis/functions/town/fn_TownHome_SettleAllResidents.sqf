/*
Diese Funktion belegt die Positionen in einem Home-Array mit den entsprechenden Bewohnern.
 
Parameter:
	_homes: Das zu belegende Home-Array.
	_maxResidents: Die Maximale Anzahl der Bewohner.
	
	_totalEnemies: Die gesamt Anzahl der Enemies.
	_totalCivilians: Die gesamt Anzahl der Zivilisten.

Return: 
	[_setteledEnemies, _setteledCivilians]	
*/

diag_log "Settling residents";
private["_homes"];
_homes = _this select 0;
private["_totalEnemies"];
_totalEnemies = _this select 1;
private["_totalCivilians"];
_totalCivilians = _this select 2;

private["_maxResidents"];
_maxResidents = [_homes] call PC_fnc_TownHome_MaxResidents;

private["_setteledEnemies"];
_setteledEnemies = 0;
for "_x" from 1 to _totalEnemies do
{
	private["_room"];
	_room = [_homes] call PC_fnc_TownHome_GetUnoccupiedRoom;
	if (count _room == 0) exitWith {};
	
	_setteledEnemies = _setteledEnemies + 1;
	_room set [1, [pixTown_EnemyClassnames] call PC_fnc_RandomElement];
	diag_log format["room-enemy: %1", _room];
};

private["_setteledCivilians"];
_setteledCivilians = 0;
for "_x" from 1 to _totalCivilians do
{
	private["_room"];
	_room = [_homes] call PC_fnc_TownHome_GetUnoccupiedRoom;
	if (count _room == 0) exitWith {};
	_setteledCivilians = _setteledCivilians + 1;
	_room set [1, [pixTown_CivilianClassnames] call PC_fnc_RandomElement];
	diag_log format["room-civilian: %1", _room];
};

diag_log "Settled residents";

[_setteledEnemies, _setteledCivilians];