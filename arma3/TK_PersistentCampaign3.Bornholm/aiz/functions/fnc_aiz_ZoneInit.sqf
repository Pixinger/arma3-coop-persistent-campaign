private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_zoneParameters"];
_zoneParameters = [];
if  (count _this >= 2) then { _zoneParameters = _this select 1; };
//==========================================================================================
// Marker auslesen
//==========================================================================================
private["_markerName"];
_markerName = format["markerAiz%1", _zoneIndex];
if (markerType _markerName == "") exitWith { [format["Marker for zoneIndex %1 not found. Markername should be %2", _zoneIndex, _markerName]] call BIS_fnc_error; false; };

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
private["_waypointPool"];
private["_groupCount"];
_campsTown = [];		// [[house, housePosIndex], respawns]
_campsField = [];		// [position, respawns]
_checkpoints = [];		// [position, direction]
_waypointPool = [];		// [position]
_groupCount = 0;

//==========================================================================================
// Waypoints generieren oder aus DB übernehmen
//==========================================================================================
if (count _zoneParameters == 0) then
{
	//------------------------------------------------------------------------------------------
	// Nach einer Position für CAMP-TOWN suchen
	//------------------------------------------------------------------------------------------
	private _randomPosition = [_geoInfo, [true, [20, 100]]] call fnc_aiz_GetRandomPositionHouse;
	if (count _randomPosition > 0) then
	{		
		_campsTown pushBack [_randomPosition, 10]; 
	};
	
	
	//------------------------------------------------------------------------------------------
	// Nach einer Position für CAMP-FIELD suchen
	//------------------------------------------------------------------------------------------
	_randomPosition = [_geoInfo, [5]] call fnc_aiz_GetRandomPositionField;
	if (count _randomPosition > 0) then
	{			
		_campsField pushBack [_randomPosition, 20]; 
	};
	
	//------------------------------------------------------------------------------------------
	// Nach Checkpoints für diese Zone suchen
	//------------------------------------------------------------------------------------------
	_randomPosition = [_geoInfo] call fnc_aiz_GetRandomPositionRoad;
	if (count _randomPosition > 0) then
	{
		_checkpoints pushBack _randomPosition;
	};


	//------------------------------------------------------------------------------------------
	// Nach Wegpunkten für diese Zone suchen
	//------------------------------------------------------------------------------------------
	for "_i" from 1 to 20 do
	{
		_randomPosition = [_geoInfo, [true, false, 50]] call fnc_aiz_GetRandomPosition;
		if (count _randomPosition > 0) then
		{
			_waypointPool pushBack _randomPosition;
				
			private["_markerName"];
			_markerName = createMarkerLocal [format["markerWP%1_%2", _zoneIndex, random 999999], _randomPosition];
			_markerName setMarkerShapeLocal "ICON";
			_markerName setMarkerTypeLocal "o_inf";
			_markerName setMarkerSizeLocal [0.2, 0.2];
			_markerName setMarkerColorLocal "ColorBlack"; 
			_markerName setMarkerAlphaLocal 0.5;
				
		};
	};
	
	//------------------------------------------------------------------------------------------
	// Festlegen wieviele Gruppen es geben soll
	//------------------------------------------------------------------------------------------
	_groupCount = floor (count _waypointPool / 5);
} 
else
{
	_campsTown  = _zoneParameters select 0;
	_campsField = _zoneParameters select 1;
	_checkpoints = _zoneParameters select 2;	
	_waypointPool = _zoneParameters select 3;
	_groupCount = _zoneParameters select 4;	
};

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
// Trigger erstellen
//==========================================================================================
if (_triggerRequired) then
{	
	call compile format["aizWaypointPoolZone%1 = _waypointPool;", _zoneIndex];

	private["_trigger"];
	_trigger = createTrigger ["EmptyDetector", _markerPos, true];				
	_trigger setTriggerType "NONE";
	_trigger setTriggerArea [_markerSize select 0, _markerSize select 1, _markerDir, _markerIsRectangle];
	_trigger setTriggerActivation ["WEST", "PRESENT", true];
	_trigger setTriggerStatements ["this", format["[%1] call fnc_aiz_OnTriggerActivated;", _zoneIndex], format["[%1] call fnc_aiz_OnTriggerDeactivated;", _zoneIndex]];

	_markerName setMarkerAlphaLocal 0;
	_markerName SetMarkerColor "ColorRed";
}
else
{
	_markerName SetMarkerColor "ColorGreen";
};