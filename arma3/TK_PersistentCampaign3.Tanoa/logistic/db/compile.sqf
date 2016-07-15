diag_log "INFO: compile: logistic/db";

if (isServer) then  
{
	fnc_logisticDb_ClearServer = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_ClearServer.sqf";
	fnc_logisticDb_SaveServer = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_SaveServer.sqf";
	fnc_logisticDb_SaveServer2 = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_SaveServer2.sqf";
	fnc_logisticDb_LoadServer = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_LoadServer.sqf";
	fnc_logisticDb_SetVehicleDamageArray = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_SetVehicleDamageArray.sqf";
	fnc_logisticDb_GetVehicleDamageArray = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_GetVehicleDamageArray.sqf";
	fnc_logisticDb_SetVehicleCargoArray = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_SetVehicleCargoArray.sqf";
	fnc_logisticDb_GetVehicleCargoArray = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_GetVehicleCargoArray.sqf";
};

fnc_logisticDb_CreateVehicleCorrected = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_CreateVehicleCorrected.sqf";
fnc_logisticDb_SaveClient = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_SaveClient.sqf";
fnc_logisticDb_ClearClient = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_ClearClient.sqf";
fnc_logisticDb_SetDateTime = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_SetDateTime.sqf";
fnc_logisticDb_SupplyDrop = compile preprocessFileLineNumbers "logistic\db\functions\fnc_logisticDb_SupplyDrop.sqf";
