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
/* Parameter (3): ReverseAttack */
pixParamReverseAttack = (paramsArray select 2);
diag_log format["pixParamReverseAttack: %1", pixParamReverseAttack];
/* Parameter (4): Date */
_paramValues = [[(floor(random(12))) + 1, (floor(random(28))) + 1], [7,1],[3,1],[10,1],[1,1]]; /* {"Zufall", "Sommer", "Frühling", "Herbst", "Winter"}; */
pixParamDate = _paramValues select (paramsArray select 3);
diag_log format["pixParamDate: %1", pixParamDate];
/* Parameter (5): Daytime */
if ((paramsArray select 4) == 0) then { pixParamTime = (floor(random(23))) + 1; } else { pixParamTime = (paramsArray select 4) - 1; };
diag_log format["pixParamTime: %1", pixParamTime];
/* Parameter (6): Weather */
pixParamWeather = (paramsArray select 5); 
diag_log format["pixParamWeather: %1", pixParamWeather];
/* Parameter (7): Mission Factor */
_paramValues = [0.5,1,1.5,2];
pixParamMissionFactor = _paramValues select (paramsArray select 6);
diag_log format["pixParamMissionFactor: %1", pixParamMissionFactor];

/*-----------------------------------------------*/
cutText ["Initialization...", "BLACK FADED",1];

call compileFinal preprocessFileLineNumbers "FAR_revive\FAR_revive_init.sqf";
call compile preprocessFileLineNumbers "pixZones\init.sqf";
call compile preprocessFileLineNumbers "pixLogistic\init.sqf";

/* Warten bis das Briefing beendet wurde */
Sleep .1;

/* Warten bis das Briefing beendet wurde */
player setvariable ["BIS_nocoreconversations",true];

/* Module initialisieren */
call compile preprocessFileLineNumbers "initPlayer.sqf";
call compile preprocessFileLineNumbers "missionsEnv\init.sqf";
call compile preprocessFileLineNumbers "missionsOpt\init.sqf";
call compile preprocessFileLineNumbers "missionsRev\init.sqf";
call compile preprocessFileLineNumbers "pixDate\init.sqf";
call compile preprocessFileLineNumbers "pixWeather\init.sqf";
call compile preprocessFileLineNumbers "tfr\init.sqf";
[] spawn compile preprocessFileLineNumbers "pixGps\init.sqf";
[] spawn compile preprocessFileLineNumbers "credits\init.sqf";

/* Camera deaktivieren */
waitUntil {!(isNil "pvPixLogisticServerInitialized")};
waitUntil { pvPixLogisticServerInitialized };
cutText ["", "BLACK IN",1];