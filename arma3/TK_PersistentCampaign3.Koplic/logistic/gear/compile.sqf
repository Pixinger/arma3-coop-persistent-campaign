diag_log "INFO: compile: logistic/gear";

if (hasInterface) then
{
	fnc_logisticGear_CalculateLoadOut = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_CalculateLoadOut.sqf";
	fnc_logisticGear_ApplyLoadOut = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_ApplyLoadOut.sqf";
	fnc_logisticGear_ApplyDefaultLoadOut = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_ApplyDefaultLoadOut.sqf";	
	fnc_logisticGear_ShowModal = compile preprocessFileLineNumbers "logistic\gear\functions\fnc_logisticGear_ShowModal.sqf";
};