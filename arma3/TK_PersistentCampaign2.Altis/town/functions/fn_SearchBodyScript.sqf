private["_units"];
_units = nearestObjects [player, ["SoldierGB","SoldierWB","Civilian_F"], 5];

{
	if (!alive _x) exitWith 
	{ 
		deleteVehicle _x; 
		hint "Sie haben keine Informationen gefunden.";
	};
} foreach _units;