#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

#include "..\defines.hpp"
//==========================================================================================
// DEFINES
//==========================================================================================
#define WAYPOINT_COUNT_PER_ZONE			20

#define MIN_CAMPSTOWN_PER_ZONE			1
#define MAX_CAMPSTOWN_PER_ZONE			1
#define CHANCE_CAMPSTOWN_PER_ZONE		1

#define MIN_CAMPSFIELD_PER_ZONE			1
#define MAX_CAMPSFIELD_PER_ZONE			2
#define CHANCE_CAMPSFIELD_PER_ZONE		1.5

#define MIN_CHECKPOINTS_PER_ZONE		1
#define MAX_CHECKPOINTS_PER_ZONE		3
#define CHANCE_CHECKPOINTS_PER_ZONE		1.5

//==========================================================================================
// THIS
//==========================================================================================
params["_zoneIndex", "_zoneDataSet"];

//==========================================================================================
// Marker auslesen
//==========================================================================================
private _markerName = format["markerAiz%1", _zoneIndex];
if (markerType _markerName == "") exitWith { [format["Marker for zoneIndex %1 not found. Markername should be %2", _zoneIndex, _markerName]] call BIS_fnc_error; false; };

private _markerPos = markerPos _markerName;
private _markerSize = markerSize _markerName;
private _markerDir = markerDir _markerName;
private _markerIsRectangle = if (markerShape _markerName == "rectangle") then { true; } else { false; };

//==========================================================================================
// Variablen definieren
//==========================================================================================
private _campsTown = [];		// [house, housePosIndex]
private _campsField = [];		// [position, respawns]
private _checkpoints = [];		// [position, direction]
private _groupCount = 0;
private _intelCount = 0;
private _geoInfo = [_markerName, 0];

//------------------------------------------------------------------------------------------
// WaypointPool erstellen
//------------------------------------------------------------------------------------------
private _waypointPool = [];		// [position]
for "_i" from 1 to WAYPOINT_COUNT_PER_ZONE do
{
	_randomPosition = [_geoInfo, [true, false, 50]] call fnc_aiz_GetRandomPosition; // [position]
	if (count _randomPosition > 0) then
	{
		_waypointPool pushBack _randomPosition;
			
#ifdef MARKER_ENABLED
		private["_markerNameWp"];
		_markerNameWp = createMarker [format["markerWP%1_%2", _zoneIndex, floor(random 999999)], _randomPosition];
		_markerNameWp setMarkerShape "ICON";
		_markerNameWp setMarkerType "Waypoint";
		_markerNameWp setMarkerSize [0.2, 0.2];
		_markerNameWp setMarkerColor "ColorBlack"; 
		_markerNameWp setMarkerAlpha 0.5;			
#endif
	};
};

//==========================================================================================
// Daten generieren oder aus DB übernehmen
//==========================================================================================
//diag_log format["AIZ Init-Zone %1", _zoneIndex];

//------------------------------------------------------------------------------------------
// CAMP-TOWN laden
//------------------------------------------------------------------------------------------
if (count _zoneDataSet > 0) then
{		 
	{
		private _house = nearestObject [_x select 0, "House"];
		if (!isNull _house) then
		{
			_campsTown pushBack [_house, _x select 1]; // [[house, buildingPosIndex], ..., [house, buildingPosIndex]];
		};		
	} forEach (_zoneDataSet select 0); // [[housePosition, buildingPosIndex], ..., [housePosition, buildingPosIndex]];		
}
else
{	
	// Nach einer Position für CAMP-TOWN suchen
	if (random CHANCE_CAMPSTOWN_PER_ZONE <= 1) then
	{
		private _randomPosition = [0,0,0];
		private _campsTownCountPerZone = [MIN_CAMPSTOWN_PER_ZONE, MAX_CAMPSTOWN_PER_ZONE] call BIS_fnc_randomInt;
		for [{_x= 0},{_x < _campsTownCountPerZone},{_x = _x + 1}] do 
		{
			_randomPosition = [_geoInfo, [true, [10, 100]]] call fnc_aiz_GetRandomPositionHouse; // [house, buildingPosIndex]
			if (count _randomPosition > 0) then
			{		
				_campsTown pushBack _randomPosition;// [house, buildingPosIndex]
				//diag_log format["INFO: Location for CampTown found. ZoneIndex=%1", _zoneIndex];
			}
			else
			{
				WARN_LOG_VAREX("No location for CampTown found. ZoneIndex=", _zoneIndex);
			};
		};
	}
	else
	{
		//diag_log format["INFO: No CampTown for ZoneIndex=%1 required.", _zoneIndex];
	};
};

