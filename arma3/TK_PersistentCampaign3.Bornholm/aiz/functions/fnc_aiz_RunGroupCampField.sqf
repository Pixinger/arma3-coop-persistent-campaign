diag_log format["fnc_aiz_RunGroupCampField: _this = %1", _this];
waitUntil { aizLoaded };

private _zoneIndex = _this select 0;		
private _camp = _this select 1;		// z.B.: [_positionArray, _respawns]





//================================================================================
// Einheiten erstellen
//================================================================================
private _group = [_camp select 0, EAST, 5] call BIS_fnc_spawnGroup;

[_group, _camp select 0] spawn bis_fnc_taskDefend;


//================================================================================
// Warten bis inaktiv
//================================================================================
while { true } do
{
	Sleep 5;
	if (!(aizZoneActive select _zoneIndex)) exitWith {diag_log "inactive 1";diag_log format["%1 %2", aizZoneActive select _zoneIndex, aizZoneActive];};
};

//================================================================================
// Gruppe auflösen
//================================================================================
{ deleteVehicle _x; } foreach (units _group);
{ deleteWaypoint _x; } foreach (waypoints _group);
deleteGroup _group;
diag_log format["RunGroupCheckpoint%1: Gruppe aufgeloest: %2", _zoneIndex, _group];



/*
	File: taskPatrol.sqf
	Author: Joris-Jan van 't Land

	Description:
	Create a random patrol of several waypoints around a given position.

	Parameter(s):
	_this select 0: the group to which to assign the waypoints (Group)
	_this select 1: the position on which to base the patrol (Array)
	_this select 2: the maximum distance between waypoints (Number)
	_this select 3: (optional) blacklist of areas (Array)
	
	Returns:
	Boolean - success flag
*/
