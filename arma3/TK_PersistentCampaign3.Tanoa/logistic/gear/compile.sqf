diag_log "INFO: compile: logistic/gear";

if (hasInterface) then
{
	fnc_logisticGear_GetCfgMass = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_GetCfgMass.sqf";
	//fnc_logisticGear_CalculateLoadOutFile = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_CalculateLoadOutFile.sqf";
	fnc_logisticGear_GetCfgMassPlayer = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_GetCfgMassPlayer.sqf";
	fnc_logisticGear_ApplyLoadOut = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_ApplyLoadOut.sqf";
	fnc_logisticGear_ApplyDefaultLoadOut = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_ApplyDefaultLoadOut.sqf";	
	fnc_logisticGear_ShowModal = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_ShowModal.sqf";
};