//------------------------------------------------------------------------------------------
// CAMP-FIELD laden
//------------------------------------------------------------------------------------------
if (count _zoneDataSet > 1) then
{
	_campsField  = (_zoneDataSet select 1); 		// [[position, respawns], ..., [position, respawns]];
}
else
{
	// Nach einer Position für CAMP-FIELD suchen
	if (random CHANCE_CAMPSFIELD_PER_ZONE <= 1) then
	{
		private _randomPosition = [0,0,0];
		private _campsFieldCountPerZone = [MIN_CAMPSFIELD_PER_ZONE, MAX_CAMPSFIELD_PER_ZONE] call BIS_fnc_randomInt;
		for [{_x= 0},{_x < _campsFieldCountPerZone},{_x = _x + 1}] do 
		{
			_randomPosition = [_geoInfo, [5]] call fnc_aiz_GetRandomPositionField; // [position]
			if (count _randomPosition > 0) then
			{			
				_campsField pushBack [_randomPosition, 6 + (random 6)]; // [position, respawnCount]
				//diag_log format["INFO: Location for CampField found. ZoneIndex=%1", _zoneIndex];
			}
			else
			{
				WARN_LOG_VAREX("No location for CampField found. ZoneIndex=", _zoneIndex);
			};
		};
	}
	else
	{
		//diag_log format["INFO: No CampField for ZoneIndex=%1 required.", _zoneIndex];
	};
};

//------------------------------------------------------------------------------------------
// Checkpoints laden
//------------------------------------------------------------------------------------------
if (count _zoneDataSet > 2) then
{
	private _tmpCheckpoints = (_zoneDataSet select 2); 		// [[position, direction], ..., [position, direction]];
	// Inaktive Checkpoints NICHT aus der Liste übernehmen.
	{ if (count (_x select 0) != 0) then { _checkpoints pushBack _x; };	} foreach _tmpCheckpoints;
}
else
{
	// Nach Checkpoints für diese Zone suchen
	if (random CHANCE_CHECKPOINTS_PER_ZONE <= 1) then
	{
		private _randomPosition = [0,0,0];
		private _checkpointsCountPerZone = [MIN_CHECKPOINTS_PER_ZONE, MAX_CHECKPOINTS_PER_ZONE] call BIS_fnc_randomInt;
		for [{_x= 0},{_x < _checkpointsCountPerZone},{_x = _x + 1}] do 
		{
			_randomPosition = [_geoInfo] call fnc_aiz_GetRandomPositionRoad; // [position, direction]
			if (count _randomPosition > 0) then
			{
				_checkpoints pushBack _randomPosition; // [position, direction]
				//diag_log format["INFO: Location for Checkpoint found. ZoneIndex=%1", _zoneIndex];
			}
			else
			{
				WARN_LOG_VAREX("No location for Checkpoint found. ZoneIndex=", _zoneIndex);
			};
		};
	}
	else
	{
		//diag_log format["INFO: No Checkpoints for ZoneIndex=%1 required.", _zoneIndex];
	};	
};

