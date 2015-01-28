private["_result"];
_result = false;

private["_units"];
_units = (position player) nearObjects [pixTown_ConfigBaseClassCiv, 2];

{	
	if ((alive _x) && {(_x getVariable ["TI", 0] > 0)}) exitWith {_result = true;};
} foreach _units;

_result;