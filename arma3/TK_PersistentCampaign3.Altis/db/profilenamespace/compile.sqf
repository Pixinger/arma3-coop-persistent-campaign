if (isServer) then  {
	fnc_db_CreateVehicleCorrected = compile preprocessFileLineNumbers "db\profilenamespace\functions\fnc_db_CreateVehicleCorrected.sqf";
	fnc_db_LoadFromDb = compile preprocessFileLineNumbers "db\profilenamespace\functions\fnc_db_LoadFromDb.sqf";
	fnc_db_SaveToDb = compile preprocessFileLineNumbers "db\profilenamespace\functions\fnc_db_SaveToDb.sqf";
	fnc_db_SetVehicleDamageArray = compile preprocessFileLineNumbers "db\profilenamespace\functions\fnc_db_SetVehicleDamageArray.sqf";
	fnc_db_GetVehicleDamageArray = compile preprocessFileLineNumbers "db\profilenamespace\functions\fnc_db_GetVehicleDamageArray.sqf";
	fnc_db_SetVehicleCargoArray = compile preprocessFileLineNumbers "db\profilenamespace\functions\fnc_db_SetVehicleCargoArray.sqf";
	fnc_db_GetVehicleCargoArray = compile preprocessFileLineNumbers "db\profilenamespace\functions\fnc_db_GetVehicleCargoArray.sqf";
	diag_log "db(profilenamespace) compiled";
};