setviewdistance 4000;
setObjectViewDistance 4000;
/*setTerrainGrid 3.125;*/

waituntil {!isnil "bis_fnc_init"};
if (!isServer) then { waitUntil {!isNull player};};
enableSaving [false, false];


pixDebug = true;
/* Parameter auswerten */
if (paramsArray select 0 == 0) then { pixDebug = false; } else { pixDebug = false; };
if (paramsArray select 1 == 0) then { pixPatrolSkriptType = "UPS"; } else { pixPatrolSkriptType = "USPS"; };
if (paramsArray select 2 == 0) then { pixRadioType = "TFR"; } else { pixRadioType = "ACRE"; };
if (isServer && !isDedicated) then { pixDebug = true; };

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
