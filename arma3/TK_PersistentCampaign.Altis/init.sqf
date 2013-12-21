setviewdistance 4000;
setObjectViewDistance 4000;
/*setTerrainGrid 3.125;*/

waituntil {!isnil "bis_fnc_init"};
if (!isServer) then { waitUntil {!isNull player};};
enableSaving [false, false];


/*-----------------------------------------------*/
/* Parameter (0): Debug */
pixDebug = true;
private["_paramValues"];
if (paramsArray select 0 == 0) then { pixDebug = false; } else { pixDebug = false; }; if (isServer && !isDedicated) then { pixDebug = true; };
/* Parameter (1): Zone Capture Time */
pixParamzoneCaptureTime = (paramsArray select 1);
diag_log format["INFO: pixParamzoneCaptureTime: %1", pixParamzoneCaptureTime];
/* Parameter (2): Mission Factor */
_paramValues = [0.5,1,1.5,2];
pixParamMissionFactor = _paramValues select (paramsArray select 2);
diag_log format["INFO: pixParamMissionFactor: %1", pixParamMissionFactor];
/* Parameter (3): ZoneAttackType */
pixParamZoneAttackType = _paramValues select (paramsArray select 3); // 0=zufall 1=attack 2=reverseattack
if (isServer && !isDedicated) then {pixParamZoneAttackType = 1;};
diag_log format["INFO: pixParamZoneAttackType: %1", pixParamZoneAttackType];
/* Parameter (4): ReverseAttack */
pixParamReverseAttackDelay = (paramsArray select 4);
if (isServer && !isDedicated) then {pixParamReverseAttackDelay = 1;};
diag_log format["INFO: pixParamReverseAttackDelay: %1", pixParamReverseAttackDelay];
/* Parameter (5): TimeSettings */
pixParamTimeSettings = (paramsArray select 5);
if (isServer && !isDedicated) then {pixParamTimeSettings = 12;};
diag_log format["INFO: pixParamTimeSettings: %1", pixParamTimeSettings];


/*-----------------------------------------------*/
cutText ["Initialization...", "BLACK FADED",1];

call compile preprocessFileLineNumbers "pixZones\init.sqf";
call compile preprocessFileLineNumbers "pixLogistic\init.sqf";
call compile preprocessFileLineNumbers "pixTime\init.sqf";

/* Warten bis das Briefing beendet wurde */
Sleep .1;

/* Warten bis das Briefing beendet wurde */
player setvariable ["BIS_nocoreconversations",true];

/* Module initialisieren */
call compile preprocessFileLineNumbers "pixRevive\init.sqf"; /* Vor pixLogistic! */
call compile preprocessFileLineNumbers "missionsEnv\init.sqf";
call compile preprocessFileLineNumbers "missionsOpt\init.sqf";
call compile preprocessFileLineNumbers "missionsRev\init.sqf";
call compile preprocessFileLineNumbers "tfr\init.sqf";
[] spawn compile preprocessFileLineNumbers "pixGps\init.sqf";
[] spawn compile preprocessFileLineNumbers "credits\init.sqf";

/* Camera deaktivieren */
waitUntil {!(isNil "pvPixLogisticServerInitialized")};
waitUntil { pvPixLogisticServerInitialized };
cutText ["", "BLACK IN",1];