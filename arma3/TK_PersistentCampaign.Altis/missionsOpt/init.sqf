/*-----------------------------------------------------------------*/
/* Sicherstellen, dass die "pixZones" bereits initialisiert wurden */
/*-----------------------------------------------------------------*/
if (isNil "pixZones_Initialized") then
{
	player globalChat "ERROR: pixZones wurden noch nicht initialisiert.";
};



/*---------------------*/
/* Konfiguration laden */
/*---------------------*/
call compile preprocessFileLineNumbers "missionsOpt\config.sqf";

fn_missionsOpt_Patrol = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_Patrol.sqf";
fn_missionsOpt_SetSkill = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_SetSkill.sqf";
fn_missionsOpt_RandomPositionRoad = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_RandomPositionRoad.sqf";
fn_missionsOpt_RandomPositionMarker = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_RandomPositionMarker.sqf";
fn_missionsOpt_RandomPositionHouse = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_RandomPositionHouse.sqf";
fn_missionsOpt_RandomPositionField = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_RandomPositionField.sqf";
fn_missionsOpt_GetMinDistance = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_GetMinDistance.sqf";
fn_missionsOpt_GetObfuscatedMarker = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_GetObfuscatedMarker.sqf";
fn_missionsOpt_GetUniqueMarkerName = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_GetUniqueMarkerName.sqf";missionsOpt_GetUniqueMarkerName_Mutex = false;