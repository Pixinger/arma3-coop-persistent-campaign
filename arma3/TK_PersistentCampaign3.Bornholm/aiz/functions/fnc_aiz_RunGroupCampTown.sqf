waitUntil { aizLoaded };

private["_zoneIndex"];
_zoneIndex = _this select 0;


call compile format["private _runtimeData = aizRuntimeData%1", _zoneIndex];

// _runtimeData = [_campTown, _campField, _checkpoints, _waypoints, _groupCount]



//==========================================================================================
// Marker auslesen
//==========================================================================================
private["_markerName"];
_markerName = format["markerAiz%1", _zoneIndex];
if (markerType _markerName == "") exitWith { diag_log format["ERROR: Marker for zoneIndex %1 not found. Markername should be %2", _zoneIndex, _markerName]; false; }; // ERROR

private["_markerPos"];
_markerPos = markerPos _markerName;
private["_markerSize"];
_markerSize = markerSize _markerName;
private["_markerDir"];
_markerDir = markerDir _markerName;
private["_markerIsRectangle"];
if (markerShape _markerName == "rectangle") then { _markerIsRectangle = true; } else { _markerIsRectangle = false; };


//==========================================================================================
// Variablen definieren
//==========================================================================================
private _geoInfo = [_markerName, 0];

private["_campTown"];
private["_campField"];
private["_campRespawns"];
private["_checkpoints"];
private["_waypoints"];
private["_groupCount"];
_campsTown = [];		// [[house, housePosIndex], respawns]
_campsField = [];		// [position, respawns]
_checkpoints = [];		// [position, direction]
_waypoints = [];		// [position]
_groupCount = 0;


	format["markerAiz%1", _zoneIndex, _iy] setMarkerColor "ColorRed";
