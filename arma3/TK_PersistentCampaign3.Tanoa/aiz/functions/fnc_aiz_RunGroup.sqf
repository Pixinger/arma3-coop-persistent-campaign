#include "..\..\debugOn.hpp" 
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

waitUntil { aizZoneInitCompleted };

Sleep (random 3);
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_aizZoneActiveIndex", "_waypointPool", "_waypointCount","_unitClassnames"];
private _startPosition = if ((count _this) >= 6) then { _this select 5; } else { _waypointPool call PIX_fnc_RandomElement; };

//================================================================================
// Startbedingungen prüfen
//================================================================================
if (count _waypointPool < 3) exitWith { ERROR_LOG_VAREX("Not enough waypoints for zoneIndex: ", _zoneIndex) false; };
if (count _waypointPool < _waypointCount) then { _waypointCount = count _waypointPool; };

//================================================================================
// Einheiten erstellen. (Alle! Danach wird dann reduziert)
//================================================================================
private _group = [_startPosition, resistance, _unitClassnames] call fnc_aiz_SpawnGroup;
_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";
_group setFormation "STAG COLUMN";
{ 
	_x setSpeedMode "LIMITED"; 
	_x setCombatMode "WHITE"; // YELLOW / RED
	_x setBehaviour "SAFE";
} foreach (units _group);

#ifdef MARKER_ENABLED
//================================================================================
// Marker erstellen
//================================================================================
aizGroupMarkerCounter  = aizGroupMarkerCounter + 1;
private _markerCounter = aizGroupMarkerCounter;
private["_markerNames"];
_markerNames = [];
{ _markerNames pushBack format["%1_%2", format["markerUGroup%1_%2", _zoneIndex, floor(random 999999)], _foreachindex]; } foreach (units _group);
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
#define STATE_EXIT				1
#define STATE_THINKING			2
#define STATE_PREPEARE_WALK 	3
#define STATE_WALKING			4
#define STATE_PREPEARE_GUARD 	5
#define STATE_GUARDING			6
#define STATE_PREPEARE_FIGHT	7
#define STATE_FIGHTING			8

private _validateTimeout = 0;
private _fightTimeout = 0;
private _guardTimeout = 0;
private _walkTimeout = 0;
private _target = [0,0,0];
private _currentPosition = [0,0,0];

