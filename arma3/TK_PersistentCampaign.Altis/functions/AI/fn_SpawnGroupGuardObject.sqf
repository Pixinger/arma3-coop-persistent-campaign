/* 
	Diese Funktion erstellt eine Gruppe (siehe PC_fnc_SpawnGroup).
	Die Gruppe wird angewiesen einen bestimmten Bereich zu bewachen.
	
Parameter:
	cfgGroupNames:	Ein Array das die CfgGroups-Namen enthält, die zur Erstellung diese AI-Gruppe verwendet werden können (siehe PC_fnc_SpawnGroup).
	position:		Die Position an der die Grupper erstellt werden soll.	
	
Return: 
	GroupInfo Array: [group, vehicles]
	If failed: []
/*-------------------------------------------------------------------*/
if (!isServer) exitWith {[]};

private["_cfgGroupNames"];
_cfgGroupNames = [_this, 0, [], [[]]] call BIS_fnc_param;
if (count _cfgGroupNames == 0) exitwith {["Empty _cfgGroupNames parameter"] call BIS_fnc_error; []};

private["_position"];
_position = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_position) == "[0,0,0]") exitwith {["Empty position parameter"] call BIS_fnc_error; []};

/*-------------------------------------------------------------------*/

/* Gruppe erstellen */
private["_groupInfos"];
_groupInfos = [_cfgGroupNames, _position] call PC_fnc_SpawnGroup;
if (count _groupInfos == 0) exitwith {["PC_fnc_SpawnGroup failed"] call BIS_fnc_error; []};

/* Das Objekt bewachen */	
[_groupInfos select 0, _position] call PC_fnc_GuardObject;

/* Im Debug die Gruppe mit einem Marker tracken */
if (!isDedicated) then { [_groupInfos select 0, true, "ColorGreen","GO"] spawn PC_fnc_TrackGroup; };

_groupInfos