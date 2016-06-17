if (call fnc_Logistic_CanTakePrison) then 
{
	hint "Einheit zum Verhör gebracht.";
	deleteVehicle cursorTarget;
	
	if ([1, 5] call BIS_fnc_randomInt <= 1) then
	{	
		[[1, cfgAizZoneCount] call BIS_fnc_randomInt] call fnc_aiz_IntelIncrement;
	};
};