#define REDUCE_DISTANCE 	650
#define EXPAND_DISTANCE 	600

waitUntil { aizZoneInitCompleted };
diag_log format["fnc_aiz_RunGroup: _this = %1", _this];

if ((count _this) < 4) exitWith { [format["Invalid parameter count. _this=%1", _this]] call BIS_fnc_error; false;};
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_waypointPool", "_waypointCount","_unitClassnames"];
private _startPosition = if ((count _this) >= 5) then { _this select 4; } else { _waypointPool call fnc_aiz_RandomElement; };

//================================================================================
// Startbedingungen prüfen
//================================================================================
if (count _waypointPool < 3) exitWith { [format["Not enough waypoints for zoneIndex %1 found.", _zoneIndex]] call BIS_fnc_error; false; };
if (count _waypointPool < _waypointCount) then { _waypointCount = count _waypointPool; };

//================================================================================
// Einheiten erstellen. (Alle! Danach wird dann reduziert)
//================================================================================
private _group = [_startPosition, EAST, _unitClassnames] call fnc_aiz_SpawnGroup;
_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";
_group setFormation "STAG COLUMN";
//_group setUnitAbility (random 1);	//[_unit,6] call bis_fnc_setRank; //["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];

//================================================================================
// Wegunkte erstellen
//================================================================================
for "_i" from 1 to _waypointCount - 1 do
{
	private ["_wp", "_newPos"];

	private _waypoint = _group addWaypoint [_waypointPool call fnc_aiz_RandomElement, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 20;
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointFormation "STAG COLUMN";
};

// Zurück zum ersten Wegpunkt gehen
private _waypoint = _group addWaypoint [_waypointPool call fnc_aiz_RandomElement, 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCompletionRadius 20;

//================================================================================
// Marker erstellen
//================================================================================
private["_markerName"];
_markerName = createMarker [format["markerUT%1_%2", _zoneIndex, floor(random 999999)], (getPos (leader _group))];
_markerName setMarkerShape "ICON";
_markerName setMarkerType "o_inf";
_markerName setMarkerSize [0.4, 0.4];
_markerName setMarkerColor "ColorRed"; 
_markerName setMarkerAlpha 1;

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
			_markerName setMarkerText "exp";
			while { true } do
			{
				if (!(aizZoneActive select _zoneIndex)) exitWith 
				{
					_state = STATE_EXIT;
				};
				if (!([(getPos (leader _group)), REDUCE_DISTANCE] call fnc_aiz_IsBlueNear)) exitWith 
				{ 
					_unitInfos = [_group] call fnc_aiz_GroupReduce;
					_state = STATE_REDUCED;
				};
				if ([_group] call fnc_aiz_GroupAliveCount < 2) exitWith
				{
					_state = STATE_FLEE;
				};
				
				_markerName setMarkerPos (getPos (leader _group));
				Sleep 10;				
			};
		};
		case STATE_REDUCED: 
		{ 
			_markerName setMarkerText "red";
			while { true } do
			{
				if (!(aizZoneActive select _zoneIndex)) exitWith 
				{
					_state = STATE_EXIT;
				};
				if ([getPos (leader _group), EXPAND_DISTANCE] call fnc_aiz_IsBlueNear) exitWith 
				{ 
					[_group, _unitInfos] call fnc_aiz_GroupExpand;
					_state = STATE_EXPANDED;
				};
				
				_markerName setMarkerPos (getPos (leader _group));
				Sleep 5;
			};
		};	
		case STATE_FLEE:
		{ 
			_markerName setMarkerText "flee";
			// Da sich die Gruppe nun aufgelöst hat, suchen wir nach Verstärkung
			diag_log format["fnc_aiz_RunGroup: Group destroyed. zoneIndex=%1", _zoneIndex];
			private _laptop = [getPos (leader _group), 1500] call fnc_aiz_FindCampLaptop;
			if (!isNull _laptop) then
			{
				// .. Verstärkung aus der Stadt holen
				diag_log format["fnc_aiz_RunGroup: Support from campTown at position=%1", getPos _laptop];
				[_zoneIndex, _waypointPool, _waypointCount, ([] call fnc_aiz_GetRandomInfClassnames), getPos _laptop] spawn fnc_aiz_RunGroup;
			}
			else
			{
				private _tent = [getPos (leader _group), 1500] call fnc_aiz_FindCampTownRespawn;
				if (!isNull _tent) then
				{
					// .. Verstärkung aus dem Feld holen => Zelt löschen
					diag_log format["fnc_aiz_RunGroup: Support from campField at position=%1", getPos _tent];
					[_zoneIndex, _waypointPool, _waypointCount, ([] call fnc_aiz_GetRandomInfClassnames), getPos _tent] spawn fnc_aiz_RunGroup;
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
				if (!(aizZoneActive select _zoneIndex)) exitWith 
				{
					_state = STATE_EXIT;
				};
				if (!([(getPos (leader _group)), REDUCE_DISTANCE] call fnc_aiz_IsBlueNear)) exitWith 
				{ 
					_state = STATE_EXIT;
				};
				
				_markerName setMarkerPos (getPos (leader _group));
				Sleep 10;
			};
		};
		case STATE_EXIT:
		{ 
			_markerName setMarkerText "exit";
			diag_log "STATE_EXIT";
			_run = false; // Exit
		};	
		default 
		{ 
			[format["Invalid state for state-machine: _state=%1", _state]] call BIS_fnc_error;
			_run = false; // Emergency exit
		};
	};
};

//================================================================================
// So gut aufräumen wie es geht
//================================================================================
{ deleteVehicle _x; } foreach (units _group);
{ deleteWaypoint _x; } foreach (waypoints _group);
deleteGroup _group;
deleteMarker _markerName;
diag_log format["fnc_aiz_RunGroup%1: Group deleted", _zoneIndex];











