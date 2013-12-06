/* 
	Diese Funktion stellt sicher, dass eine Gruppe eine bestimmte Position verteidigt.
	
Parameter:
	group: Die Gruppe welche die Position verteidigen soll.
	guardPosition: Die Position die verteidigt werden soll.
	
Return: 
	nix

/*-------------------------------------------------------------------*/

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;

private["_guardPosition"];
_guardPosition = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
[_group] call PC_fnc_SetSkill;

/*-------------------------------------------------------------------*/

if (!isNull _group) then 
{	
	if (str(_guardPosition) != "[0,0,0]") then 
	{
		[_group, _guardPosition] call BIS_fnc_taskDefend;
		[_group] call PC_fnc_SetSkill;
	}
	else
	{
		["Invalid Guardposition: %1", _guardPosition] call BIS_fnc_error; 
	};
}
else
{
	if (isNull _group) then { ["No group parameter: %1", _group] call BIS_fnc_error; };
};