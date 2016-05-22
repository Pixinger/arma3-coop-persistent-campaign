diag_log format["fnc_aiz_ZoneResume: _this = %1", _this];
waitUntil { aizLoaded };
diag_log "ZoneResume: isLoaded";

private["_zoneIndex"];
_zoneIndex = _this select 0;

//==========================================================================================
// _zoneData auslesen
//==========================================================================================
if (isNil format["aizZoneData%1", _zoneIndex]) exitWith	{ [format["No zoneData for zoneIndex %1 found.", _zoneIndex]] call BIS_fnc_error; false; };

aizZoneActive set [_zoneIndex, true];
private "_zoneData";
call compile format["_zoneData = aizZoneData%1;", _zoneIndex];

private _campsTown = _zoneData select 0;		// [[house, housePosIndex], respawns]
private _campsField = _zoneData select 1;		// [position, initialRespawns]
private _checkpoints = _zoneData select 2;		// [position, direction]
private _waypointPool = _zoneData select 3;		// [position]
private _groupCount = _zoneData select 4;

//==========================================================================================
// _campsTown starten
//==========================================================================================
{
	[_zoneIndex, _x, ["O_recon_TL_F", "O_soldierU_AT_F", "O_support_MG_F", "O_spotter_F", "O_diver_F"]] spawn fnc_aiz_RunGroupCampTown;	
} foreach _campsTown;

//==========================================================================================
// _campsField starten
//==========================================================================================
{
	//[_zoneIndex, _x, ["O_recon_TL_F", "O_soldierU_AT_F", "O_support_MG_F", "O_spotter_F", "O_diver_F"]] spawn fnc_aiz_RunGroupCampField;	
} foreach _campsField;

//==========================================================================================
// _checkpoints starten
//==========================================================================================
{
//	[_zoneIndex, _x, ["O_recon_TL_F", "O_soldierU_AT_F", "O_support_MG_F", "O_spotter_F", "O_diver_F"]] spawn fnc_aiz_RunGroupCheckpoint;	
} foreach _checkpoints;
/*
//==========================================================================================
// _waypointPool starten
//==========================================================================================
for "_i" from 1 to _groupCount do
{
	[_zoneIndex, _waypointPool, 5, ["O_recon_TL_F", "O_soldierU_AT_F", "O_support_MG_F", "O_spotter_F", "O_diver_F"]] spawn fnc_aiz_RunGroup;	
};
*/