//------------------------------------------------------------------------------------------
// GroupCount laden
//------------------------------------------------------------------------------------------
if (count _zoneDataSet > 3) then
{
	_groupCount  = (_zoneDataSet select 3); 		
}
else
{
	// Festlegen wieviele Gruppen es geben soll
	_groupCount = floor (count _waypointPool / (4.5 + random 2.5));
};
if ((_groupCount < 1) && (count _waypointPool > 3)) then { _groupCount = 1; };
if (_zoneIndex == 12) then { _groupCount = 1; };
if (_groupCount < 0) then { _groupCount = 0; };	

//------------------------------------------------------------------------------------------
// IntelCount laden
//------------------------------------------------------------------------------------------
if (count _zoneDataSet > 4) then
{
	_intelCount	= (_zoneDataSet select 4); 
}
else
{
	_intelCount = 0;
};
if (_intelCount < 0) then { _intelCount = 0; };
if (_intelCount > 3) then { _intelCount = 3; };

//==========================================================================================
// Zone überprüfen, ob mit diesen Daten gestartet werden kann - oder nicht.
//==========================================================================================
private _triggerRequired = false;

//==========================================================================================
// Camps-Town initialisieren
//==========================================================================================
{
	_triggerRequired = true;	
	[_zoneIndex, _x] spawn fnc_aiz_BuildCampTown;
} foreach _campsTown;

//==========================================================================================
// Camps-Field initialisieren
//==========================================================================================
{
	_triggerRequired = true;
	[_zoneIndex, _x] spawn fnc_aiz_BuildCampField;
} foreach _campsField;

//==========================================================================================
// Checkpoints initialisieren
//==========================================================================================
{
	_triggerRequired = true;
	[_zoneIndex, _x] spawn fnc_aiz_BuildCheckpoint;
} foreach _checkpoints;

//==========================================================================================
// Gruppen initialisieren
//==========================================================================================
if (_groupCount > 0) then
{
	_triggerRequired = true;
};

//==========================================================================================
// IntelCount initialisieren (Achtung! Erst wenn "aizZoneData%1" oberhalb gesetzt wurde.
//==========================================================================================
if ((_triggerRequired) && (_intelCount > 0)) then
{
	INFO_LOG_VAREX("Intels for this zone: ", _intelCount);

	for "_i" from 1 to _intelCount do
	{
		[_zoneIndex] call fnc_aiz_IntelReveal;
	};
	
};
// Nach dem nun alle Geheimnisse verraten wurden, wird der IntelCount wieder auf null gesetzt.
_intelCount = 0;

//==========================================================================================
// Trigger erstellen
//==========================================================================================
if (_triggerRequired) then
{	
	call compile format["aizZoneData%1 = [_campsTown, _campsField, _checkpoints, _waypointPool, _groupCount, _intelCount];", _zoneIndex];

	private _radiusExtension = if (pixDebug) then { 0 } else { 1000 };
	private["_trigger"];
	_trigger = createTrigger ["EmptyDetector", _markerPos, true];				
	_trigger setTriggerType "NONE";
	_trigger setTriggerArea [(_markerSize select 0) + _radiusExtension, (_markerSize select 1) + _radiusExtension, _markerDir, _markerIsRectangle];
	_trigger setTriggerActivation ["WEST", "PRESENT", true];
	_trigger setTriggerStatements ["this", format["[%1] call fnc_aiz_OnTriggerActivated;", _zoneIndex], format["[%1] call fnc_aiz_OnTriggerDeactivated;", _zoneIndex]];

	_markerName setMarkerAlpha 0;
	_markerName SetMarkerColor "ColorRed";	
	
	INFO_LOG_VAREX("Zone is ONLINE. zoneIndex=", _zoneIndex);
}
else
{
	_markerName setMarkerAlpha 0.2;
	_markerName SetMarkerColor "ColorGreen";
	INFO_LOG_VAREX("Zone is OFFLINE/COMPLETED. zoneIndex=", _zoneIndex);
};