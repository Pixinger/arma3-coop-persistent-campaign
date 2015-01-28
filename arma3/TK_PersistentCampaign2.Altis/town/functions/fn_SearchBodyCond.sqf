private["_result"];
_result = false;

private["_units"];
_units = nearestObjects [player, [pixTown_ConfigBaseClassRed,pixTown_ConfigBaseClassBlu,pixTown_ConfigBaseClassCiv], 5];
player sidechat format["uni: %1", _units];

{
	if (!alive _x) exitWith 
	{ 
		player sidechat "dead";
		_result = true; 
	};
} foreach _units;

_result;