setviewdistance 1000;
setObjectViewDistance 1000;
setTerrainGrid 50;

waituntil {!isnil "bis_fnc_init"};
if (hasInterface) then { waitUntil {!isNull player};};
enableSaving [false, false];

/*-----------------------------------------------*/
/* Parameter (0): Debug */
pixDebug = false;
if (isServer && !isDedicated) then { pixDebug = true; };
/* Parameter (0): TFR-Muted while dead */
pixParamTFARMutedOnDeath = (paramsArray select 0); //0=aus 1=an 
diag_log format["INFO: pixParamTFARMutedOnDeath: %1", pixParamTFARMutedOnDeath];
/* Parameter (1): TFR-Terrain Coefficient */
pixParamTFARTerrainInterceptionCoefficient = (paramsArray select 1); //0,0.5,1,2,3,4,5,6,7,8,9,10
diag_log format["INFO: pixParamTFARTerrainInterceptionCoefficient: %1", pixParamTFARTerrainInterceptionCoefficient];
TF_terrain_interception_coefficient = pixParamTFARTerrainInterceptionCoefficient;

/* Warten bis das Briefing beendet wurde */
/* Erst dann sind die PublicVariablen auch initialisiert. */
Sleep .1;

/* Prüfen ob ein HeadlessClient erkannt wurde */
if (isNil "HeadlessClientAvailable") then 
{	
	HeadlessClientAvailable = false;
	diag_log "No headless-client detected";
} else {
	diag_log "Headless-client detected";
	HeadlessClientAvailable = true;
};

// Lokal für jeden Rechner prüfen, ob hier (auf dieser Maschine) Headless Code ausgeführt werden soll, oder nicht.
ExecuteHeadlessCode = false;
if ((HeadlessClientAvailable && !hasInterface && !isServer) || (!HeadlessClientAvailable && isServer)) then {	ExecuteHeadlessCode = true; };
diag_log format["ExecuteHeadlessCode: %1", ExecuteHeadlessCode];

/*-----------------------------------------------*/
cutText ["Initialization...\n[TK]Persistenct Campaign 2", "BLACK FADED",1];

if (ExecuteHeadlessCode) then
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
} else {
	diag_log "PC reloadall not needed on this process.";
};

call compile preprocessFileLineNumbers "maindialog_init.sqf";
call compile preprocessFileLineNumbers "admin\init.sqf";
call compile preprocessFileLineNumbers "town\init.sqf";
call compile preprocessFileLineNumbers "mainmenu\init.sqf";
call compile preprocessFileLineNumbers "vehicles\init.sqf";

player setvariable ["BIS_nocoreconversations",true];

/* Module initialisieren */

/* Camera deaktivieren */
cutText ["", "BLACK IN",1];