if (call fnc_Logistic_CanTakePrison) then 
{
	if (alive cursorTarget) then
	{
		hint localize "str_pc3_UnitTakenToInterrogation";
		
		private _classname = typeof cursorTarget;

		//-----------------------------------------------------------------	
		// Füllstand der Kiste zurückschreiben
		private _boxes = nearestObjects [(getPos cursorTarget), cfgLogisticGear_MenuObjectClassnames, 100];
		if (count _boxes > 0) then
		{
			private _mass = [cursorTarget] call fnc_logisticGear_GetCfgMassPlayer;		
			diag_log format["mass of prision unit=%1", _mass];			

			private _dbVar = (_boxes select 0) getVariable["dbVar", []];
			_contentCount = if (count _dbVar > 0) then { _dbVar select 0; } else { 10000 };
			_contentCount = _contentCount + _mass;
			_dbVar set [0, _contentCount];
			(_boxes select 0) setVariable["dbVar", _dbVar, true];
		};
		
		//-----------------------------------------------------------------	
		// Einheit löschen
		deleteVehicle cursorTarget;
		
		//-----------------------------------------------------------------	
		// Intel aktualisieren
		private _chance = if (_classname isKindOf cfgLogisticTakePrisonOfficerClassname) then { 2 } else { 5 };		
		if ([1, _chance] call BIS_fnc_randomInt <= 1) then
		{	
			[[1, cfgAizZoneCount] call BIS_fnc_randomInt] call fnc_aiz_IntelIncrement;
		};
	}
	else
	{
		hint localize "str_pc3_UnitAlreadyDied";
	};	
};