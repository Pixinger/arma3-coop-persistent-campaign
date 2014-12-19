/*
Diese Funktion durchsucht ein bestimmtes Haus in einem Home-Array.
 
Parameter:
	_house: Das zu durchuschende Haus

Return: 
*/

private["_townName"];
_townName = _this select 0;
private["_requestingPlayer"];
_requestingPlayer = _this select 1;


// [name, civ, red, injured, mood, food, water, power]
private["_status"];
_status = missionNamespace getVariable [format["TownStatus%1", _townName], ["unknown", 0,0,0,0,0,0,0]];

// Param
// Code/Function
// Target
//    Object - function will be executed only where unit is local [default: everyone] 
//    Array - array of objects 
//    Boolean - true to execute on each machine (including the one where the function was called from), false to execute it on server only 
//    Number - function will be executed only on client with the given owner ID 
//    Side - function will be executed only on clients where the player is on the specified side 
//    Group - function will be executed only on clients where the player is in the specified group 
// IsPersistent
// IsCall 
[_status, "PC_fnc_TownHome_StatusResponse", _requestingPlayer] call BIS_fnc_MP;

true;