setviewdistance 2500;
setObjectViewDistance 2500;
/*setTerrainGrid 3.125;*/

waituntil {!isnil "bis_fnc_init"};
if (!isServer) then { waitUntil {!isNull player};};
enableSaving [false, false];

/*-----------------------------------------------*/
/* Parameter (0): Debug */
pixDebug = false;
if (isServer && !isDedicated) then { pixDebug = true; };
/* Parameter (0): TFR-Muted while dead */
pixParamTFARMutedOnDeath = (paramsArray select 0); //0=aus 1=an 
diag_log format["INFO: pixParamTFARMutedOnDeath: %1", pixParamTFARMutedOnDeath];
/* Parameter (1): TFR-Terrain Coefficient */
pixParamTFARTerrainInterceptionCoefficient = (paramsArray select 1); //0,1,2,3,4,5,6,7,8,9,10
diag_log format["INFO: pixParamTFARTerrainInterceptionCoefficient: %1", pixParamTFARTerrainInterceptionCoefficient];
TF_terrain_interception_coefficient = pixParamTFARTerrainInterceptionCoefficient;

/*-----------------------------------------------*/
cutText ["Initialization...\n[TK]Persistenct Campaign 2", "BLACK FADED",1];

if (isServer) then
{
	// Datenbank initialisieren
	private["_result"];
	_result = "Arma2NET" callExtension "PC reloadall";
	if (_result != "OK") then
	{
		diag_log format["ERROR: PC reloadall failed: %1", _result];
	}
	else
	{
		diag_log "PC reloadall OK";
	};
};

call compile preprocessFileLineNumbers "maindialog_init.sqf";
call compile preprocessFileLineNumbers "town\init.sqf";
call compile preprocessFileLineNumbers "admin\init.sqf";
call compile preprocessFileLineNumbers "mainmenu\init.sqf";
call compile preprocessFileLineNumbers "vehicles\init.sqf";
//call compile preprocessFileLineNumbers "mainmenu\init.sqf";


/* Warten bis das Briefing beendet wurde */
Sleep .1;

player setvariable ["BIS_nocoreconversations",true];

/* Module initialisieren */

/* Camera deaktivieren */
cutText ["", "BLACK IN",1];