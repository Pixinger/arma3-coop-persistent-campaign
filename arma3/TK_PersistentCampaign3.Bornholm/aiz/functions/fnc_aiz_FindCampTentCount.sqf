params ["_position", "_radius"];
private _tents = nearestObjects[_position, aizCampFieldClassnames, _radius];
private _result = 0;
{
	if (damage _x < 0.9) then {_result=_result+1;};
} foreach _tents;

_result;