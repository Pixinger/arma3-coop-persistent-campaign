/* 
	Diese Funktion löscht alle Einheiten einer Gruppe. 
		Optinal werden alle defekten Fahrzeuge in die Logistik eingebunden.
	
Parameter:
	cfgGroupNames:	Ein Array das die CfgGroups-Namen enthält, die zur Erstellung diese AI-Gruppe verwendet werden können (aus der Config). 					
	zoneIndex: Der ZonenIndex der Zone die patrolliert werden soll.
	(optional)zoneSafetyBorder: Sicherheitsabstand zum Rand.
	
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

private["_zoneSafetyBorder"];
_zoneSafetyBorder = [_this, 2, 25, [0]] call BIS_fnc_param;
if (_zoneSafetyBorder < 0) then { _zoneSafetyBorder = 0; };

/*-------------------------------------------------------------------*/

/* Spawn Position bestimmen */
private["_spawnLocation"];
_spawnLocation = [_zoneIndex, _zoneSafetyBorder] call PC_fnc_GetRandomLocationZoneField;

/* Gruppe erstellen */
private["_groupInfos"];
_groupInfos = [_cfgGroupNames, (_spawnLocation select 0)] call PC_fnc_SpawnGroup;
if (count _groupInfos == 0) exitwith {["PC_fnc_SpawnGroup failed"] call BIS_fnc_error; []};

/* Das Objekt bewachen */	
[_groupInfos select 0, _zoneIndex, _zoneSafetyBorder] call PC_fnc_PatrolZone;

/* Im Debug die Gruppe mit einem Marker tracken */
if (!isDedicated) then { [_groupInfos select 0, true, "ColorBlue","PZ"] spawn PC_fnc_TrackGroup; };

_groupInfos