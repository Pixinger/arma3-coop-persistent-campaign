#define REDUCE_DISTANCE 	1000
#define EXPAND_DISTANCE 	800

waitUntil { aizZoneInitCompleted };
diag_log format["fnc_aiz_RunGroupCampField: _this = %1", _this];

if ((count _this) < 3) exitWith { [format["Invalid parameter count. _this=%1", _this]] call BIS_fnc_error; false;};
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_camp", "_unitClassnames"];
_camp params ["_campPosition", "_campRespawns"];

//================================================================================
// aizZoneActiveCounter zwischenspeichern
//================================================================================
private _aizZoneActiveCounter = aizZoneActiveCounter;
if (_aizZoneActiveCounter == 0) exitWith { [format["Zone ist schon wieder inaktiv. _zoneIndex=%1", _zoneIndex]] call BIS_fnc_error; false;};

//================================================================================
// Einheiten erstellen. (Alle! Danach wird dann reduziert)
//================================================================================
private _group = [_campPosition, EAST, _unitClassnames] call fnc_aiz_SpawnGroup;
_group setBehaviour "SAFE";
[_group, _campPosition] call fnc_aiz_GroupTaskDefend;

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
				if ((aizZoneActive select _zoneIndex) != _aizZoneActiveCounter) exitWith 
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
				
				Sleep 10;				
			};
		};
		case STATE_REDUCED: 
		{ 
			while { true } do
			{
				if ((aizZoneActive select _zoneIndex) != _aizZoneActiveCounter) exitWith 
				{
					_state = STATE_EXIT;
				};
				if ([getPos (leader _group), EXPAND_DISTANCE] call fnc_aiz_IsBlueNear) exitWith 
				{ 
					[_group, _unitInfos] call fnc_aiz_GroupExpand;
					[_group, _campPosition] call fnc_aiz_GroupTaskDefend;
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
				if ((aizZoneActive select _zoneIndex) != _aizZoneActiveCounter) exitWith 
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
diag_log format["fnc_aiz_RunGroupCampField%1: Group deleted", _zoneIndex];