/*-----------------------------------------------------------------*/
/* Sicherstellen, dass die "pixZones" bereits initialisiert wurden */
/*-----------------------------------------------------------------*/
if (isNil "pixZones_Initialized") then
{
	player sidechat "ERROR: pixZones wurden noch nicht initialisiert.";
};

/*---------------------*/
/* Konfiguration laden */
/*---------------------*/
call compile preprocessFileLineNumbers "missionsOpt\config.sqf";

fn_missionsOpt_Patrol = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_Patrol.sqf";
fn_missionsOpt_SetSkill = compile preprocessFileLineNumbers "missionsOpt\fn_missionsOpt_SetSkill.sqf";
