/*-----------------------------------------------------------------*/
/* Sicherstellen, dass die "pixZones" bereits initialisiert wurden */
/*-----------------------------------------------------------------*/
if (isNil "pixZones_Initialized") then
{
	player sidechat "ERROR: pixZones wurden noch nicht initialisiert.";
};

missionsOpt_GetUniqueMarkerName_Mutex = false;

/*---------------------*/
/* Konfiguration laden */
/*---------------------*/
call compile preprocessFileLineNumbers "missionsOpt\config.sqf";

fn_missionsOpt_Patrol = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_Patrol.sqf";
fn_missionsOpt_SetSkill = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_SetSkill.sqf";
fn_missionsOpt_GetObfuscatedMarker = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_GetObfuscatedMarker.sqf";
fn_missionsOpt_GetUniqueMarkerName = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_GetUniqueMarkerName.sqf";