params ["_position", "_radius"];
private _laptops = nearestObjects[_position, aizCampTownClassnames, _radius];
private _result = objNull;
{
	if (damage _x < 0.9) exitWith {_result=_x;};
} foreach _laptops;

_result;