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
call compile preprocessFileLineNumbers "missionsRev\config.sqf";

/*------------------------*/
/* Funktionen compilieren */
/*------------------------*/
fn_missionsRev_CreateArmored = compile preprocessFileLineNumbers "missionsRev\fn_missionsRev_CreateArmored.sqf";
fn_missionsRev_CreateArmoredAA = compile preprocessFileLineNumbers "missionsRev\fn_missionsRev_CreateArmoredAA.sqf";
fn_missionsRev_CreateInf = compile preprocessFileLineNumbers "missionsRev\fn_missionsRev_CreateInf.sqf";
fn_missionsRev_CreateInfMech = compile preprocessFileLineNumbers "missionsRev\fn_missionsRev_CreateInfMech.sqf";
fn_missionsRev_CreateMRAP = compile preprocessFileLineNumbers "missionsRev\fn_missionsRev_CreateMRAP.sqf";
fn_missionsRev_TrackGroup = compile preprocessFileLineNumbers "missionsRev\fn_missionsRev_TrackGroup.sqf";
