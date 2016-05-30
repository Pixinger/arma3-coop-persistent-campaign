setviewdistance 1500;
setObjectViewDistance 1500;
setTerrainGrid 25;

tf_no_auto_long_range_radio = true;
TF_give_personal_radio_to_regular_soldier = true;
TF_terrain_interception_coefficient = 0;
TF_give_microdagr_to_soldier = false;

waituntil {!isnil "bis_fnc_init"};
enableSaving [false, false];
enableTeamSwitch false;

//-----------------------------------------------
// Debug
pixDebug = false;
if (isServer && !isDedicated) then { pixDebug = true; };

//-----------------------------------------------
// Parameter (0): TFR-Muted while dead 
//pixParamTFARMutedOnDeath = (paramsArray select 0); //0=aus 1=an 
//diag_log format["INFO: pixParamTFARMutedOnDeath: %1", pixParamTFARMutedOnDeath];

// Wenn "HeadlessClientAvailable" nil ist, dann gibt es keinen. Sonst ist "HeadlessClientAvailable" automatisch TRUE. Dafür sorgt die Funktion: fn_HeadlessClientInit.sqf
if (isNil "HeadlessClientAvailable") then 
{	
	HeadlessClientAvailable = false;
	diag_log "No headless-client detected";
};

// Lokal für jeden Rechner prüfen, ob hier (auf dieser Maschine) Headless Code ausgeführt werden soll, oder nicht.
ExecuteHeadlessCode = false;
if ((HeadlessClientAvailable && !hasInterface && !isServer) || (!HeadlessClientAvailable && isServer)) then { ExecuteHeadlessCode = true; };
diag_log format["ExecuteHeadlessCode: %1", ExecuteHeadlessCode];

call compile preprocessFileLineNumbers "sub_config.sqf";
call compile preprocessFileLineNumbers "sub_compile.sqf";
call compile preprocessFileLineNumbers "sub_init.sqf";