private _state = STATE_THINKING;
while { _state != STATE_EXIT } do 
{
	Sleep 2;
	
	_currentPosition = getPos (leader _group);
	
	#ifdef MARKER_ENABLED
	{
		private _mn = _markerNames select _foreachindex;
		_mn setMarkerText format["G|%1", _markerCounter];
		_mn setMarkerPos (getPos _x);
	} foreach units _group;
	#endif

	
	if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith { _state = STATE_EXIT; };
	
	switch (_state) do 
	{
		//###############################################################################################################
		case STATE_THINKING:
		{
			//DEBUG_LOG("STATE_THINKING");
			
			_group setBehaviour "SAFE";
			_group setSpeedMode "LIMITED";
			_group setFormation "COLUMN";

			/*private _decision = [1, 2] call BIS_fnc_randomInt;
			switch (_decision) do
			{
				case 1: { _state = STATE_PREPEARE_WALK; };
				case 2: { _state = STATE_PREPEARE_GUARD; };
			};*/
			_state = STATE_PREPEARE_WALK;
		};
		
		//###############################################################################################################
		case STATE_PREPEARE_FIGHT: 
		{
			//DEBUG_LOG("STATE_PREPEARE_FIGHT");
			if (pixDebug) then { _fightTimeout = time + 10; }
			else { _fightTimeout = time + ([60, 360] call BIS_fnc_randomInt); };
			_state = STATE_FIGHTING;
		};		
		//###############################################################################################################
		case STATE_FIGHTING: 
		{
			//DEBUG_LOG("STATE_FIGHTING");
			if (time > _fightTimeout) exitWith { _state = STATE_THINKING; };
		};
		
		
		//###############################################################################################################
		case STATE_PREPEARE_WALK:
		{
			//DEBUG_LOG("STATE_PREPEARE_WALK");
			// Ziel suchen
			if (pixDebug) then {_target = getPos (leader _group);_target set [0, (_target select 0) + 50];}
			else {_target = _waypointPool call PIX_fnc_RandomElement;};
	
			// Alle alten Wegpunkte löschen
			{ deleteWaypoint _x; } foreach waypoints _group;
			// Zurück zum ersten Wegpunkt gehen
			private _waypoint = _group addWaypoint [_target, 0];
			_waypoint setWaypointBehaviour "SAFE";
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointCompletionRadius 1;
			_waypoint setWaypointSpeed "FULL";
			_waypoint setWaypointFormation "COLUMN";
			
			if (pixDebug) then { _walkTimeout = time + 30;} else { _walkTimeout = time + (5*60);};

			_state = STATE_WALKING;
		};		
		//###############################################################################################################
		case STATE_WALKING:
		{
			//DEBUG_LOG("STATE_WALKING");
			if (behaviour (leader _group) == "COMBAT") exitWith { _state = STATE_PREPEARE_FIGHT; };
			if (((leader _group) distance2D _target) < 20) exitWith { _state = STATE_THINKING; };
			if (time > _walkTimeout) exitWith { _state = STATE_THINKING; };			
		};


		//###############################################################################################################
		case STATE_PREPEARE_GUARD:
		{
			//DEBUG_LOG("STATE_PREPEARE_GUARD");
			if (pixDebug) then { _guardTimeout = time + 10; }
			else { _guardTimeout = time + ([10, 120] call BIS_fnc_randomInt); };
			
			{
				doStop _x;			
				Sleep 0.2;
				_x action ["SitDown", _x];	
			} forEach (units _group);
			
			_state = STATE_GUARDING;
		};		
		//###############################################################################################################
		case STATE_GUARDING:
		{
			//DEBUG_LOG("STATE_GUARDING");
			if (behaviour (leader _group) == "COMBAT") exitWith { _state = STATE_PREPEARE_FIGHT; };
			if (time > _guardTimeout) exitWith 
			{ 
				_state = STATE_THINKING; 	
				{
					_x doMove (getPos _x);
					Sleep 0.2;
				} forEach (units _group);
			};
		};

		
		//###############################################################################################################
		default 
		{
			ERROR_LOG_VAREX("Invalid state for state-machine: _state: ", _state);
			_state = STATE_EXIT;
		};		
	};
	
	//###############################################################################################################
	// Gruppe validieren
	if (time > _validateTimeout) then
	{
		//DEBUG_LOG("Validating group");
		_validateTimeout = time + 10;
		
		// Gefangene, verwundete und tote Einheiten entfernen
		{
			//if ((!alive _x) || {(_x getVariable ["ACE_Captives_isHandcuffed", false])} || {(_x getVariable ["ACE_isUnconscious", false])}) then 
			//{ 	
			//	[_x] join grpNull; 
			//	DEBUG_LOG_VAREX("Unit joined grpNull: ", _x);
			//};

			if (!alive _x) then 
			{ 	
				DEBUG_LOG_VAREX("Unit joined grpNull (not alive): ", _x);
				[_x] join grpNull; 
			}
			else
			{
				if (_x getVariable ["ACE_isUnconscious", false]) then 
				{ 	
					[_x] join grpNull; 
					DEBUG_LOG_VAREX("Unit joined grpNull (is unconscious): ", _x);
				}
				else
				{
					if (_x getVariable ["ACE_Captives_isHandcuffed", false]) then 
					{ 	
						[_x] join grpNull; 
						DEBUG_LOG_VAREX("Unit joined grpNull (is handcuffed): ", _x);
					}
				};
			};
		} foreach (units _group);

		// Wenn die Gruppe leer ist, dann beenden
		if (count (units _group) < 2) exitWith 
		{ 
			{ 
				_x spawn fnc_aiz_TrackFleeUnit; // Einheit im Hintergrund weiter verfolgen und wenn keiner mehr in der Nähe ist, löschen.
				[_x] join grpNull; 
			} foreach (units _group); // Die Restlichen Einheiten auch noch aus der Gruppe entfernen.
			_state = STATE_EXIT; 
		};
	};	
};
DEBUG_LOG("STATE_EXIT");

