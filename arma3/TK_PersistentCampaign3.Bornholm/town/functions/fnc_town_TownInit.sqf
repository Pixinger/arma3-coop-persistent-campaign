//==========================================================================================
// DEFINES
//==========================================================================================
#define WAYPOINT_COUNT_PER_ZONE			20

//==========================================================================================
// THIS
//==========================================================================================
params["_townIndex", "_dataSet"];

//==========================================================================================
// Marker auslesen
//==========================================================================================
private _markerName = format["markerTown%1", _townIndex];
if (markerType _markerName == "") exitWith { [format["Marker for _townIndex %1 not found. Markername should be %2", _townIndex, _markerName]] call BIS_fnc_error; false; };

private _markerPos = markerPos _markerName;
private _markerSize = markerSize _markerName;
private _markerDir = markerDir _markerName;
private _markerIsRectangle = if (markerShape _markerName == "rectangle") then { true; } else { false; };

//==========================================================================================
// Variablen definieren
//==========================================================================================
private _supplies = 0;

//==========================================================================================
// Daten generieren oder aus DB übernehmen
//==========================================================================================
if (count _dataSet > 0) then
{
	// Supplies aus der Datenbank übernehmen.
	_supplies = _dataSet select 0;
};

//==========================================================================================
// Trigger erstellen
//==========================================================================================
call compile format["townData%1 = [_supplies];", _townIndex];

private _radiusExtension = if (pixDebug) then { 0 } else { 1000 };
private["_trigger"];
_trigger = createTrigger ["EmptyDetector", _markerPos, true];				
_trigger setTriggerType "NONE";
_trigger setTriggerArea [(_markerSize select 0) + _radiusExtension, (_markerSize select 1) + _radiusExtension, _markerDir, _markerIsRectangle];
_trigger setTriggerActivation ["WEST", "PRESENT", true];
_trigger setTriggerStatements ["this", format["[%1] call fnc_town_OnTriggerActivated;", _townIndex], format["[%1] call fnc_town_OnTriggerDeactivated;", _townIndex]];

_markerName setMarkerAlpha 0.5;
_markerName SetMarkerColor "ColorBlack";