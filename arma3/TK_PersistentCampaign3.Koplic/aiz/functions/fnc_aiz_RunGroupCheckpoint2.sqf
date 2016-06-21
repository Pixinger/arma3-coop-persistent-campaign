#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

#include "..\defines.hpp"

waitUntil { aizZoneInitCompleted };

Sleep (random RANDOM_START_DELAY);
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_aizZoneActiveIndex", "_checkpoint", "_unitClassnames"];
_checkpoint params ["_checkpointPosition", "_checkpointDirection"];

//================================================================================
// Einheiten erstellen
//================================================================================
private _group = [_checkpointPosition, EAST, _unitClassnames] call fnc_aiz_SpawnGroup;
[_group, _checkpointPosition, 50] call fnc_aiz_GroupTaskDefend2;

#ifndef NO_MARKERS
//================================================================================
// Marker erstellen
//================================================================================
aizGroupMarkerCounter  = aizGroupMarkerCounter + 1;
private _markerCounter = aizGroupMarkerCounter;
private["_markerNames"];
_markerNames = [];
{ _markerNames pushBack format["%1_%2", format["markerUCheck%1_%2", _zoneIndex, floor(random 999999)], _foreachindex]; } foreach (units _group);
{
	createMarker [_x, [0,0]];
	_x setMarkerShape "ICON";
	_x setMarkerType "o_inf";
	_x setMarkerSize [0.4, 0.4];
	_x setMarkerColor "ColorRed"; 
	_x setMarkerAlpha 1;
} foreach _markerNames;
#endif

#define STATE_EXIT			0
#define STATE_ACTIVE		1

private _validateTimeout = 0;

private _state = STATE_ACTIVE;
while { _state != STATE_EXIT } do 
{
	Sleep 2;
	
	//================================================================================
	// Gruppe validieren
	if (time > _validateTimeout) then
	{
		//DEBUG_LOG("Validating group");
		_validateTimeout = time + 10;
		
		// Gefangene und tote Einheiten entfernen
		{
			if ((captiveNum _x != 0) || (!alive _x)) then 
			{ 	
				[_x] join grpNull; 
				//DEBUG_LOG_VAREX("Unit joined grpNull: ", _x);
			};
		} foreach (units _group);

		// Wenn die Gruppe leer ist, dann beenden
		if (count (units _group) == 0) exitWith { _state = STATE_EXIT; };
	};		
	
	//================================================================================
	if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith { _state = STATE_EXIT; };		
	
	#ifndef NO_MARKERS
	//================================================================================
	{
		private _mn = _markerNames select _foreachindex;
		_mn setMarkerText format["C|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
		_mn setMarkerPos (getPos _x);
	} foreach units _group;
	//================================================================================
	#endif		
};

//================================================================================
// Checkpoint als Zerstört markieren
//================================================================================
if (count (units _group) == 0) then
{
	diag_log format["fnc_aiz_RunGroupCheckpoint: Checkpoint destroyed. zoneIndex=%1 position=%2", _zoneIndex, _checkpointPosition];
	_checkpoint set [0, []];
};

//================================================================================
// So gut aufräumen wie es geht
//================================================================================
#ifndef NO_MARKERS
{ deleteMarker _x; } foreach  _markerNames;
#endif
{ deleteVehicle _x; } foreach (units _group);
{ deleteWaypoint _x; } foreach (waypoints _group);
deleteGroup _group;
//DEBUG_LOG("Group deleted");