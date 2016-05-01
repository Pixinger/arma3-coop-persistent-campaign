fnc_dacZones_OnTriggerActivated = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_OnTriggerActivated.sqf";
fnc_dacZones_OnTriggerDeactivated = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_OnTriggerDeactivated.sqf";

if (isServer) then
{


	fnc_dacZones_MessageQueuePop = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_MessageQueuePop.sqf";
	fnc_dacZones_MessageQueuePush = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_MessageQueuePush.sqf";
	fnc_dacZones_GetZoneIdFromXy = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetZoneIdFromXy.sqf";
	fnc_dacZones_GetZoneXyFromId = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetZoneXyFromId.sqf";
	
	fnc_dacZones_ZoneActivate = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_ZoneActivate.sqf";
	fnc_dacZones_ZoneDeactivate = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_ZoneDeactivate.sqf";

	fnc_dacZones_GetCampData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetCampData.sqf";
	fnc_dacZones_GetCampData_Respawns = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetCampData_Respawns.sqf";
	fnc_dacZones_GetZoneData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetZoneData.sqf";
	fnc_dacZones_SetCampData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_SetCampData.sqf";
	fnc_dacZones_SetZoneData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_SetZoneData.sqf";
};

diag_log "dacZones compiled";