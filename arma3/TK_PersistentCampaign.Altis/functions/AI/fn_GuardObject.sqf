/* 
	Diese Funktion stellt sicher, dass eine Gruppe eine bestimmte Position verteidigt.
	
Parameter:
	group: Die Gruppe welche die Position verteidigen soll.
	guardPosition: Die Position die verteidigt werden soll.
	
Return: 
	Wenn erfolgreich true, sonst false.

/*-------------------------------------------------------------------*/

if (!isServer) exitWith { false };

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
if (isNull _group) exitwith {["Empty group parameter"] call BIS_fnc_error; false };

private["_guardPosition"];
_guardPosition = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_guardPosition)=="[0,0,0]") exitwith {["Invalid guardPosition parameter"] call BIS_fnc_error; false };

/*-------------------------------------------------------------------*/

private["_result"];
_result = [_group, _guardPosition] call BIS_fnc_taskDefend;
	
if (!_result) exitwith {["PC_fnc_GuardObject failed."] call BIS_fnc_error; false};
	
_result