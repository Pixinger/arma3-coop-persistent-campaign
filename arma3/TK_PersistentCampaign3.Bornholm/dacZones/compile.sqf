fnc_dacZones_Activate = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_Activate.sqf";
fnc_dacZones_Deactivate = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_Deactivate.sqf";

if (isServer) then
{
	fnc_dacZones_GetCampData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetCampData.sqf";
	fnc_dacZones_GetCampData_Respawns = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetCampData_Respawns.sqf";
	fnc_dacZones_GetZoneData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_GetZoneData.sqf";
	fnc_dacZones_SetCampData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_SetCampData.sqf";
	fnc_dacZones_SetZoneData = compile preprocessFileLineNumbers "dacZones\functions\fnc_dacZones_SetZoneData.sqf";
};

diag_log "dacZones compiled";