#define CLASSNAMES	["Land_Laptop_unfolded_F"]
params ["_position", "_radius"];
private _tents = nearestObjects[_position, CLASSNAMES, _radius];
private _result = objNull;
{
	if (damage _x < 0.9) exitWith {_result=_x;};
} foreach _tents;

_result;