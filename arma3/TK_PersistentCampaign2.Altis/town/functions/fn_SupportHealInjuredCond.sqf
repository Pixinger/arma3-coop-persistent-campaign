private["_result"];
_result = false;

private["_units"];
_units = (position player) nearObjects ["Civilian_F", 2];

{	
	if ((alive _x) && {(_x getVariable ["TI", 0] > 0)}) exitWith {_result = true;};
} foreach _units;

_result;