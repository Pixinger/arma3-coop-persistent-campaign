//diag_log format["fnc_aiz_ZoneResume: _this = %1", _this];

params["_zoneIndex","_aizZoneActiveIndex"];
_zoneIndex = _this select 0;

//==========================================================================================
// _zoneData auslesen
//==========================================================================================
if (isNil format["aizZoneData%1", _zoneIndex]) exitWith	{ [format["No zoneData for zoneIndex %1 found.", _zoneIndex]] call BIS_fnc_error; false; };

private "_zoneData";
call compile format["_zoneData = aizZoneData%1;", _zoneIndex];

private _campsTown = _zoneData select 0;		// [house, housePosIndex]
private _campsField = _zoneData select 1;		// [position, initialRespawns]
private _checkpoints = _zoneData select 2;		// [position, direction]
private _waypointPool = _zoneData select 3;		// [position]
private _groupCount = _zoneData select 4;
if (_groupCount < 0) then { _groupCount = 0; };
private _mortarSites = _zoneData select 6;		// [position, direction]

//==========================================================================================
// _campsTown starten
//==========================================================================================
{
	private _count = ([cfgAizGroupSizeMin, cfgAizGroupSizeMax] call BIS_fnc_randomInt) * 2;
	[_zoneIndex, _aizZoneActiveIndex, _x, ([_count] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroupCampTown;	
} foreach _campsTown;

//==========================================================================================
// _campsField starten
//==========================================================================================
{
	private _count = ([cfgAizGroupSizeMin, cfgAizGroupSizeMax] call BIS_fnc_randomInt) * 2;
	[_zoneIndex, _aizZoneActiveIndex, _x, ([_count] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroupCampField;	
} foreach _campsField;

//==========================================================================================
// _checkpoints starten
//==========================================================================================
{
	private _count = ([cfgAizGroupSizeMin, cfgAizGroupSizeMax] call BIS_fnc_randomInt);
	[_zoneIndex, _aizZoneActiveIndex, _x, ([_count] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroupCheckpoint;	
} foreach _checkpoints;

//==========================================================================================
// _mortarSites starten
//==========================================================================================
{
	private _count = ([cfgAizGroupSizeMin, cfgAizGroupSizeMax] call BIS_fnc_randomInt);
	[_zoneIndex, _aizZoneActiveIndex, _x, ([_count] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroupMortar;	
} foreach _mortarSites;

//==========================================================================================
// _waypointPool starten
//==========================================================================================
for "_i" from 1 to _groupCount do
{
	private _count = ([cfgAizGroupSizeMin, cfgAizGroupSizeMax] call BIS_fnc_randomInt);
	[_zoneIndex, _aizZoneActiveIndex, _waypointPool, 6, ([_count] call fnc_aiz_GetRandomInfClassnames)] spawn fnc_aiz_RunGroup;
};