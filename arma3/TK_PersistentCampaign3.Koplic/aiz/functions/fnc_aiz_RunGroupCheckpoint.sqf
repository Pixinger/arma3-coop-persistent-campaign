#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

#include "..\defines.hpp"
#define REDUCE_DISTANCE 	1000
#define EXPAND_DISTANCE 	800

waitUntil { aizZoneInitCompleted };
//diag_log format["fnc_aiz_RunGroupCheckpoint: _this = %1", _this];

Sleep (random RANDOM_START_DELAY);
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_aizZoneActiveIndex", "_checkpoint", "_unitClassnames"];
_checkpoint params ["_checkpointPosition", "_checkpointDirection"];

//================================================================================
// Einheiten erstellen. (Alle! Danach wird dann reduziert)
//================================================================================
private _group = [_checkpointPosition, EAST, _unitClassnames] call fnc_aiz_SpawnGroup;
_group setBehaviour "SAFE";
[_group, _checkpointPosition] call fnc_aiz_GroupTaskDefend;

#ifdef MARKER_ENABLED
//================================================================================
// Marker erstellen
//================================================================================
aizGroupMarkerCounter  = aizGroupMarkerCounter + 1;
private _markerCounter = aizGroupMarkerCounter;
private _markerName = format["markerUCheck%1_%2", _zoneIndex, floor(random 999999)];
private["_markerNames"];
_markerNames = [];
{ _markerNames pushBack format["%1_%2", _markerName, _foreachindex]; } foreach (units _group);
{
	createMarker [_x, [0,0]];
	_x setMarkerShape "ICON";
	_x setMarkerType "o_inf";
	_x setMarkerSize [0.4, 0.4];
	_x setMarkerColor "ColorRed"; 
	_x setMarkerAlpha 1;
} foreach _markerNames;
#endif

#define STATE_REDUCED	1
#define STATE_EXPANDED	2
#define STATE_FLEE		3
#define STATE_EXIT		4
private _state = STATE_EXPANDED;
private _unitInfos = [];
private _run = true;
while { _run } do 
{
	switch (_state) do 
	{
		case STATE_EXPANDED: 
		{ 
			while { true } do
			{

				if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith 
				{
					_state = STATE_EXIT;
				};
				if (!([(getPos (leader _group)), REDUCE_DISTANCE] call fnc_aiz_IsBlueNear)) exitWith 
				{ 
					#ifdef MARKER_ENABLED
					{
						private _mn = _markerNames select _foreachindex;
						_mn setMarkerText format["C|%1", _markerCounter];
						_mn setMarkerPos (getPos _x);
					} foreach units _group;
					#endif
					_unitInfos = [_group] call fnc_aiz_GroupReduce;
					[_group, _checkpointPosition] call fnc_aiz_GroupTaskDefend;
					_state = STATE_REDUCED;
				};
				if ([_group] call fnc_aiz_GroupAliveCount < 2) exitWith
				{
					_state = STATE_FLEE;
				};
				
				#ifdef MARKER_ENABLED
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["C|EX|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
					_mn setMarkerPos (getPos _x);
				} foreach units _group;
				#endif
				Sleep 10;				
			};
		};
		case STATE_REDUCED: 
		{ 
			while { true } do
			{
				#ifdef MARKER_ENABLED
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["C|RD|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
					_mn setMarkerPos (getPos _x);
				} foreach units _group;
				#endif

				if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith 
				{
					_state = STATE_EXIT;
				};
				if ([getPos (leader _group), EXPAND_DISTANCE] call fnc_aiz_IsBlueNear) exitWith 
				{ 
					[_group, _unitInfos] call fnc_aiz_GroupExpand;
					[_group, _checkpointPosition] call fnc_aiz_GroupTaskDefend;
					_state = STATE_EXPANDED;
				};
				
				Sleep 5;
			};
		};	
		case STATE_FLEE:
		{ 
			// Checkpoint als Zerstört markieren
			diag_log format["fnc_aiz_RunGroupCheckpoint: Checkpoint destroyed. zoneIndex=%1 position=%2", _zoneIndex, _checkpointPosition];
			_checkpoint set [0, []];
			
			// Hier sollte der Flucht Code rein. 
			// Da mir noch Zeit fehlt, begehen die Einheiten einfach Selbstmord.
			{
				_x setDamage 1;
			} foreach units _group;

			// Warten und prüfen
			while { true } do
			{
				#ifdef MARKER_ENABLED
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["C|FL|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
					_mn setMarkerPos (getPos _x);
				} foreach units _group;
				#endif

				if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith 
				{
					_state = STATE_EXIT;
				};
				if (!([(getPos (leader _group)), REDUCE_DISTANCE] call fnc_aiz_IsBlueNear)) exitWith 
				{ 
					_state = STATE_EXIT;
				};
				
				Sleep 10;
			};
		};
		case STATE_EXIT:
		{ 
			#ifdef MARKER_ENABLED
			{
				private _mn = _markerNames select _foreachindex;
				_mn setMarkerText format["C|EXIT-|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
				_mn setMarkerPos (getPos _x);
			} foreach units _group;
			#endif
			diag_log "STATE_EXIT";
			_run = false; // Exit
		};	
		default 
		{ 
			diag_log format["ERROR: fnc_aiz_RunGroupCheckpoint.sqf: Invalid state for state-machine: _state=%1", _state];
			_run = false; // Emergency exit
		};
	};
};

//================================================================================
// So gut aufräumen wie es geht
//================================================================================
#ifdef MARKER_ENABLED
{ deleteMarker _x; } foreach  _markerNames;
#endif
{ deleteVehicle _x; } foreach (units _group);
{ deleteWaypoint _x; } foreach (waypoints _group);
deleteGroup _group;
diag_log format["RunGroupCheckpoint%1: Group deleted", _zoneIndex];