params ["_position", "_radius"];
private _tents = nearestObjects[_position, aizCampFieldClassnames, _radius];
private _result = objNull;
{
	if (damage _x < 0.9) exitWith {_result=_x;};
} foreach _tents;

_result;