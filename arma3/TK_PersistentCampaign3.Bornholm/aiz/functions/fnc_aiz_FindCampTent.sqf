#define TENT_CLASSNAMES	["Land_TentDome_F", "Land_TentA_F"]
params ["_position", "_radius"];
private _tents = nearestObjects[_position, TENT_CLASSNAMES, _radius];
private _result = objNull;
{
	if (damage _x < 0.9) exitWith {_result=_x;};
} foreach _tents;

_result;