//================================================================================
// Wenn die Zone noch aktiv UND alle Einheiten tot/gefangen sind, dann holen wir evtl. Unterstüzung.
//================================================================================
if (count (units _group) == 0) then
{
	DEBUG_LOG_VAREX2("Group destroyed: Requesting support(pos/zoneIndex): ", _currentPosition, _zoneIndex);
	private _support = [_currentPosition, cfgAizSupportForceCampSearchRadius] call fnc_aiz_FindCampTownRespawn;
	if (!isNull _support) then
	{
		DEBUG_LOG_VAREX("Support found at CT: ", _support);
		[_zoneIndex, _aizZoneActiveIndex, _waypointPool, _waypointCount, ([] call fnc_aiz_GetRandomInfClassnames), getPos _support] spawn fnc_aiz_RunGroup;
	}
	else
	{
		private _support = [_currentPosition, cfgAizSupportForceCampSearchRadius] call fnc_aiz_FindCampFieldRespawn;
		if (!isNull _support) then
		{
			DEBUG_LOG_VAREX("Support found at CF: ", _support);
			[_zoneIndex, _aizZoneActiveIndex,  _waypointPool, _waypointCount, ([] call fnc_aiz_GetRandomInfClassnames), getPos _support] spawn fnc_aiz_RunGroup;
			deleteVehicle _support;
		}
		else
		{
			// Keine Verstärkung gefunden. Den GruppenCount für diese Zone verringern.
			private "_zoneData";
			call compile format["_zoneData = aizZoneData%1;", _zoneIndex];
			private _groupCount = (_zoneData select 4) - 1;
			_zoneData set [4, _groupCount];	
			DEBUG_LOG_VAR(_zoneData);
			DEBUG_LOG_VAREX2("No Support found. GroupCount decreased to(groupCount/zoneIndex): ", _groupCount, _zoneIndex);
		};
	};
	
	// Artillery Beschuss nach ausgeschalteter Gruppe
	if ((pixDebug) || ([1, 3] call BIS_fnc_randomInt == 1)) then
	{
		[_currentPosition] spawn {
			
			private _currentPosition = _this select 0;

			// Initial Delay
			if (pixDebug) then { Sleep 2; } else { Sleep ([30, 90] call BIS_fnc_randomInt); };
			
			// Warnschuss
			private _radius = 75;
			private _randomPosition = [
				(((_currentPosition select 0) - _radius) + random (_radius*2)),
				(((_currentPosition select 1) - _radius) + random (_radius*2)),
				0];
			// Mortar erzeugen
			createVehicle ["M_Mo_82mm_AT_LG", _randomPosition, [], 0, "NONE"];
			
			// Bombardement
			for "_i" from 0 to ([1, 4] call BIS_fnc_randomInt) do
			{
				// Bombardment Delay
				if (pixDebug) then { Sleep 2; } else { Sleep ([30, 90] call BIS_fnc_randomInt); };
				
				// Rounds
				for "_o" from 0 to ([1, 8] call BIS_fnc_randomInt) do
				{
					// Zufällige Position berechnen
					_randomPosition = [
						(((_currentPosition select 0) - _radius) + random (_radius*2)),
						(((_currentPosition select 1) - _radius) + random (_radius*2)),
						0];
					
					// Mortar erzeugen
					createVehicle ["M_Mo_82mm_AT_LG", _randomPosition, [], 0, "NONE"];
					
					// Warten
					if (pixDebug) then { Sleep 1; } else { Sleep ([1, 5] call BIS_fnc_randomInt); };
				};
			};			
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
//DEBUG_LOG_VAREX("Group deleted. zoneIndex: ", _zoneIndex);