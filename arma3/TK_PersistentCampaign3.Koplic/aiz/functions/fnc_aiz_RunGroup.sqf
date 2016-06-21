#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

#include "..\defines.hpp"
#define REDUCE_DISTANCE 	650
#define EXPAND_DISTANCE 	600

waitUntil { aizZoneInitCompleted };
//diag_log format["fnc_aiz_RunGroup: _this = %1", _this];

Sleep (random RANDOM_START_DELAY);
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_aizZoneActiveIndex", "_waypointPool", "_waypointCount","_unitClassnames"];
private _startPosition = if ((count _this) >= 6) then { _this select 5; } else { _waypointPool call PIX_fnc_RandomElement; };

//================================================================================
// Startbedingungen prüfen
//================================================================================
if (count _waypointPool < 3) exitWith { diag_log format["ERROR: fnc_aiz_RunGroup.sqf: Not enough waypoints for zoneIndex %1 found.", _zoneIndex]; false; };
if (count _waypointPool < _waypointCount) then { _waypointCount = count _waypointPool; };

//================================================================================
// Einheiten erstellen. (Alle! Danach wird dann reduziert)
//================================================================================
private _group = [_startPosition, EAST, _unitClassnames] call fnc_aiz_SpawnGroup;
_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";
_group setFormation "STAG COLUMN";
{ 
	_x setSpeedMode "LIMITED"; 
	_x setCombatMode "WHITE"; // YELLOW / RED
	_x setBehaviour "SAFE";
} foreach (units _group);

//_group setUnitAbility (random 1);	//[_unit,6] call bis_fnc_setRank; //["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];

//================================================================================
// Wegunkte erstellen
//================================================================================
for "_i" from 1 to _waypointCount - 1 do
{
	private ["_wp", "_newPos"];

	private _waypoint = _group addWaypoint [_waypointPool call PIX_fnc_RandomElement, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 20;
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointFormation "STAG COLUMN";
};

// Zurück zum ersten Wegpunkt gehen
private _waypoint = _group addWaypoint [_waypointPool call PIX_fnc_RandomElement, 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 20;
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointFormation "STAG COLUMN";

#ifdef MARKER_ENABLED
//================================================================================
// Marker erstellen
//================================================================================
aizGroupMarkerCounter  = aizGroupMarkerCounter + 1;
private _markerCounter = aizGroupMarkerCounter;
private _markerName = format["markerUGroup%1_%2", _zoneIndex, floor(random 999999)];
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

//================================================================================
// State Machine starten
//================================================================================
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
						_mn setMarkerText format["G|%1", _markerCounter];
						_mn setMarkerPos (getPos _x);
					} foreach units _group;
#endif				
					_unitInfos = [_group] call fnc_aiz_GroupReduce;
					_state = STATE_REDUCED;
				};
				if ([_group] call fnc_aiz_GroupAliveCount < 2) exitWith
				{
					_state = STATE_FLEE;
				};
				
#ifdef MARKER_ENABLED
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["G|EX|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
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
				if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith 
				{
					_state = STATE_EXIT;
				};
				if ([getPos (leader _group), EXPAND_DISTANCE] call fnc_aiz_IsBlueNear) exitWith 
				{ 
					[_group, _unitInfos] call fnc_aiz_GroupExpand;
					_state = STATE_EXPANDED;
				};
				
#ifdef MARKER_ENABLED
				{
					private _mn = _markerNames select _foreachindex;
					_mn setMarkerText format["G|RD|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
					_mn setMarkerPos (getPos _x);
				} foreach units _group;
#endif
				Sleep 5;
			};
		};	
		case STATE_FLEE:
		{ 
			// Da sich die Gruppe nun aufgelöst hat, suchen wir nach Verstärkung
			diag_log format["fnc_aiz_RunGroup: Group destroyed. zoneIndex=%1", _zoneIndex];
			private _laptop = [getPos (leader _group), 1500] call fnc_aiz_FindCampTownRespawn;
			if (!isNull _laptop) then
			{
				// .. Verstärkung aus der Stadt holen
				diag_log format["fnc_aiz_RunGroup: Support from campTown at position=%1", getPos _laptop];
				[_zoneIndex, _aizZoneActiveIndex, _waypointPool, _waypointCount, ([] call fnc_aiz_GetRandomInfClassnames), getPos _laptop] spawn fnc_aiz_RunGroup;
			}
			else
			{
				private _tent = [getPos (leader _group), 1500] call fnc_aiz_FindCampTownRespawn;
				if (!isNull _tent) then
				{
					// .. Verstärkung aus dem Feld holen => Zelt löschen
					diag_log format["fnc_aiz_RunGroup: Support from campField at position=%1", getPos _tent];
					[_zoneIndex, _aizZoneActiveIndex,  _waypointPool, _waypointCount, ([] call fnc_aiz_GetRandomInfClassnames), getPos _tent] spawn fnc_aiz_RunGroup;
					deleteVehicle _tent;
				}
				else
				{
					// Keine Verstärkung gefunden. Den GruppenCount für diese Zone verringern.
					private "_zoneData";
					call compile format["_zoneData = aizZoneData%1;", _zoneIndex];
					private _groupCount = (_zoneData select 4) - 1;
					_zoneData set [4, _groupCount];	
					diag_log format["fnc_aiz_RunGroup: Group destroyed. No support available. GroupCount is now %1.", _groupCount];
				};
			};
			
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
					_mn setMarkerText format["G|FL|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
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
					_mn setMarkerText format["G|EXIT|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
					_mn setMarkerPos (getPos _x);
				} foreach units _group;
#endif
			//diag_log "STATE_EXIT";
			_run = false; // Exit
		};	
		default 
		{ 
			diag_log format["ERROR: fnc_aiz_RunGroup.sqf: Invalid state for state-machine: _state=%1", _state];
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
deleteGroup _group;
diag_log format["fnc_aiz_RunGroup zoneIndex=%-1: Group deleted", _zoneIndex];











