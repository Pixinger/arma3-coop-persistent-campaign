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


// [name, civ, red, injured, mood, food, water]
private["_varname"];
_varname = format["T1_%1", _townName];
private["_status"];
_status = missionNamespace getVariable [_varname, ["unknown", 0,0,0,0,0,0,0]];
//diag_log format["fn_TpwnHome_StatusRequest: _varname: %1 / _status: %2", _varname, _status];

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