diag_log format["fnc_aiz_ZoneResume: _this = %1", _this];
waitUntil { aizZoneInitCompleted };
diag_log "ZoneResume: isLoaded";

private["_zoneIndex"];
_zoneIndex = _this select 0;

//==========================================================================================
// _zoneData auslesen
//==========================================================================================
if (isNil format["aizZoneData%1", _zoneIndex]) exitWith	{ [format["No zoneData for zoneIndex %1 found.", _zoneIndex]] call BIS_fnc_error; false; };

aizZoneActiveCounter = aizZoneActiveCounter + 1;
aizZoneActive set [_zoneIndex, aizZoneActiveCounter];
private "_zoneData";
call compile format["_zoneData = aizZoneData%1;", _zoneIndex];

private _campsTown = _zoneData select 0;		// [house, housePosIndex]
private _campsField = _zoneData select 1;		// [position, initialRespawns]
private _checkpoints = _zoneData select 2;		// [position, direction]
private _waypointPool = _zoneData select 3;		// [position]
private _groupCount = _zoneData select 4;
if (_groupCount < 0) then { _groupCount = 0; };

//==========================================================================================
// _campsTown starten
//==========================================================================================
{
	[_zoneIndex, _x, ([] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroupCampTown;	
} foreach _campsTown;

//==========================================================================================
// _campsField starten
//==========================================================================================
{
	[_zoneIndex, _x, ([] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroupCampField;	
} foreach _campsField;

//==========================================================================================
// _checkpoints starten
//==========================================================================================
{
	[_zoneIndex, _x, ([] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroupCheckpoint;	
} foreach _checkpoints;

//==========================================================================================
// _waypointPool starten
//==========================================================================================
for "_i" from 1 to _groupCount do
{
	[_zoneIndex, _waypointPool, 6, ([] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroup;	
};