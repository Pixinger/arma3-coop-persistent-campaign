#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

waitUntil { aizZoneInitCompleted };

Sleep (random 3);
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_aizZoneActiveIndex", "_camp", "_unitClassnames"];
_camp params ["_house", "_housePosIndex"]; 

//================================================================================
// Einheiten erstellen
//================================================================================
private _group = [(getPos _house), resistance, _unitClassnames] call fnc_aiz_SpawnGroup;
[_group, (getPos _house), 50] call fnc_aiz_GroupTaskDefend;

#ifdef MARKER_ENABLED
//================================================================================
// Marker erstellen
//================================================================================
aizGroupMarkerCounter  = aizGroupMarkerCounter + 1;
private _markerCounter = aizGroupMarkerCounter;
private["_markerNames"];
_markerNames = [];
{ _markerNames pushBack format["%1_%2", format["markerUTown%1_%2", _zoneIndex, floor(random 999999)], _foreachindex]; } foreach (units _group);
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

private _autoEngange = if ([1, 3] call BIS_fnc_randomInt == 1) then { true } else { false };
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
			if ((!alive _x) || {(_x getVariable ["ACE_Captives_isHandcuffed", false])}) then 
			{ 	
				[_x] join grpNull; 
				//DEBUG_LOG_VAREX("Unit joined grpNull: ", _x);
			};
		} foreach (units _group);

		// Wenn die Gruppe leer ist, dann beenden
		if (count (units _group) == 0) exitWith { _state = STATE_EXIT; };

		//================================================================================
		// Auto Engage
		if (_autoEngange) then
		{
			//private _countEnemy = player countEnemy (allPlayers);
			//if (_countEnemy > 0) then
			private _enemy = (leader _group) findNearestEnemy (leader _group);
			if (!isNull _enemy) then
			{
				INFO_LOG("Auto engage executed!");
				_autoEngange = false;
				
				_group setBehaviour "COMBAT";
				_group setCombatMode "RED";
				[units _group] commandTarget _enemy;
				{ if ([1, 3] call BIS_fnc_randomInt == 1) then { _x commandFire _enemy }; } foreach (units _group);			
			};		
		};	
	};		
	
	//================================================================================
	if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith { _state = STATE_EXIT; };		
	
	#ifdef MARKER_ENABLED
	//================================================================================
	{
		private _mn = _markerNames select _foreachindex;
		_mn setMarkerText format["T|%1|%2|%3", _markerCounter, _foreachindex, _zoneIndex];
		_mn setMarkerPos (getPos _x);
	} foreach units _group;
	//================================================================================
	#endif		
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
//DEBUG_LOG("Group deleted");