/*
Diese Funktion sucht ein bestimmtes Haus innerhalb des Home-Array.
 
Parameter:
	_homes: Das zu durchsuchende Home-Array.
	_house: Das zu suchende Haus.

Return: 
	_house: Das Haus-Array, oder [] wenn keines gefunden wurde.
----------------
_homes = [  [building-obj, [_room, _room, ...]],     [building-obj, [_room, _room, ...]],    ...   ]
_room (frei)       = [[x,y,z]]
_room (deaktviert) = [[x,y,z], classname]
_room (aktviert)   = [[x,y,z], classname, unit-obj]
*/

private["_homes"];
_homes = [_this, 0, [], [[]]] call BIS_fnc_param;
private["_house"];
_house = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

private["_result"];
_result = [];


{
	if ((_x select 0) == _house) exitWith { _result = _x; };
} foreach _homes;

_result; 