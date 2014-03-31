/* 
	Diese Funktion erstellt eine KI-Gruppe die Unterwasser ein Objekt bewacht.
	
Parameter:
	cfgGroupNames:		Ein Array das die CfgGroups-Namen enthält, die zur Erstellung diese AI-Gruppe verwendet werden können (aus der Config). 					
	zoneIndex:			ZonenIndex der Zone die den Patrol Bereich begrenzt
	centerPosition: 	Die Position die patrolliert werden soll.
	radius: 			Der maximale Umkreis in dem patrolliert werden soll.
	(optional)
	zoneSafetyBorder: 	Sicherheitsabstand zum Rand.
	
Return: 
	GroupInfo Array: [group, vehicles]
	If failed: []
/*-------------------------------------------------------------------*/

if (!isServer) exitWith {[]};

private["_cfgGroupNames"];
_cfgGroupNames = [_this, 0, [], [[]]] call BIS_fnc_param;
if (count _cfgGroupNames == 0) exitwith {["Empty _cfgGroupNames parameter"] call BIS_fnc_error; []};

private["_zoneIndex"];
_zoneIndex = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_centerPosition"];
_centerPosition = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_centerPosition) == "[0,0,0]") exitwith {["Empty position parameter"] call BIS_fnc_error; []};

private["_radius"];
_radius = [_this, 3, 100, [0]] call BIS_fnc_param;
if (_radius < 10) then { _radius = 10; };

private["_zoneSafetyBorder"];
_zoneSafetyBorder = [_this, 4, 25, [0]] call BIS_fnc_param;
if (_zoneSafetyBorder < 0) then { _zoneSafetyBorder = 0; };

/*-------------------------------------------------------------------*/

/* Startpunkt in der Nähe des Objektes suchen */
private["_location"];
_location = [_zoneIndex, _zoneSafetyBorder, _centerPosition, _radius] call PC_fnc_GetRandomLocationZoneWater;
if (str(_location) == "[[0,0,0],0]") exitwith {["Unable to find start location"] call BIS_fnc_error; []};

/* Gruppe erstellen */
private["_groupInfos"];
_groupInfos = [_cfgGroupNames, (_location select 0)] call PC_fnc_SpawnGroup;
if (count _groupInfos == 0) exitwith {["PC_fnc_SpawnGroup failed"] call BIS_fnc_error; []};

/* Das Objekt bewachen */	
[_groupInfos select 0, _zoneIndex, _centerPosition, _radius, _zoneSafetyBorder] call PC_fnc_PatrolObjectWater;

/* Im Debug die Gruppe mit einem Marker tracken */
if (!isDedicated) then { [_groupInfos select 0, true, "ColorYellow","PO"] spawn PC_fnc_TrackGroup; };

_groupInfos