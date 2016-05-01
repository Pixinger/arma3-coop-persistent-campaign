if (isServer) then
{
	fnc_aiz_OnTriggerActivated = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_OnTriggerActivated.sqf";
	fnc_aiz_OnTriggerDeactivated = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_OnTriggerDeactivated.sqf";
};

diag_log "aiz compiled";