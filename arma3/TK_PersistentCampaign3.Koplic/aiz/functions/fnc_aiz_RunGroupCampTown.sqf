#include "..\defines.hpp"
#define REDUCE_DISTANCE 	1000
#define EXPAND_DISTANCE 	800

waitUntil { aizZoneInitCompleted };
//diag_log format["fnc_aiz_RunGroupCampTown: _this = %1", _this];

Sleep (random RANDOM_START_DELAY);
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_aizZoneActiveIndex", "_camp", "_unitClassnames"];
_camp params ["_house", "_housePosIndex"]; 

//================================================================================
// Einheiten erstellen. (Alle! Danach wird dann reduziert)
//================================================================================
private _group = [(getPos _house), EAST, _unitClassnames] call fnc_aiz_SpawnGroup;
_group setBehaviour "SAFE";
[_group, (getPos _house)] call fnc_aiz_GroupTaskDefend;

#ifndef NO_MARKERS
//================================================================================
// Marker erstellen
//================================================================================
aizGroupMarkerCounter  = aizGroupMarkerCounter + 1;
private _markerCounter = aizGroupMarkerCounter;
private _markerName = format["markerUTown%1_%2", _zoneIndex, floor(random 999999)];
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
					#ifndef NO_MARKERS
					{
						private _mn = _markerNames select _foreachindex;
						_mn setMarkerText format["T|%1", _markerCounter];
						_mn setMarkerPos (getPos _x);
					} foreach units _group;
					#endif
					
					_unitInfos = [_group] call fnc_aiz_GroupReduce;
					[_group, (getPos _house)] call fnc_aiz_GroupTaskDefend;
					_state = STATE_REDUCED;
				};
				if ([_group] call fnc_aiz_GroupAliveCount < 2) exitWith
				{
					_state = STATE_FLEE;
				};
				
				#ifndef NO_MARKERS
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["T|EX|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
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
				#ifndef NO_MARKERS
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["T|RD|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
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
					[_group, (getPos _house)] call fnc_aiz_GroupTaskDefend;
					_state = STATE_EXPANDED;
				};
				
				Sleep 5;
			};
		};	
		case STATE_FLEE:
		{ 
			// Hier sollte der Flucht Code rein. 
			// Da mir noch Zeit fehlt, begehen die Einheiten einfach Selbstmord.
			{
				_x setDamage 1;
			} foreach units _group;

			// Warten und prüfen
			while { true } do
			{
				#ifndef NO_MARKERS
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["T|FL|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
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
			#ifndef NO_MARKERS
			{
				private _mn = _markerNames select _foreachindex;
				_mn setMarkerText format["T|EXIT|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
				_mn setMarkerPos (getPos _x);
			} foreach units _group;
			#endif
			_run = false; // Exit
		};	
		default 
		{ 
			diag_log format["ERROR: fnc_aiz_RunGroupCampTown.sqf: Invalid state for state-machine: _state=%1", _state];
			_run = false; // Emergency exit
		};
	};
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
diag_log format["fnc_aiz_RunGroupCampTown%1: Group deleted", _zoneIndex];