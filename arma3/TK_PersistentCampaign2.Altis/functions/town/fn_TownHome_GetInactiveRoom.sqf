/*
Sucht innerhalb des Home-Arrays nach einem inaktiven "Room" der als Spawn für eine KI-Einheit verwendet werden kann.
Dabei wird berücksichtigt, ob Spieler in der Nähe sind, oder nicht.
 
Parameter:
	_homes: Das zu belegende Home-Array.
	_classnames: Eine Liste mit den Classnames, die vorgeben von welchen Typ der "Room" bewohnt wird.
	             Wenn _classnames=[] ist, dann wird nur geprüft, ob der "Room" inaktiv ist.

Return: 
	[]: wenn kein verfügbarer "Room" gefunden werden konnte, sonst der zu verwendende "Room".
	
*/

private["_homes"];
_homes = _this select 0;
private["_classnames"];
_classnames = _this select 1;

private["_resultRoom"];
private["_inactiveRooms"];
_inactiveRooms = [_homes, _classnames] call PC_fnc_TownHome_GetInactiveRooms;
if (count _inactiveRooms > 0) then
{
	_resultRoom = [_inactiveRooms] call PC_fnc_RandomElement;	
} 
else
{
	_resultRoom = [];
};

_resultRoom;