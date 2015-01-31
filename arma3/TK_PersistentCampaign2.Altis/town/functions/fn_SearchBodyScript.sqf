private["_units"];
_units = nearestObjects [player, [pixTown_ConfigBaseClassRed,pixTown_ConfigBaseClassBlu,pixTown_ConfigBaseClassCiv], 5];

{
	if (!alive _x) exitWith 
	{ 
		deleteVehicle _x; 

		if (random 1 < 0.25) then
		{
			townInfos = townInfos + 1;
			publicVariable "townInfos";
			
			hint format [ "Informationen wurden gesichert und an das HQ gesendet (%1).", townInfos ];
		}
		else
		{
			hint "Sie haben keine Informationen gefunden.";
		};
	};
} foreach _units;