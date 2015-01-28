private["_units"];
_units = nearestObjects [player, [pixTown_ConfigBaseClassRed,pixTown_ConfigBaseClassBlu,pixTown_ConfigBaseClassCiv], 5];

{
	if (!alive _x) exitWith 
	{ 
		deleteVehicle _x; 
		hint "Sie haben keine Informationen gefunden.";
	};
} foreach _units;