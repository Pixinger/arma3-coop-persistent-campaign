setviewdistance 4000;
setObjectViewDistance 4000;
/*setTerrainGrid 3.125;*/

waituntil {!isnil "bis_fnc_init"};
if (!isServer) then { waitUntil {!isNull player};};
enableSaving [false, false];


pixDebug = true;
/*-----------------------------------------------*/
/* Parameter auswerten */
private["_paramValues"];
if (paramsArray select 0 == 0) then { pixDebug = false; } else { pixDebug = false; }; if (isServer && !isDedicated) then { pixDebug = true; };
if (paramsArray select 1 == 0) then { pixPatrolSkriptType = "UPS"; } else { pixPatrolSkriptType = "USPS"; };
if (paramsArray select 2 == 0) then { pixRadioType = "TFR"; } else { pixRadioType = "ACRE"; };
/* Parameter (3): ReverseAttack */
pixParamReverseAttack = (paramsArray select 3);
diag_log format["pixParamReverseAttack: %1", pixParamReverseAttack];
/* Parameter (4): Date */
_paramValues = [[(floor(random(12))) + 1, (floor(random(28))) + 1], [7,1],[3,1],[10,1],[1,1]]; /* {"Zufall", "Sommer", "Frühling", "Herbst", "Winter"}; */
pixParamDate = _paramValues select (paramsArray select 4);
diag_log format["pixParamDate: %1", pixParamDate];
/* Parameter (5): Daytime */
if ((paramsArray select 5) == 0) then { pixParamTime = (floor(random(23))) + 1; } else { pixParamTime = (paramsArray select 5) - 1; };
diag_log format["pixParamTime: %1", pixParamTime];
/* Parameter (6): Weather */
pixParamWeather = (paramsArray select 6); 
diag_log format["pixParamWeather: %1", pixParamWeather];
/* Parameter (7): Mission Factor */
_paramValues = [0.5,1,1.5,2];
pixParamMissionFactor = _paramValues select (paramsArray select 7);
diag_log format["pixParamMissionFactor: %1", pixParamMissionFactor];

/*-----------------------------------------------*/

/* FAR-revive initialisieren */
if (pixDebug) then { player globalChat "init: FAR_revive";};
call compileFinal preprocessFileLineNumbers "FAR_revive\FAR_revive_init.sqf";

/* Zonen initialisieren */
if (pixDebug) then { player globalChat "init: pixZones";};
call compile preprocessFileLineNumbers "pixZones\init.sqf";

/* Logistic initialisieren */
if (pixDebug) then { player globalChat "init: pixLogistic";};
call compile preprocessFileLineNumbers "pixLogistic\init.sqf";

/* Warten bis das Briefing beendet wurde */
Sleep .1;

/* Camera aktivieren */
private["_camera"];
if (!isServer) then
{
	titleCut ["please wait...","BLACK IN",1];
	_camera = "camera" camcreate [0,0,0];
	_camera cameraeffect ["internal", "back"];
	_camera camPrepareTarget [118000.52,19152.64,-40253.30];
	_camera camPreparePos [26643.26,24618.66,27.71];
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 0;
};
	
if (pixDebug) then { player globalChat "Briefing finished";};
if (pixDebug) then { player globalChat "init: Multiplayer parameter";};
if (pixDebug) then { player globalChat format["- parameter pixDebug: %1", pixDebug]; };
if (pixDebug) then { player globalChat format["- parameter pixPatrolSkriptType: %1", pixPatrolSkriptType];};

/* Warten bis das Briefing beendet wurde */
if (pixDebug) then { player globalChat "BIS_nocoreconversations=true";};
player setvariable ["BIS_nocoreconversations",true];

/* Module initialisieren */
if (pixDebug) then { player globalChat "init: missionsEnv";};
call compile preprocessFileLineNumbers "missionsEnv\init.sqf";
if (pixDebug) then { player globalChat "init: missionsOpt";};
call compile preprocessFileLineNumbers "missionsOpt\init.sqf";
if (pixDebug) then { player globalChat "init: missionsRev";};
call compile preprocessFileLineNumbers "missionsRev\init.sqf";
if (pixDebug) then { player globalChat "init: pixDate";};
call compile preprocessFileLineNumbers "pixDate\init.sqf";
if (pixDebug) then { player globalChat "init: pixWeather";};
call compile preprocessFileLineNumbers "pixWeather\init.sqf";
if (pixDebug) then { player globalChat "init: pixGps";};
[] spawn compile preprocessFileLineNumbers "pixGps\init.sqf";
if (pixDebug) then { player globalChat "init: credits";};
[] spawn compile preprocessFileLineNumbers "credits\init.sqf";

/* ACRE lossscale abschalten */	
if (pixRadioType == "ACRE") then
{
	if (pixDebug) then { player globalChat "init: ACRE";};
	[0] call acre_api_fnc_setLossModelScale; /* Disable loss scale simulation */
};
if (pixRadioType == "TFR") then
{
	tf_no_auto_long_range_radio = true;
	[] spawn {
		waituntil {sleep 0.5; player call haveSwRadio}; 
		[call activeSwRadio, "101.1" ] call setSwFrequency;/*/
	};
};

if (pixDebug) then { player globalChat "init.sqf is done";};
player globalChat format["Your UID: %1", getPlayerUID player];
player globalChat format["Radio: %1", pixRadioType];

/* Camera deaktivieren */
if (!isServer) then
{
	waitUntil {!(isNil "pvPixLogisticServerInitialized")};
	waitUntil { pvPixLogisticServerInitialized };
	player cameraEffect ["terminate","back"];
	camDestroy _camera;
};
